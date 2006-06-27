From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [patch 16/18] disable ACPI on some Phoenix BIOS
Date: Tue, 27 Jun 2006 10:37:31 -0700
Message-ID: <44A16CDB.6020807@oracle.com>
References: <CFF307C98FEABE47A452B27C06B85BB6D8C7C8@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:42991 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1161240AbWF0RgJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Jun 2006 13:36:09 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6D8C7C8@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: akpm@osdl.org, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org

Brown, Len wrote:
> What machine is this for?  The patch does not say.
> 
> What steps were taken to show that this is not
> an ACPI bug in Linux that would be masked if we
> applied this patch?

We don't have a record of that info.

Matthew from Ubuntu wrote:
Yeah, this was a quick workaround. I think we'd probably be better off 
figuring out /why/ the system was freezing, but, well.

and Andrew asked about the machine specifics, but we haven't
received any more info.  Best just to drop it IMO.

Thanks,
~Randy


> thanks,
> -Len 
> 
>> -----Original Message-----
>> From: akpm@osdl.org [mailto:akpm@osdl.org] 
>> Sent: Saturday, June 24, 2006 7:37 PM
>> To: Brown, Len
>> Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; 
>> randy.dunlap@oracle.com; mjg59@srcf.ucam.org
>> Subject: [patch 16/18] disable ACPI on some Phoenix BIOS
>>
>>
>> From: Randy Dunlap <randy.dunlap@oracle.com>
>>
>> Disable ACPI on some Phoenix BIOS, or the system will freeze.
>>
>> http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-d
>> apper.git;a=commitdiff;h=8ae54aeedb4b33a74ba5d811abef07d83f1838f4
>>
>> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
>> Signed-off-by: Andrew Morton <akpm@osdl.org>
>> ---
>>
>> arch/i386/kernel/acpi/boot.c |   10 +++++++++-
>> 1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff -puN 
>> arch/i386/kernel/acpi/boot.c~disable-acpi-on-some-phoenix-bios 
>> arch/i386/kernel/acpi/boot.c
>> --- a/arch/i386/kernel/acpi/boot.c~disable-acpi-on-some-phoenix-bios
>> +++ a/arch/i386/kernel/acpi/boot.c
>> @@ -991,7 +991,15 @@ static struct dmi_system_id __initdata a
>> 		     DMI_MATCH(DMI_BOARD_NAME, "2629H1G"),
>> 		     },
>> 	 },
>> -
>> +	 {
>> +	  .callback = dmi_disable_acpi,
>> +	  .ident = "Phoenix Technologies",
>> +	  .matches = {
>> +	  	      DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix 
>> Technologies, LTD"),
>> +		      DMI_MATCH(DMI_BIOS_VERSION, "6.00 PG"),
>> +		      DMI_MATCH(DMI_BIOS_DATE, "11/05/2003"),
>> +	  	     },
>> +	 },
>> 	/*
>> 	 * Boxes that need acpi=ht
>> 	 */
>> _
>>

