public with sharing class Account_Utils {

    public Id getAccountRecordTypeId(String nameRecordType){
        // Retorna o ID do tipo de registro de conta buscando pelo nome passado por parâmetro
        Id AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get(nameRecordType).getRecordTypeId();
        return AccountRecordTypeId;
    }

    public List<Account> getAccountByType(String type){
        // Retorna uma lista de contas pelo tipo passado por parâmetro
        List<Account> lstAccount = [SELECT Id, Type FROM Account WHERE Type = :type];
        return lstAccount;
    }

    public void updateAccountType(String accountId, String newType){
        // Atualiza o tipo de uma conta com base no ID da conta fornecido
        Account accToUpdate = [SELECT Id FROM Account WHERE Id = :accountId LIMIT 1];
        if (accToUpdate != null) {
            accToUpdate.Type = newType;
            update accToUpdate;
        }
    }

    public void deleteAccountById(String accountId){
        // Exclui uma conta com base no ID da conta fornecido
        Account accToDelete = [SELECT Id FROM Account WHERE Id = :accountId LIMIT 1];
        if (accToDelete != null) {
            delete accToDelete;
        }
    }

    public Integer countAccountsByType(String type){
        // Retorna o número de contas pelo tipo passado por parâmetro
        Integer count = [SELECT COUNT() FROM Account WHERE Type = :type];
        return count;
    }

    public List<Account> getAllAccounts(){
        // Retorna uma lista de todas as contas
        List<Account> allAccounts = [SELECT Id, Name FROM Account];
        return allAccounts;
    }
}
