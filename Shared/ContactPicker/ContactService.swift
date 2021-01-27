//
//  ContactService.swift
//  ContactList_Test
//
//  Created by Michael Craun on 1/23/21.
//

import Contacts
import Combine

fileprivate protocol ContactKeyEnabled {
    var descriptor: CNKeyDescriptor { get }
}

class ContactService {
    
    static let shared = ContactService()
    
    private var contactStore: CNContactStore?
    
    func group(_ contacts: [Contact], method: SortOption = .alphabeticalByFamilyName) -> [ContactGroup] {
        
        return method.group(contacts)
        
    }
    
    func fetch(with keys: [Key] = Key.allCases) -> [Contact] {
        
        do {
            
            var contacts: [CNContact] = []
            
            let request = CNContactFetchRequest(keysToFetch: keys.map({ $0.descriptor }))
            
            try contactStore?.enumerateContacts(with: request) { contact, stop in
                contacts.append(contact)
            }
            
            return contacts.map({ Contact(contact: $0)  })
            
        } catch {
            
            print("ContactService - \(#function) encountered an error:", error.localizedDescription)
            requestPermission()
            return fetch(with: keys)
            
        }
        
    }
    
    func requestPermission() {
        
        contactStore = CNContactStore()
        contactStore?.requestAccess(for: .contacts, completionHandler: { success, error in
            if let error = error {
                print("ContactService - \(#function) encountered an error:", error.localizedDescription)
            }
        })
        
    }
    
    /// - TODO: Add options to filter contacts; might be refactored into requiredKeys property
    enum FilterOption {
        
        
        
    }

    enum Key: String, ContactKeyEnabled, CaseIterable {

        // Contact Identification
        case identifier
        case propertyAttribute
        case type

        // Birthday
        case birthday
        case otherDates
        case gregorianBirthday

        // Work
        case departmentName
        case jobTitle
        case organizationName
        case phoeneticOrganizationName

        // Addresses
        case emailAddresses
        case instantMessageAddresses
        case postalAddresses
        case urlAddresses

        // Name
        case familyName
        case givenName
        case middleName
        case namePrefix
        case nameSuffix
        case nickname
        case phoneticFamilyName
        case phoneticGivenName
        case phoneticMiddleName
        case previousFamilyName

        // Phone
        case phoneNumbers

        // Social Profiles
        case socialProfiles

        // Images
        case imageData
        case imageDataAvailable
        case thumnailData

        // Relationships
        case realtions

        var descriptor: CNKeyDescriptor {
            switch self {
            case .identifier: return CNContactIdentifierKey as CNKeyDescriptor
            case .propertyAttribute: return CNContactPropertyAttribute as CNKeyDescriptor
            case .type: return CNContactTypeKey as CNKeyDescriptor
            case .birthday: return CNContactBirthdayKey as CNKeyDescriptor
            case .otherDates: return CNContactDatesKey as CNKeyDescriptor
            case .gregorianBirthday: return CNContactNonGregorianBirthdayKey as CNKeyDescriptor
            case .departmentName: return CNContactDepartmentNameKey as CNKeyDescriptor
            case .jobTitle: return CNContactJobTitleKey as CNKeyDescriptor
            case .organizationName: return CNContactOrganizationNameKey as CNKeyDescriptor
            case .phoeneticOrganizationName: return CNContactPhoneticOrganizationNameKey as CNKeyDescriptor
            case .emailAddresses:  return CNContactEmailAddressesKey as CNKeyDescriptor
            case .instantMessageAddresses: return CNContactInstantMessageAddressesKey as CNKeyDescriptor
            case .postalAddresses: return CNContactPostalAddressesKey as CNKeyDescriptor
            case .urlAddresses: return CNContactUrlAddressesKey as CNKeyDescriptor
            case .familyName: return CNContactFamilyNameKey as CNKeyDescriptor
            case .givenName: return CNContactGivenNameKey as CNKeyDescriptor
            case .middleName: return CNContactMiddleNameKey as CNKeyDescriptor
            case .namePrefix: return CNContactNamePrefixKey as CNKeyDescriptor
            case .nameSuffix: return CNContactNameSuffixKey as CNKeyDescriptor
            case .nickname: return CNContactNicknameKey as CNKeyDescriptor
            case .phoneticFamilyName: return CNContactPhoneticFamilyNameKey as CNKeyDescriptor
            case .phoneticGivenName: return CNContactPhoneticGivenNameKey as CNKeyDescriptor
            case .phoneticMiddleName: return CNContactPhoneticMiddleNameKey as CNKeyDescriptor
            case .previousFamilyName: return CNContactPreviousFamilyNameKey as CNKeyDescriptor
            case .phoneNumbers: return CNContactPhoneNumbersKey as CNKeyDescriptor
            case .socialProfiles: return CNContactSocialProfilesKey as CNKeyDescriptor
            case .imageData: return CNContactImageDataKey as CNKeyDescriptor
            case .imageDataAvailable: return CNContactImageDataAvailableKey as CNKeyDescriptor
            case .thumnailData: return CNContactThumbnailImageDataKey as CNKeyDescriptor
            case .realtions: return CNContactRelationsKey as CNKeyDescriptor
            }
        }
        
    }
    
    enum ServiceError: Error {
        case notPermitted
    }
    
    enum SortOption {
        
        case alphabeticalByFamilyName
        
        var sortingMethod: (key: Key, method: String) {
            switch self {
            case .alphabeticalByFamilyName: return (.familyName, "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
            }
        }
        
        func group(_ contacts: [Contact]) -> [ContactGroup] {
            var grouped: [ContactGroup] = []
            
            for char in sortingMethod.method {
                
                switch sortingMethod.key {
                case .familyName:
                    let matches = contacts
                        .filter({ $0.familyName.first == char })
                        .sorted(by: { $0.familyName < $1.familyName })
                    
                    if matches.count > 0 {
                        let group = ContactGroup(
                            contacts: matches,
                            id: String(char))
                        grouped.append(group)
                    }
                default:
                    break
                }
                
            }
            
            return grouped
        }
        
    }
    
}
