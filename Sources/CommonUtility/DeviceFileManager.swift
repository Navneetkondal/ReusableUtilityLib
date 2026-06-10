

import Foundation

public actor DeviceFileManager {
    
    public static let shared = DeviceFileManager()
    
    /**
     •  Note: This function returns the directory path for the specified directory and domain mask.
     
     */
    public func getDirectoryPath(for directory: FileManager.SearchPathDirectory = .documentDirectory, in domainMask: FileManager.SearchPathDomainMask = .userDomainMask) -> URL? {
        return FileManager.default.urls(for: directory, in: domainMask).first
    }
    
    /**
     - Note: This will return temporary file path.
     */
    private func temporaryFileURL(fileName: String) -> URL {
        return URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true).appendingPathComponent(fileName)
    }
    
    /**
     - Parameter data is in Data Form , fileName with extension
     - Requires: All are required
     - Note: This will save the data in the document directory.
     */
    public func saveTemporaryData(data: Data, fileName: String) -> URL{
        let url = temporaryFileURL(fileName: fileName)
        do{
            try data.write(to: url, options: .atomic)
        } catch{
            LoggerUtils.logError(error.localizedDescription)
        }
        return url
    }
    
    /**
     - Note: This will delete file with URL from temporary memory.
     */
    public func deleteTemporaryFile(url: URL) {
        do{
            try FileManager.default.removeItem(at: url)
        } catch{
            LoggerUtils.logError(error.localizedDescription)
        }
    }
    
    /**
     - Parameter url: The URL of the file.
     - Note: This function checks if the file exists at the given URL.
     */
    public func isfileExists(withURL url: URL) -> Bool {
        return FileManager.default.fileExists(atPath: url.path)
    }
    
    /**
     - Parameter pathURL: The URL of the directory.
     - Note: This function checks if the directory exists at the given URL.
     */
    public func isDirectoryExists( path pathURL: URL) -> Bool {
        return FileManager.default.fileExists(atPath: (pathURL.path))
    }
    
    /**
     - Parameter withURL: The URL of the file.
     - Note: This function removes the file if it exists at the given URL.
     */
    public func removeFileIfExist(withURL: URL){
        if FileManager.default.fileExists(atPath: withURL.path){
            do{
                try FileManager.default.removeItem(at: withURL)
            }catch let error {
                LoggerUtils.logError(error.localizedDescription)
            }
        }
    }
    
    /**
     - Parameter pathURL: The URL of the directory.
     - Note: This function creates a new directory at the given URL.
     */
    public func createDirectory(pathURL: URL){
        if !self.isDirectoryExists(path: pathURL){
            do{
                try FileManager.default.createDirectory(atPath: (pathURL.path), withIntermediateDirectories: false, attributes: nil)
            } catch{
                LoggerUtils.logError(error.localizedDescription)
            }
        }
    }
}

// MARK: - Write Data in File DB
extension DeviceFileManager {
    /**
     - Parameter data: The data to be encoded and written.
     - Parameter pathTo: The URL where the data should be written.
     - Note: This function encodes the data and writes it to the specified URL.
     */
    public func writeFileWithEncoder<T: Codable>(_ data: T, pathTo: URL) {
        do {
            let encoder = JSONEncoder()
            try encoder.encode(data).write(to: pathTo)
        } catch {
            LoggerUtils.logError(error.localizedDescription)
        }
    }
    
    /**
     - Parameter url: The URL where the dictionary should be written.
     - Parameter dictData: The dictionary data to be written.
     - Note: This function writes the dictionary data to the specified URL.
     */
    public func writeDictInFile(with url: URL, dictData: [String: Any]) {
        if let theJSONData = try? JSONSerialization.data(withJSONObject: dictData, options: .fragmentsAllowed),
           let theJSONText = String(data: theJSONData, encoding: .utf8) {
            do {
                try theJSONText.write(to: url, atomically: true, encoding: .utf8)
            } catch {
                LoggerUtils.logError(error.localizedDescription)
            }
        }
    }
    
    /**
     - Parameter url: The URL where the data should be written.
     - Parameter dictData: The data to be written.
     - Note: This function writes the data to the specified URL.
     */
    public func writeDictInFile(with url: URL, dictData: Any) {
        if let theJSONData = try? JSONSerialization.data(withJSONObject: dictData, options: .fragmentsAllowed),
           let theJSONText = String(data: theJSONData, encoding: .utf8) {
            do {
                try theJSONText.write(to: url, atomically: true, encoding: .utf8)
            } catch {
                LoggerUtils.logError(error.localizedDescription)
            }
        }
    }
}

// MARK: - Read and Convert DB Json Data into Model Object
extension DeviceFileManager {
    /**
     - Parameter url: The URL of the file.
     - Parameter type: The type of the model object.
     - Note: This function reads the JSON data from the file and converts it into a model object.
     */
    public func returnModelObjFromFile<T: Codable>(_ url: URL, type: T.Type) -> T? {
        if let data = FileManager.default.contents(atPath: url.path) {
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                return try decoder.decode(type.self, from: data)
            } catch {
                LoggerUtils.logError(error.localizedDescription)
            }
        }
        return nil
    }
}
