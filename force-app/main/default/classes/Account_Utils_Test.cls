@IsTest
public with sharing class Account_Utils_Test {

    @TestSetup
    static void criarBaseDados(){
        // ... (código de setup existente)
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
    static void getUniqueAccountTypes_Test(){
        // Testa o método getUniqueAccountTypes da classe Account_Utils
        Account_Utils contaUtils = new Account_Utils();

        // Cria duas contas com tipos diferentes
        Account acc1 = new Account(Name='Conta1', Type='Tipo1');
        Account acc2 = new Account(Name='Conta2', Type='Tipo2');

        insert new List<Account>{acc1, acc2};

        // Obtém a lista de tipos de conta únicos
        List<String> uniqueTypes = contaUtils.getUniqueAccountTypes();

        // Verifica se a lista contém os tipos esperados
        System.assert(uniqueTypes.contains('Tipo1'));
        System.assert(uniqueTypes.contains('Tipo2'));
        System.assertEquals(2, uniqueTypes.size());
    }
}
