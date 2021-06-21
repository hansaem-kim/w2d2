require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees
    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        if salaries.has_key?(title)
            return true
        end
        false
    end

    def >(startup)
        return true if self.funding > startup.funding
        false
    end

    def hire(name, title)
        if !self.valid_title?(title)
            raise "not valid title"
        else
            @employees << Employee.new(name,title)
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        salary = salaries[employee.title]
        if @funding > salary
            employee.pay(salary)
            @funding -= salary
        else
            raise "not enough funding"
        end
    end

    def payday()
        @employees.each do |employee|
            pay_employee(employee)
        end
    end

    def average_salary
        sum = 0
        @employees.each do |employee|
            sum += salaries[employee.title]
        end
        sum/employees.length.to_f
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(startup)
        @funding += startup.funding

        startup.salaries.each do |title, salary|
            if !@salaries.has_key?(title)
                @salaries[title] = salary
            end
        end

        @employees += startup.employees
        startup.close
    end

end
