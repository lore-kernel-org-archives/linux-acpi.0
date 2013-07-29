From: Ben Guthro <Benjamin.Guthro@citrix.com>
Subject: Re: [PATCH v7 2/3] x86/tboot: Fail extended mode reduced hardware
 sleep
Date: Mon, 29 Jul 2013 16:18:22 -0400
Message-ID: <51F6CE0E.3080807@citrix.com>
References: <1375118055-15942-1-git-send-email-benjamin.guthro@citrix.com> <1375118055-15942-3-git-send-email-benjamin.guthro@citrix.com> <8791139.q8n07ejQ71@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp02.citrix.com ([66.165.176.63]:34542 "EHLO
	SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474Ab3G2US0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Jul 2013 16:18:26 -0400
In-Reply-To: <8791139.q8n07ejQ71@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jan Beulich <jbeulich@suse.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, xen-devel@lists.xen.org, tboot-devel@lists.sourceforge.net, Gang Wei <gang.wei@intel.com>



On 07/29/2013 04:21 PM, Rafael J. Wysocki wrote:
> On Monday, July 29, 2013 01:14:14 PM Ben Guthro wrote:
>> Register for the extended sleep callback from acpi.
>> As tboot currently does not support the reduced hardware sleep
>> interface, fail this extended call.
>>
>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>> Signed-off-by: Ben Guthro <benjamin.guthro@citrix.com>
>> Cc: tboot-devel@lists.sourceforge.net
>> Cc: Gang Wei <gang.wei@intel.com>
>> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> ---
>>  arch/x86/kernel/tboot.c |   12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
>> index addf7b5..760f431 100644
>> --- a/arch/x86/kernel/tboot.c
>> +++ b/arch/x86/kernel/tboot.c
>> @@ -301,6 +301,17 @@ static int tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control)
>>  	return 0;
>>  }
>>  
>> +static int tboot_extended_sleep(u8 sleep_state, u32 val_a, u32 val_b)
>> +{
>> +	if (!tboot_enabled())
>> +		return 0;
>> +
>> +	pr_warning("tboot is not able to suspend on platforms with"
>> +		   " reduced hardware sleep (ACPIv5). Please contact"
>> +		   " tboot-devel@lists.sourceforge.net mailing list.");
>> +	return -1;
> 
> Please use a meaningful error code here.  For example -ENODEV.

Would AE_NOT_IMPLEMENTED be more appropriate?

include/acpi/acexcep.h:
#define AE_NOT_IMPLEMENTED              EXCEP_ENV (0x000E)




> 
>> +}
>> +
>>  static atomic_t ap_wfs_count;
>>  
>>  static int tboot_wait_for_aps(int num_aps)
>> @@ -422,6 +433,7 @@ static __init int tboot_late_init(void)
>>  #endif
>>  
>>  	acpi_os_set_prepare_sleep(&tboot_sleep);
>> +	acpi_os_set_prepare_extended_sleep(&tboot_extended_sleep);
>>  	return 0;
>>  }
> 
> Thanks,
> Rafael
> 
> 
