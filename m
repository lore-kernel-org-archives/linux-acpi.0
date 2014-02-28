From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [PATCH] ACPI/Sleep: pm_power_off need more sanity check to be
 installed
Date: Sat, 01 Mar 2014 06:24:23 +0800
Message-ID: <53110C97.3040207@linux.intel.com>
References: <530D558D.6090607@linux.intel.com> <1853937.5e0COHhnpP@vostro.rjw.lan> <53101FAB.3080609@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13142 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752402AbaB1WY3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Feb 2014 17:24:29 -0500
In-Reply-To: <53101FAB.3080609@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len.Brown@intel.com, "alan@linux.intel.com" <alan@linux.intel.com>, "Raj, Ashok" <ashok.raj@intel.com>

On 2014/2/28 13:33, Li, Aubrey wrote:
> On 2014/2/27 7:50, Rafael J. Wysocki wrote:
>> On Wednesday, February 26, 2014 10:46:37 AM Li, Aubrey wrote:
>>> Sleep control and status registers need santity check before ACPI
>>> install acpi_power_off to pm_power_off hook. The checking code in
>>> acpi_enter_sleep_state() is too late, we should not allow a not-working
>>> pm_power_off function hooked.
>>>
>>> Signed-off-by: Aubrey Li <aubrey.li@intel.com>
>>> ---
>>>  drivers/acpi/sleep.c |    7 +++++--
>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
>>> index b718806..0284d22 100644
>>> --- a/drivers/acpi/sleep.c
>>> +++ b/drivers/acpi/sleep.c
>>> @@ -809,8 +809,11 @@ int __init acpi_sleep_init(void)
>>>  	status = acpi_get_sleep_type_data(ACPI_STATE_S5, &type_a, &type_b);
>>>  	if (ACPI_SUCCESS(status)) {
>>>  		sleep_states[ACPI_STATE_S5] = 1;
>>
>> Do we still want to set this if the check below fails?  If so, then why?
> 
> We know \_S5_ is valid. The fault is sleep registers, not S5 ACPI object

Hi Rafael, do you still have any concern?

Thanks,
-Aubrey
> 
>>
>>> -		pm_power_off_prepare = acpi_power_off_prepare;
>>> -		pm_power_off = acpi_power_off;
>>> +		if (acpi_gbl_FADT.sleep_control.address &&
>>> +			acpi_gbl_FADT.sleep_status.address) {
>>> +			pm_power_off_prepare = acpi_power_off_prepare;
>>> +			pm_power_off = acpi_power_off;
>>> +		}
>>>  	}
>>>
>>>  	supported[0] = 0;
>>>
>>
> 

