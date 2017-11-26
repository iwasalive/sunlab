Configuration MyFile {
    File MyFile {
        DestinationPath = "C:\MyDSCMAnagedFile.txt"
        Ensure = "Present"
        Type = "File"
        Contents = "DSC Rocks"
    }
}