USE WideWorldImporters;
go

alter function Sales.Discount (
	@OrderTotal int
)
returns decimal(4, 2) as
begin
declare @outValue decimal(4,2)
--select @outValue =
--case when @OrderTotal < 5000 then 0
--	 when @OrderTotal > 5000 and @OrderTotal < 10000 then 0.25
--	 when @OrderTotal > 10000 and @OrderTotal < 15000 then 0.5
--	 when @OrderTotal > 15000 and @OrderTotal < 20000 then 0.75
--	 when @OrderTotal > 20000 then 1
--end

--#2
set @outValue =
case when @OrderTotal < 5000 then 0
	 when @OrderTotal < 10000 then 0.25
	 when @OrderTotal < 15000 then 0.5
	 when @OrderTotal < 20000 then 0.75
	 else 1
end

-- #3
--if (@OrderTotal < 5000) 
--	set @outValue = 0
--else
--	if (@OrderTotal < 10000)
--		set @outValue = 0.25
--	else 
--		if (@OrderTotal < 15000)
--			set @outValue = 0.5
--		else
--			if (@OrderTotal < 20000)
--				set @outValue = 0.75
--			else
--				set @outValue = 1

return @outValue
end

--select Sales.Discount(14000)