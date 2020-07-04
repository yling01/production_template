import optparse

def getPhiPsi(pdb_file):
    fi= open(pdb_file)
    index = []
    for line in fi:
        if len(line) < 20:
            continue
        line = line.split()
        if line[1] in ["C", "N", "CA"]:
            index.append(line[2])
    fi.close()

    index_Psi = index + [index[0]]

    index_Phi = [index[-1]] + index

    assert len(index_Psi) == len(index_Psi)

    Phi = []
    Psi = []
    for i in range(0, len(index_Psi), 3):
        if i + 4 > len(index_Psi):
            break
        Phi.append(index_Phi[i:i + 4])
        Psi.append(index_Psi[i:i + 4])
    return Phi, Psi

def write_PhiPsi(Phi, Psi):
    with open("PhiPsi.ndx", "w+") as fo:
        fo.write("[ Phi ]\n")
        for i in range(len(Phi)):
            fo.write(",".join(Phi[i]))
            fo.write("\n")
        fo.write("[ Psi ]\n")
        for j in range(len(Psi)):
            fo.write(",".join(Psi[j]))
            fo.write("\n")

def write_bemeta(Phi, Psi, fileName):
    assert len(Psi) == len(Psi)
    numRes = len(Psi)
    with open(fileName, "w+") as fo:
        rep_counter = 0
        cv_counter = 0
        fo.write("RANDOM_EXCHANGES\n\n")
        for i in range(numRes):
            fo.write("#Rep%d; Res%d:phi/psi\n" % (rep_counter, i + 1))
            fo.write("cv%d: TORSION ATOMS=%s\n" % (cv_counter, ",".join(Phi[i])))
            cv_counter += 1
            fo.write("cv%d: TORSION ATOMS=%s\n\n" % (cv_counter, ",".join(Psi[i])))
            cv_counter += 1
            rep_counter += 1
        for j in range(numRes):
            fo.write("#Rep%d; Res%d:psi/Res%d:phi\n" % (rep_counter, j + 1, (j + 1) % numRes + 1))
            fo.write("cv%d: TORSION ATOMS=%s\n" % (cv_counter, ",".join(Psi[j])))
            cv_counter += 1
            fo.write("cv%d: TORSION ATOMS=%s\n\n" % (cv_counter, ",".join(Phi[(j + 1) % numRes])))
            cv_counter += 1
            rep_counter += 1
        cv = []
        for k in range(0, cv_counter, 2):
            cv.append("{cv%d,cv%d}" % (k, k + 1))
        cv += ["{cv0,cv1}"] * 5
        fo.write("metad: METAD ...\n    ARG=@replicas:{%s}\n" % ",".join(cv))
        height = ["0.1"] * rep_counter + ["0.0"] * 5
        fo.write("    HEIGHT=@replicas:{%s}" % ",".join(height))
        fo.write("\n    SIGMA=0.31416,0.31416\n    PACE=2000\n    FILE=HILLS\n")
        grid_min = ["{-pi,-pi}"] * (numRes * 2 + 5)
        grid_max = ["{pi,pi}"] * (numRes * 2 + 5)
        fo.write("    GRID_MIN=@replicas:{%s}\n" % ",".join(grid_min))
        fo.write("    GRID_MAX=@replicas:{%s}\n" % ",".join(grid_max))
        fo.write("    GRID_WFILE=BIAS_GRID\n    GRID_WSTRIDE=2000\n...\n")
        fo.write("\nPRINT ARG=@replicas:{%s} FILE=COLVAR STRIDE=500\n\nENDPLUMED" % ",".join(cv))
if __name__ == "__main__":
    parser = optparse.OptionParser()
    parser.add_option('--gro', dest = 'gro', default = '')
    parser.add_option('--writeNDX', dest = 'writeNDX', default = 'False')
    parser.add_option('--bemetaName', dest = 'fileName', default ='bemeta.dat')
    (options, args) = parser.parse_args()
    gro = options.gro
    fileName = options.fileName
    if options.writeNDX[0].upper() == 'F':
        writeNDX = False
    else:
        writeNDX = True
    while not gro:
        gro = input("Enter the name of the gro file:\n")

    Phi, Psi = getPhiPsi(gro)
    write_bemeta(Phi, Psi, fileName)
    if writeNDX:
        write_PhiPsi(Phi, Psi)
