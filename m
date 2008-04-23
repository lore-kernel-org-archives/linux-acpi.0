From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 70/73] ACPICA: Fix to disable unknown spurious GPEs
Date: Wed, 23 Apr 2008 13:35:41 -0700
Message-ID: <9D39833986E69849A2A8E74C1078B6B3372B65@orsmsx415.amr.corp.intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org> <16ff5d276b6f17288051f32accdbd675242e5282.1207973801.git.len.brown@intel.com> <200804222257.16029.lenb@kernel.org> <480EC916.1050407@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:14053 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752578AbYDWUfs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Apr 2008 16:35:48 -0400
Content-class: urn:content-classes:message
In-Reply-To: <480EC916.1050407@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, "Zhang, Rui" <rui.zhang@intel.com>

Alexey,

I remember there was some discussion on this, but I'm still not sure why
the patch for 6217 (Ignore GPE if valid and not enabled) makes the other
problem (too early enabling of GPEs) apparent. Please explain.

Thanks,
Bob


>-----Original Message-----
>From: Alexey Starikovskiy [mailto:astarikovskiy@suse.de]
>Sent: Tuesday, April 22, 2008 10:29 PM
>To: Len Brown
>Cc: linux-acpi@vger.kernel.org; Moore, Robert; Zhang, Rui
>Subject: Re: [PATCH 70/73] ACPICA: Fix to disable unknown spurious GPEs
>
>Len Brown wrote:
>> On Saturday 12 April 2008, Len Brown wrote:
>>> From: Bob Moore <robert.moore@intel.com>
>>>
>>> Implemented another change to eliminate/suppress spurious or
>>> stray GPEs. The AcpiEvDisableGpe function will now disable GPEs
>>> that are neither enabled nor disabled -- meaning that the GPE is
>>> unknown to the system. This will prevent future interrupts from
>>> that GPE. (Zhang Rui) BZ 6217
>>>
>>> Signed-off-by: Bob Moore <robert.moore@intel.com>
>>> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
>>> Signed-off-by: Len Brown <len.brown@intel.com>
>>> ---
>>>  drivers/acpi/events/evgpe.c |    9 ++++++++-
>>>  1 files changed, 8 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/acpi/events/evgpe.c
b/drivers/acpi/events/evgpe.c
>>> index 897baed..6940f5d 100644
>>> --- a/drivers/acpi/events/evgpe.c
>>> +++ b/drivers/acpi/events/evgpe.c
>>> @@ -250,7 +250,14 @@ acpi_status acpi_ev_disable_gpe(struct
>acpi_gpe_event_info *gpe_event_info)
>>>
>>>  	ACPI_FUNCTION_TRACE(ev_disable_gpe);
>>>
>>> -	if (!(gpe_event_info->flags & ACPI_GPE_ENABLE_MASK)) {
>>> +	/*
>>> +	 * Ignore this if the GPE is valid and not enabled.
>>> +	 *
>>> +	 * Flags is only zero if GPE is neither enabled or disabled --
it may
>>> +	 * be a spurious or stray GPE -- disable it in the default case
>below.
>>> +	 */
>>> +	if (gpe_event_info->flags &&
>>> +	    (!(gpe_event_info->flags & ACPI_GPE_ENABLE_MASK))) {
>>>  		return_ACPI_STATUS(AE_OK);
>>>  	}
>>>
>>
>>
>> When applied to 2.6.25, the patch above causes ACPI Error messages
below
>on my T61.
>> Certainly this is a case of the EC getting an interrupt (GPE x02)
before
>it has initialized.
>>
>> Perhaps it breaks the call of acpi_install_gpe_handler() to
>acpi_ev_disable_gpe()?
>Congratulations, now you too hit this one, patch is already there...
>It is wroong to enable GPE before handler for it is installed...
>http://bugzilla.kernel.org/show_bug.cgi?id=9916
>
>>
>> -Len
>>
>>
>>  PCI: Using MMCONFIG at f0000000 - f3ffffff
>>  PCI: Using configuration type 1
>>  evgpeblk-0956 [00] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4
regs on
>int 0x9
>> +ACPI Error (evregion-0316): No handler for Region [ECOR]
>(ffff81007d35dda0) [EmbeddedControl] [20070126]
>> +ACPI Error (exfldio-0289): Region EmbeddedControl(3) has no handler
>[20070126]
>> +ACPI Error (psparse-0537): Method parse/execution failed
>[\_SB_.PCI0.LPC_.EC__.AC__._PSR] (Node ffff81007d364ab0), AE_NOT_EXIST
>> +ACPI Error (psparse-0537): Method parse/execution failed
>[\_SB_.PCI0.LPC_.EC__.HKEY.CKC4] (Node ffff81007d364f48), AE_NOT_EXIST
>> +ACPI Error (psparse-0537): Method parse/execution failed
[\_GPE._L02]
>(Node ffff81007d376420), AE_NOT_EXIST
>> +ACPI Exception (evgpe-0584): AE_NOT_EXIST, while evaluating GPE
method
>[_L02] [20070126]
>>  evgpeblk-1052 [00] ev_initialize_gpe_bloc: Found 9 Wake, Enabled 3
>Runtime GPEs in this block
>>  ACPI: EC: EC description table is found, configuring boot EC
>> -ACPI: EC: non-query interrupt received, switching to interrupt mode
>> -Completing Region/Field/Buffer/Package
>initialization:........................................................
....
>............................................................
>>
>.......................................................................
....
>.......................................................................
....
>................
>> -Initialized 29/33 Regions 138/138 Fields 64/64 Buffers 55/72
Packages
>(1888 nodes)
>> +Completing Region/Field/Buffer/Package
>initialization:........................................................
....
>............................................................
>>
>.......................................................................
....
>.......................................................................
....
>.................
>> +Initialized 30/33 Regions 138/138 Fields 64/64 Buffers 55/72
Packages
>(1888 nodes)
>>  Initializing Device/Processor/Thermal objects by executing _INI
>methods:.<5>ACPI: BIOS _OSI(Linux) query honored via DMI
>> +ACPI: EC: non-query interrupt received, switching to interrupt mode
>>  .......
>>  Executed 8 _INI methods requiring 2 _STA executions (examined 88
>objects)
>>  ACPI: Interpreter enabled

