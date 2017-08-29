From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH v2] ACPI / APEI: Suppress message if HEST not present
Date: Tue, 29 Aug 2017 14:17:22 +0100
Message-ID: <87pobeh5st.fsf@e105922-lin.cambridge.arm.com>
References: <20170816112753.12085-1-punit.agrawal@arm.com>
        <20170829123815.2z6hoclakznophom@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60628 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752002AbdH2NRY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Aug 2017 09:17:24 -0400
In-Reply-To: <20170829123815.2z6hoclakznophom@pd.tnic> (Borislav Petkov's
        message of "Tue, 29 Aug 2017 14:38:15 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: linux-acpi@vger.kernel.org, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, James Morse <james.morse@arm.com>

Borislav Petkov <bp@suse.de> writes:

> On Wed, Aug 16, 2017 at 12:27:53PM +0100, Punit Agrawal wrote:
>> According to the ACPI specification, firmware is not required to provide
>> the Hardware Error Source Table (HEST). When HEST is not present, the
>> following superfluous message is printed to the kernel boot log -
>> 
>> [    3.460067] GHES: HEST is not enabled!
>> 
>> Extend hest_disable variable to track whether the firmware provides this
>> table and if it is not present skip any log output. The existing
>> behaviour is preserved in all other cases.
>> 
>> Suggested-by: Borislav Petkov <bp@suse.de>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Cc: Borislav Petkov <bp@suse.de>
>> Cc: James Morse <james.morse@arm.com>
>> ---
>>  drivers/acpi/apei/ghes.c |  4 ++--
>>  drivers/acpi/apei/hest.c | 13 +++++++------
>>  include/acpi/apei.h      |  8 +++++++-
>>  3 files changed, 16 insertions(+), 9 deletions(-)
>> 
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index d661d452b238..f8685bcbeff2 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -1262,10 +1262,10 @@ static int __init ghes_init(void)
>>  {
>>  	int rc;
>>  
>> -	if (acpi_disabled)
>> +	if (acpi_disabled || hest_disable == HEST_NOT_FOUND)
>>  		return -ENODEV;
>>  
>> -	if (hest_disable) {
>> +	if (hest_disable == HEST_DISABLED) {
>>  		pr_info(GHES_PFX "HEST is not enabled!\n");
>>  		return -EINVAL;
>>  	}
>
> Yap, looks good.
>
> Just a minor nitpick: I'd additionally group the hest_disable checking
> in one switch-case, so that the code flow is obvious at a quick glance:
>
>         if (acpi_disabled)
>                 return -ENODEV;
>
>         switch (hest_disable) {
>         case HEST_NOT_FOUND:
>                 return -ENODEV;
>         case HEST_DISABLED:
>                 pr_info(GHES_PFX "HEST is not enabled!\n");
>                 return -EINVAL;
>         default:
>                 break;
>         }

I've picked this change and will send out an update shortly.

Thanks,
Punit
