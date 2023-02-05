public struct BrowsrLib {
    public init() {
        fetchResults{ (successArray) in
            print(successArray)
        }
    }
    func fetchResults(completion: @escaping ([API.Types.Response.Organization]) -> Void){
        
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
