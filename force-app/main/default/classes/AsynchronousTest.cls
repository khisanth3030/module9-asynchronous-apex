/*
 * AsynchronousTest Class Description:
 * 
 * This test class provides test methods for various asynchronous operations in Salesforce:
 * 
 * 1. nextStepFuture_testUpdateAllNextStep: 
 *    - This test is designed for the NextStepFuture class. Students should insert their method from the NextStepFuture class within the specified area.
 *    - This test creates test accounts and opportunities and checks if the NextStep fields are correctly updated.
 * 
 * 2. nextStepFuture_createDealAndUpdateRole: 
 *    - Tests the creation of a big opportunity deal and updates the user role name.
 * 
 * 3. nextStepQueueable_testEnqueueJob: 
 *    - Tests the enqueue operation and execution of the NextStepQueueable class.
 *    - Validates if the NextStep fields in Account and Opportunity are set to null after execution.
 * 
 * 4. nextStepBatch_testUpdateAllNextStep: 
 *    - Tests the batch class operation for updating NextStep fields in Account and Opportunity.
 * 
 * 5. nextStepSchedule_testExecute (currently commented out): 
 *    - Will test the scheduled job once the NextStepSchedule class is implemented. This test checks if the NextStep fields are correctly updated in both Account and Opportunity objects after the scheduled job execution.
 *    - Manually setup the scheduled job in Salesforce to run the NextStepSchedule class.
 * 
 * NOTE: To run the test for nextStepSchedule_testExecute, students will need to uncomment this test method after implementing the NextStepSchedule class.
 */
@IsTest
public with sharing class AsynchronousTest {

    @IsTest
    static void nextStepFuture_testUpdateAllNextStep() {
        // Create test data
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            testAccounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert testAccounts;

        List<Opportunity> testOpps = new List<Opportunity>();
        for (Account acc : testAccounts) {
            testOpps.add(new Opportunity(Name = 'Test Opp for ' + acc.Name, AccountId = acc.Id, CloseDate = Date.today(), StageName = 'Prospecting'));
        }
        insert testOpps;

        // Call the method to test between the startTest and stopTest methods
        Test.startTest();
        NextStepFuture.updateAllNextStep();
        Test.stopTest();

        // Query the updated accounts and opportunities
        List<Account> updatedAccounts = [SELECT Id, Next_Step__c FROM Account WHERE Id IN :testAccounts];
        List<Opportunity> updatedOpps = [SELECT Id, NextStep FROM Opportunity WHERE Id IN :testOpps];

        // Assert that all account's Next_Step__c fields are updated
        for (Account acc : updatedAccounts) {
            System.assertEquals('Meeting in the future', acc.Next_Step__c, 'Account Next_Step__c field was not updated correctly.');
        }

        // Assert that all opportunity's NextStep fields are updated
        for (Opportunity opp : updatedOpps) {
            System.assertEquals('Meeting in the future', opp.NextStep, 'Opportunity NextStep field was not updated correctly.');
        }
    }

    @IsTest
    static void nextStepFuture_testCreateDealAndUpdateRole() {        
        Test.startTest();
        NextStepFuture.createDealAndUpdateRole();
        Test.stopTest();

        // Due to the Mixed DML error, we need to test the insertBigDeal method
        Opportunity insertedOpportunity = [SELECT Id, Amount, Name, StageName, CloseDate FROM Opportunity WHERE Name = 'Big Deal' LIMIT 1];
        System.assertNotEquals(null, insertedOpportunity, 'Opportunity should have been created.');
        System.assertEquals(1000000, insertedOpportunity.Amount, 'Opportunity Amount is incorrect.');

        // Next, we test the updateUserRoleName method
        UserRole[] updatedRoles = [SELECT Id, Name FROM UserRole WHERE Name = 'CRO' LIMIT 1];
        System.assertEquals(1, updatedRoles.size(), 'UserRole should exist.');
    }

    @IsTest
    static void nextStepQueueable_testEnqueueJob() {
        // Create test data
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            testAccounts.add(new Account(Name = 'Test Account ' + i, Next_Step__c = 'Meeting in the future'));
        }
        insert testAccounts;

        List<Opportunity> testOpps = new List<Opportunity>();
        for (Account acc : testAccounts) {
            testOpps.add(new Opportunity(Name = 'Test Opp for ' + acc.Name, AccountId = acc.Id, CloseDate = Date.today(), StageName = 'Prospecting', NextStep = 'Meeting in the future'));
        }
        insert testOpps;

        // Call the method to test
        Test.startTest();
        NextStepQueueable.enqueueJob();
        Test.stopTest();

        // Query the updated accounts and opportunities
        List<Account> updatedAccounts = [SELECT Id, Next_Step__c FROM Account WHERE Id IN :testAccounts];
        List<Opportunity> updatedOpps = [SELECT Id, NextStep FROM Opportunity WHERE Id IN :testOpps];

        // Assert that all account's Next_Step__c fields are null
        for (Account acc : updatedAccounts) {
            System.assertEquals(null, acc.Next_Step__c, 'Account Next_Step__c field was updated to null.');
        }

        // Assert that all opportunity's NextStep fields are null
        for (Opportunity opp : updatedOpps) {
            System.assertEquals(null, opp.NextStep, 'Opportunity NextStep field was updated to null.');
        }
    }

    @IsTest
    static void nextStepBatch_testUpdateAllNextStep() {
        // Create test data
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            testAccounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert testAccounts;

        List<Opportunity> testOpps = new List<Opportunity>();
        for (Account acc : testAccounts) {
            testOpps.add(new Opportunity(Name = 'Test Opp for ' + acc.Name, AccountId = acc.Id, CloseDate = Date.today(), StageName = 'Prospecting'));
        }
        insert testOpps;

        // Call the batch class
        Test.startTest();
        NextStepBatch batchJob = new NextStepBatch();
        Id batchId = Database.executeBatch(batchJob);
        Test.stopTest();

        // Query the updated accounts and opportunities
        List<Account> updatedAccounts = [SELECT Id, Next_Step__c FROM Account WHERE Id IN :testAccounts];
        List<Opportunity> updatedOpps = [SELECT Id, NextStep FROM Opportunity WHERE Id IN :testOpps];

        // Assert that all account's Next_Step__c fields are updated
        for (Account acc : updatedAccounts) {
            System.assertEquals('Batching the next meetings together.', acc.Next_Step__c, 'Account Next_Step__c field was not updated correctly.');
        }

        // Assert that all opportunity's NextStep fields are updated
        for (Opportunity opp : updatedOpps) {
            System.assertEquals('Batching the next meetings together.', opp.NextStep, 'Opportunity NextStep field was not updated correctly.');
        }
    }

    /*  //UNCOMMENT TEST METHODS BELOW ONCE THE NextStepSchedule class is implemented
        //No Changes should be required to the test methods/code below other than uncommenting them
        //Manually setup the scheduled job in Salesforce to run the NextStepSchedule class
    @IsTest
    static void nextStepSchedule_testExecute() {
        // Create test data
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            testAccounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert testAccounts;

        List<Opportunity> testOpps = new List<Opportunity>();
        for (Account acc : testAccounts) {
            testOpps.add(new Opportunity(Name = 'Test Opp for ' + acc.Name, AccountId = acc.Id, CloseDate = Date.today(), StageName = 'Prospecting'));
        }
        insert testOpps;

        // Schedule the NextStepSchedule class for execution
        Test.startTest();
        NextStepSchedule scheduleJob = new NextStepSchedule();
        String year = String.valueOf(Date.today().year() + 1);
        String cron = '0 0 0 15 3 ? ' + year; // Arbitrary cron expression for once-off execution in the future
        System.schedule('NextStepScheduleTest', cron, scheduleJob);
        scheduleJob.execute(null);
        Test.stopTest();

        // Query the updated accounts and opportunities
        List<Account> updatedAccounts = [SELECT Id, Next_Step__c FROM Account WHERE Id IN :testAccounts];
        List<Opportunity> updatedOpps = [SELECT Id, NextStep FROM Opportunity WHERE Id IN :testOpps];

        // Assert that all account's Next_Step__c fields are updated
        for (Account acc : updatedAccounts) {
            System.assertEquals('Batching the next meetings together.', acc.Next_Step__c, 'Account Next_Step__c field was not updated correctly.');
        }

        // Assert that all opportunity's NextStep fields are updated
        for (Opportunity opp : updatedOpps) {
            System.assertEquals('Batching the next meetings together.', opp.NextStep, 'Opportunity NextStep field was not updated correctly.');
        }
    }
    */
}