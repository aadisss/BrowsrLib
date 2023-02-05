public typealias Organization = API.Types.Response.Organization
public struct BrowsrLib {
    public init(completion: @escaping ([API.Types.Response.Organization]) -> Void) {
        fetchResults { (array) in
        let sortedArray = array.sorted(by: { $0.login < $1.login })
        completion(sortedArray)
        }
      }
   public func fetchResults(completion: @escaping ([API.Types.Response.Organization]) -> Void){
        
        API.Client.shared
            .get(.search) { (result: Result<[API.Types.Response.Organization], API.Types.Error>) in
                
                switch result {
                case .success(let success):
                    completion(success)
                    break
                case .failure(let failure):
                    print(failure)
                    break
                    
                }
                
            }
        
    }
    
}
