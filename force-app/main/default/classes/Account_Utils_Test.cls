@IsTest
public with sharing class Account_Utils_Test {

    @TestSetup
    static void criarBaseDados(){
        Account acc = new Account();
        acc.Name = 'Conta teste';
        acc.Type = 'Customer - Direct';
        acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente Prata').getRecordTypeId();
        insert acc;
    }


    @IsTest
    static void getAccountRecordTypeId_Test(){
        // Testa o método getAccountRecordTypeId da classe Account_Utils
        Account_Utils contaUtils = new Account_Utils();

        // Chama o método para obter o RecordTypeId do tipo de registro 'Cliente Prata'
        Id recordTypeId = contaUtils.getAccountRecordTypeId('Cliente Prata');

        // Verifica se o RecordTypeId não é nulo
        System.assertNotEquals(null, recordTypeId);
    }

    @IsTest
    static void getAccountByType_Test(){
        // Testa o método getAccountByType da classe Account_Utils
        Account_Utils contaUtils = new Account_Utils();

        // Chama o método para obter contas do tipo 'Customer - Direct'
        List<Account> contas = contaUtils.getAccountByType('Customer - Direct');

        // Verifica se a lista não é nula e contém pelo menos uma conta
        System.assertNotEquals(null, contas);
        System.assertNotEquals(0, contas.size());

        // Adicione mais verificações específicas conforme necessário
    }

    @IsTest
    static void updateAccountType_Test(){
        // Testa o método updateAccountType da classe Account_Utils
        Account_Utils contaUtils = new Account_Utils();

        // Cria uma conta para atualizar o tipo
        Account acc = [SELECT Id, Type FROM Account LIMIT 1];
        String novoTipo = 'Novo Tipo';
        contaUtils.updateAccountType(acc.Id, novoTipo);

        // Recupera a conta atualizada
        Account accAtualizada = [SELECT Id, Type FROM Account WHERE Id = :acc.Id LIMIT 1];

        // Verifica se o tipo foi atualizado corretamente
        System.assertEquals(novoTipo, accAtualizada.Type);
    }

    @IsTest
    static void deleteAccountById_Test(){
        // Testa o método deleteAccountById da classe Account_Utils
        Account_Utils contaUtils = new Account_Utils();

        // Cria uma conta para excluir
        Account acc = [SELECT Id FROM Account LIMIT 1];
        contaUtils.deleteAccountById(acc.Id);

        // Tenta recuperar a conta excluída
        Account accExcluida = [SELECT Id FROM Account WHERE Id = :acc.Id LIMIT 1];

        // Verifica se a conta foi excluída corretamente
        System.assertEquals(null, accExcluida);
    }

    @IsTest
    static void countAccountsByType_Test(){
        // Testa o método countAccountsByType da classe Account_Utils
        Account_Utils contaUtils = new Account_Utils();

        // Obtém o número de contas do tipo 'Customer - Direct'
        Integer count = contaUtils.countAccountsByType('Customer - Direct');

        // Verifica se o número de contas é maior que zero
        System.assertNotEquals(0, count);
    }

    @IsTest
    static void getAllAccounts_Test(){
        // Testa o método getAllAccounts da classe Account_Utils
        Account_Utils contaUtils = new Account_Utils();

        // Obtém todas as contas
        List<Account> allAccounts = contaUtils.getAllAccounts();

        // Verifica se a lista não é nula e contém pelo menos uma conta
        System.assertNotEquals(null, allAccounts);
        System.assertNotEquals(0, allAccounts.size());
    }

    @IsTest
    static void isAccountActive_Test(){
        // Testa o método isAccountActive da classe Account_Utils
        Account_Utils contaUtils = new Account_Utils();

        // Cria uma conta ativa
        Account accAtiva = new Account(Name='Conta Ativa', IsActive=true);
        insert accAtiva;

        // Cria uma conta inativa
        Account accInativa = new Account(Name='Conta Inativa', IsActive=false);
        insert accInativa;

        // Verifica se a conta ativa é considerada ativa
        System.assertEquals(true, contaUtils.isAccountActive(accAtiva.Id));

        // Verifica se a conta inativa não é considerada ativa
        System.assertEquals(false, contaUtils.isAccountActive(accInativa.Id));
    }
}
