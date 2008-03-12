From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [PATCH] ACPI: disable stray gpe correctly
Date: Wed, 12 Mar 2008 15:55:11 -0400
Message-ID: <47D8351F.7080802@redhat.com>
References: <1205114649.10256.200.camel@acpi-hp-zz.sh.intel.com> <200803110206.45590.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:51892 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752304AbYCLTzc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 15:55:32 -0400
In-Reply-To: <200803110206.45590.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, robert.moore@intel.com, davej@redhat.com

On 03/11/2008 02:06 AM, Len Brown wrote:
> applied.
> 
> thanks,
> -Len
> 
> On Sunday 09 March 2008, Zhang, Rui wrote:
>> Disable stray GPE correctly
>> https://bugzilla.redhat.com/show_bug.cgi?id=251744
>> http://bugzilla.kernel.org/show_bug.cgi?id=6217
>>
>> Sighed-off-by: Zhang Rui <rui.zhang@intel.com>
>> ---
>>  drivers/acpi/events/evgpe.c |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> Index: linux-2.6/drivers/acpi/events/evgpe.c
>> ===================================================================
>> --- linux-2.6.orig/drivers/acpi/events/evgpe.c
>> +++ linux-2.6/drivers/acpi/events/evgpe.c
>> @@ -248,7 +248,8 @@ acpi_status acpi_ev_disable_gpe(struct a
>>  
>>  	ACPI_FUNCTION_TRACE(ev_disable_gpe);
>>  
>> -	if (!(gpe_event_info->flags & ACPI_GPE_ENABLE_MASK)) {
>> +	if (gpe_event_info->flags &&
>> +		(!(gpe_event_info->flags & ACPI_GPE_ENABLE_MASK))) {
>>  		return_ACPI_STATUS(AE_OK);
>>  	}
>>  

Causes ACPI battery problems...

https://bugzilla.redhat.com/show_bug.cgi?id=436959
