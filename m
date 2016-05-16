From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH v2] ACPI: Support for platform initiated graceful shutdown
Date: Mon, 16 May 2016 17:20:02 -0600
Message-ID: <573A55A2.6040400@codeaurora.org>
References: <1463430112-8843-1-git-send-email-pprakash@codeaurora.org>
 <1AE640813FDE7649BE1B193DEA596E883BBA2A24@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44687 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbcEPXU2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 May 2016 19:20:28 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BBA2A24@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "harba@codeaurora.org" <harba@codeaurora.org>, "ahs3@redhat.com" <ahs3@redhat.com>

Hi,

On 5/16/2016 4:43 PM, Zheng, Lv wrote:
> Hi,
>
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>> owner@vger.kernel.org] On Behalf Of Prashanth Prakash
>> Subject: [PATCH v2] ACPI: Support for platform initiated graceful shutdown
>>
>> This patch adds support for platform initited graceful shutdown as
>> described in sections 5.6.6(Table-143) and 6.3.5.1 of ACPI 6.1 spec
>>
>> The OSPM will get a graceful shutdown request via a Notify operator
>> on \_SB device with a value of 0x81 per section 5.6.6. Following the
>> shutdown request from platform the OSPM needs to follow the
>> processing sequence as described in section 6.2.5.1.
> [Lv Zheng] 
> Can you provide proofs on how other OS (ex., Windows) behave around this feature instead of using the spec description?
There was some ambiguity on which device the notify call should target and these
were clarified only in ACPI 6.1 spec, so, I am not sure if there any existing
platform that uses this part of the spec to check the behavior.
Also, I am testing on an ARM platform and don't have access to a windows image
to check. Sorry.
>> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
>> ---
>>  drivers/acpi/bus.c     | 49
>> +++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/acpi/actypes.h |  2 +-
>>  2 files changed, 50 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index 31e8da6..25d4806 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -30,6 +30,8 @@
>>  #include <linux/acpi.h>
>>  #include <linux/slab.h>
>>  #include <linux/regulator/machine.h>
>> +#include <linux/workqueue.h>
>> +#include <linux/reboot.h>
>>  #ifdef CONFIG_X86
>>  #include <asm/mpspec.h>
>>  #endif
>> @@ -475,6 +477,52 @@ static void acpi_device_remove_notify_handler(struct
>> acpi_device *device)
>>  					   acpi_device_notify);
>>  }
>>
>> +/* Handle events targeting \_SB device (at present only graceful shutdown) */
>> +
>> +#define ACPI_SB_NOTIFY_SHUTDOWN_REQUEST 0x81
>> +#define ACPI_SYBUS_INDICATE_INTERVAL	10000
>> +
>> +static void sybus_evaluate_ost(struct work_struct *dummy);
>> +static DECLARE_DELAYED_WORK(acpi_sybus_work, sybus_evaluate_ost);
>> +
>> +static void sybus_evaluate_ost(struct work_struct *dummy)
>> +{
>> +	acpi_handle sb_handle;
>> +
>> +	if (ACPI_SUCCESS(acpi_get_handle(NULL, "\\_SB", &sb_handle))) {
>> +		acpi_evaluate_ost(sb_handle,
>> ACPI_OST_EC_OSPM_SHUTDOWN,
>> +				ACPI_OST_SC_OS_SHUTDOWN_IN_PROGRESS,
>> NULL);
>> +		schedule_delayed_work(&acpi_sybus_work,
>> +
>> 	msecs_to_jiffies(ACPI_SYBUS_INDICATE_INTERVAL));
>> +		pr_info("Graceful shutdown in progress.\n");
>> +	}
>> +}
>> +
>> +static void acpi_sybus_notify(acpi_handle handle, u32 event, void *data)
>> +{
>> +	if (event == ACPI_SB_NOTIFY_SHUTDOWN_REQUEST) {
>> +		if (!delayed_work_pending(&acpi_sybus_work)) {
>> +			sybus_evaluate_ost(NULL);
>> +			orderly_poweroff(true);
>> +		}
>> +	} else
>> +		pr_warn("event %x is not supported by \\_SB device\n", event);
> [Lv Zheng] 
> Do you need to evaluate _OST with status code = 2?
> This looks to me like we are lacking in general Notify handling support in the ACPICA core.
>
> Thanks and best regards
> -Lv
The possible status codes for graceful shutdown request is provided by the spec itself (See
Table: 6-186 in ACPI6.1 spec). The status code in this scenario indicates the status of shutdown,
some of the possible status include "request denied" or "not supported" and so on.
>> +}
>> +
>> +static int __init acpi_setup_sybus_notify_handler(void)
>> +{
>> +	acpi_handle sb_handle;
>> +
>> +	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &sb_handle)))
>> +		return -ENXIO;
>> +
>> +	if (ACPI_FAILURE(acpi_install_notify_handler(sb_handle,
>> ACPI_DEVICE_NOTIFY,
>> +						acpi_sybus_notify, NULL)))
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>>  /* --------------------------------------------------------------------------
>>                               Device Matching
>>     -------------------------------------------------------------------------- */
>> @@ -1124,6 +1172,7 @@ static int __init acpi_init(void)
>>  	acpi_sleep_proc_init();
>>  	acpi_wakeup_device_init();
>>  	acpi_debugger_init();
>> +	acpi_setup_sybus_notify_handler();
>>  	return 0;
>>  }
>>
>> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
>> index cb389ef..860b273 100644
>> --- a/include/acpi/actypes.h
>> +++ b/include/acpi/actypes.h
>> @@ -627,7 +627,7 @@ typedef u64 acpi_integer;
>>  #define ACPI_NOTIFY_DEVICE_PLD_CHECK    (u8) 0x09
>>  #define ACPI_NOTIFY_RESERVED            (u8) 0x0A
>>  #define ACPI_NOTIFY_LOCALITY_UPDATE     (u8) 0x0B
>> -#define ACPI_NOTIFY_SHUTDOWN_REQUEST    (u8) 0x0C
>> +#define ACPI_NOTIFY_RESERVED_2          (u8) 0x0C
>>  #define ACPI_NOTIFY_AFFINITY_UPDATE     (u8) 0x0D
>>
>>  #define ACPI_GENERIC_NOTIFY_MAX         0x0D
>> --
>> Qualcomm Technologies, Inc. on behalf
>> of the Qualcomm Innovation Center, Inc.  The Qualcomm Innovation Center,
>> Inc.
>> is a member of the Code Aurora Forum, a Linux Foundation Collaborative
>> Project.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Prashanth
