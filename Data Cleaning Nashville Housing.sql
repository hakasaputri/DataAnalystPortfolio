
--======================= DATA CLEANING ===========================--

--1. Look at the data -----------------------------------------------------------------

	select top 1000 *
	FROM datacleaning..NashvilleHousing

--2.Standarisasi format data -------------------------------------------------------------
	
	--formatted date
	select SaleDate, convert(date, saledate) as FormattedDate
	FROM datacleaning..NashvilleHousing

	--bikin kolom bar
	alter table NashvilleHousing
	add ConvertedDate Date;

	Update NashvilleHousing
	set ConvertedDate = convert(date, SaleDate)

	select SaleDate, ConvertedDate
	FROM datacleaning..NashvilleHousing

--3.populate kolom propertyAdress -------------------------------------------------------------
	
	select ParcelID, PropertyAddress
	from datacleaning..NashvilleHousing
	where PropertyAddress is null
	order by ParcelID

	select table1.ParcelID, table1.PropertyAddress, table2.ParcelID, table2.PropertyAddress
	from NashvilleHousing table1
	JOIN NashvilleHousing table2
		on table1.ParcelID = table2.ParcelID
		AND table1.[UniqueID ]<> table2.[UniqueID ]
	where table1.PropertyAddress is null


	select table1.ParcelID, table1.PropertyAddress, table2.ParcelID, table2.PropertyAddress, isnull(table1.PropertyAddress, table2.PropertyAddress) as isinull
	from NashvilleHousing table1
	JOIN NashvilleHousing table2
		on table1.ParcelID = table2.ParcelID
		AND table1.[UniqueID ]<> table2.[UniqueID ]
	where table1.PropertyAddress is null

	update table1
	set table1.PropertyAddress = isnull(table1.PropertyAddress, table2.PropertyAddress) 
	from NashvilleHousing table1
	JOIN NashvilleHousing table2
		on table1.ParcelID = table2.ParcelID
		AND table1.[UniqueID ]<> table2.[UniqueID ]
	
--4.breaking out address into individual columns (address, city, state) -------------------------------------------------------------
	
	select *
	from datacleaning..NashvilleHousing

	select 

	substring (PropertyAddress, 1, charindex(',' , propertyAddress)-1) as Addressbeforecoma,
	substring (PropertyAddress, charindex(',' , propertyAddress)+1, LEN(propertyAddress)) as Addressaftercoma
	from datacleaning..NashvilleHousing

	alter table NashvilleHousing
	add splitAddress Nvarchar(225);

	update NashvilleHousing
	set splitAddress = substring (PropertyAddress, 1, charindex(',' , propertyAddress)-1)

	alter table NashvilleHousing
	add splitCity Nvarchar(225);

	update NashvilleHousing
	set splitCity = substring (PropertyAddress, charindex(',' , propertyAddress)+1, LEN(propertyAddress))

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
	
	--cara kedua 

	select
	parsename(replace (OwnerAddress, ',', '.'), 3),
	parsename(replace (OwnerAddress, ',', '.'), 2),
	parsename(replace (OwnerAddress, ',', '.'), 1)
	from datacleaning..NashvilleHousing

	select * 
	from datacleaning..NashvilleHousing

	alter table NashvilleHousing
	add OwnerSplitAddress Nvarchar(225);

	update NashvilleHousing
	set OwnerSplitAddress = parsename(replace (OwnerAddress, ',', '.'), 3)
 
	alter table NashvilleHousing
	add OwnerSplitCity  Nvarchar(225);

	update NashvilleHousing
	set OwnerSplitCity  = parsename(replace (OwnerAddress, ',', '.'), 2)
 
	alter table NashvilleHousing
	add OwnerSplitState  Nvarchar(225);

	update NashvilleHousing
	set OwnerSplitState  = parsename(replace (OwnerAddress, ',', '.'), 1)
 

--5.change Y and N to yes and No in "solid as vacant" column -------------------------------------------------------------

	select distinct(SoldAsVacant)
	from datacleaning..NashvilleHousing

	select distinct(SoldAsVacant), count(SoldAsVacant)
	from datacleaning..NashvilleHousing
	group by SoldAsVacant
	order by count(SoldAsVacant) desc

	select SoldAsVacant,

	case 
	when SoldAsVacant = 'Y' then 'Yes'
	when SoldAsVacant = 'N' then 'No'
	else SoldAsVacant
	end

	from datacleaning..NashvilleHousing

	update NashvilleHousing
	set SoldAsVacant = 
	case 
	when SoldAsVacant = 'Y' then 'Yes'
	when SoldAsVacant = 'N' then 'No'
	else SoldAsVacant
	end

--6. Remove duplicates -------------------------------------------------------------

	select *,
		row_number() 
		over (
		partition by ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
		order by UniqueID
		)
		row_num
	from datacleaning..NashvilleHousing

	WITH RowNumCTE as (
	select *,
		row_number() 
		over (
		partition by ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
		order by UniqueID
		)
		row_num
	from datacleaning..NashvilleHousing
	)
	select * 
	from RowNumCTE
	where row_num > 1
	order by PropertyAddress

	WITH RowNumCTE as (
	select *,
		row_number() 
		over (
		partition by ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
		order by UniqueID
		)
		row_num
	from datacleaning..NashvilleHousing
	)
	delete
	from RowNumCTE
	where row_num > 1
	


--7. Delete Unused Columns -------------------------------------------------------------

	Select *
	From datacleaning..NashvilleHousing


	ALTER TABLE datacleaning.dbo.NashvilleHousing
	DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate