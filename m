From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 1/4] ACPICA: Remove use of caches in controlled way
Date: Mon, 11 May 2009 08:42:26 -0700
Message-ID: <4911F71203A09E4D9981D27F9D8308582281A5F5@orsmsx503.amr.corp.intel.com>
References: <20090507155202.26361.38778.stgit@thinkpad>
 <1242029667.4641.31.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53218 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753439AbZEKPnX convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Mon, 11 May 2009 11:43:23 -0400
In-Reply-To: <1242029667.4641.31.camel@minggr.sh.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lin, Ming M" <ming.m.lin@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>

Removing the cache has exposed a couple of bugs that we are currently working on. We need to make sure that we pass the ASLTS suite before the code is integrated/released.

Bob


>-----Original Message-----
>From: Lin, Ming M
>Sent: Monday, May 11, 2009 1:14 AM
>To: Alexey Starikovskiy
>Cc: Moore, Robert; Linux-acpi@vger.kernel.org
>Subject: Re: [PATCH 1/4] ACPICA: Remove use of caches in controlled way
>
>Hi, Alexey
>
>The attachment are the linuxized version of your patches.
>I added another patch (the 4th) to remove linux specific cache code.
>
>The patches are applied on top of linux-acpi-2.6/acpica branch.
>
>Do you have any suggestion what data I should collect to verify if these
>patches have a performance gain?
>
>Lin Ming
>
>On Thu, 2009-05-07 at 23:52 +0800, Alexey Starikovskiy wrote:
>> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
>> ---
>>
>>  source/components/utilities/utcache.c |   99 +++++----------------------
>------
>>  1 files changed, 14 insertions(+), 85 deletions(-)
>>
>>
>> diff --git a/source/components/utilities/utcache.c
>b/source/components/utilities/utcache.c
>> index aabc0a2..d08d520 100644
>> --- a/source/components/utilities/utcache.c
>> +++ b/source/components/utilities/utcache.c
>> @@ -287,49 +287,15 @@ AcpiOsReleaseObject (
>>      ACPI_MEMORY_LIST        *Cache,
>>      void                    *Object)
>>  {
>> -    ACPI_STATUS             Status;
>> -
>> -
>>      ACPI_FUNCTION_ENTRY ();
>>
>> -
>>      if (!Cache || !Object)
>>      {
>>          return (AE_BAD_PARAMETER);
>>      }
>>
>> -    /* If cache is full, just free this object */
>> -
>> -    if (Cache->CurrentDepth >= Cache->MaxDepth)
>> -    {
>> -        ACPI_FREE (Object);
>> -        ACPI_MEM_TRACKING (Cache->TotalFreed++);
>> -    }
>> -
>> -    /* Otherwise put this object back into the cache */
>> -
>> -    else
>> -    {
>> -        Status = AcpiUtAcquireMutex (ACPI_MTX_CACHES);
>> -        if (ACPI_FAILURE (Status))
>> -        {
>> -            return (Status);
>> -        }
>> -
>> -        /* Mark the object as cached */
>> -
>> -        ACPI_MEMSET (Object, 0xCA, Cache->ObjectSize);
>> -        ACPI_SET_DESCRIPTOR_TYPE (Object, ACPI_DESC_TYPE_CACHED);
>> -
>> -        /* Put the object at the head of the cache list */
>> -
>> -        * (ACPI_CAST_INDIRECT_PTR (char,
>> -            &(((char *) Object)[Cache->LinkOffset]))) = Cache->ListHead;
>> -        Cache->ListHead = Object;
>> -        Cache->CurrentDepth++;
>> -
>> -        (void) AcpiUtReleaseMutex (ACPI_MTX_CACHES);
>> -    }
>> +    ACPI_FREE (Object);
>> +    ACPI_MEM_TRACKING (Cache->TotalFreed++);
>>
>>      return (AE_OK);
>>  }
>> @@ -353,8 +319,6 @@ AcpiOsAcquireObject (
>>      ACPI_MEMORY_LIST        *Cache)
>>  {
>>      ACPI_STATUS             Status;
>> -    void                    *Object;
>> -
>>
>>      ACPI_FUNCTION_NAME (OsAcquireObject);
>>
>> @@ -372,61 +336,26 @@ AcpiOsAcquireObject (
>>
>>      ACPI_MEM_TRACKING (Cache->Requests++);
>>
>> -    /* Check the cache first */
>> +    /* The cache is empty, create a new object */
>>
>> -    if (Cache->ListHead)
>> -    {
>> -        /* There is an object available, use it */
>> -
>> -        Object = Cache->ListHead;
>> -        Cache->ListHead = *(ACPI_CAST_INDIRECT_PTR (char,
>> -                                &(((char *) Object)[Cache-
>>LinkOffset])));
>> -
>> -        Cache->CurrentDepth--;
>> -
>> -        ACPI_MEM_TRACKING (Cache->Hits++);
>> -        ACPI_DEBUG_PRINT ((ACPI_DB_EXEC,
>> -            "Object %p from %s cache\n", Object, Cache->ListName));
>> -
>> -        Status = AcpiUtReleaseMutex (ACPI_MTX_CACHES);
>> -        if (ACPI_FAILURE (Status))
>> -        {
>> -            return (NULL);
>> -        }
>> -
>> -        /* Clear (zero) the previously used Object */
>> -
>> -        ACPI_MEMSET (Object, 0, Cache->ObjectSize);
>> -    }
>> -    else
>> -    {
>> -        /* The cache is empty, create a new object */
>> -
>> -        ACPI_MEM_TRACKING (Cache->TotalAllocated++);
>> +    ACPI_MEM_TRACKING (Cache->TotalAllocated++);
>>
>>  #ifdef ACPI_DBG_TRACK_ALLOCATIONS
>> -        if ((Cache->TotalAllocated - Cache->TotalFreed) > Cache-
>>MaxOccupied)
>> -        {
>> -            Cache->MaxOccupied = Cache->TotalAllocated - Cache-
>>TotalFreed;
>> -        }
>> +    if ((Cache->TotalAllocated - Cache->TotalFreed) > Cache-
>>MaxOccupied)
>> +    {
>> +        Cache->MaxOccupied = Cache->TotalAllocated - Cache->TotalFreed;
>> +    }
>>  #endif
>>
>> -        /* Avoid deadlock with ACPI_ALLOCATE_ZEROED */
>> +    /* Avoid deadlock with ACPI_ALLOCATE_ZEROED */
>>
>> -        Status = AcpiUtReleaseMutex (ACPI_MTX_CACHES);
>> -        if (ACPI_FAILURE (Status))
>> -        {
>> -            return (NULL);
>> -        }
>> -
>> -        Object = ACPI_ALLOCATE_ZEROED (Cache->ObjectSize);
>> -        if (!Object)
>> -        {
>> -            return (NULL);
>> -        }
>> +    Status = AcpiUtReleaseMutex (ACPI_MTX_CACHES);
>> +    if (ACPI_FAILURE (Status))
>> +    {
>> +        return (NULL);
>>      }
>>
>> -    return (Object);
>> +    return ACPI_ALLOCATE_ZEROED (Cache->ObjectSize);
>>  }
>>  #endif /* ACPI_USE_LOCAL_CACHE */
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
