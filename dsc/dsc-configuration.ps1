configuration MyFile {
    File MyFile {
        DestinationPath = "c:\MyDSCManagedFile.txt"
        Ensure = "Present"
        Type = "File"
        Contents = "DSC Rocks!"
    }
}