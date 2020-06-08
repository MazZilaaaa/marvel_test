import CryptoKit
import Foundation

/// Hash MD5
struct MD5 {
    let publicKey: String
    let privateKey: String
    let date: Date
    
    /// Получаем hash для запросов
    func makeHashValue() -> String {
        let hash = makeTimeStampString() + privateKey + publicKey
        
        guard let data = hash.data(using: .utf8) else {
            return ""
        }
        let md5 = Insecure.MD5.hash(data: data)
        
        return md5.description.replacingOccurrences(of: "MD5 digest: ", with: "")
    }
    
    /// Получаем время в виде строки
    func makeTimeStampString() -> String {
        String(Int64(date.timeIntervalSince1970 * 1000))
    }
}
