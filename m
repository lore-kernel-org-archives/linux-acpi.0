From: liang tang <liang.tang@oracle.com>
Subject: Re: [PATCH 4/8] ACPI: processor: Don't setup cpu idle driver and
 handler when we do not want them.
Date: Mon, 19 Dec 2011 18:33:01 +0800
Message-ID: <4EEF12DD.2020308@oracle.com>
References: <1322673664-14642-1-git-send-email-konrad.wilk@oracle.com> <1322673664-14642-5-git-send-email-konrad.wilk@oracle.com> <20111216213618.GB9832@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:47759 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408Ab1LSKd0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Dec 2011 05:33:26 -0500
In-Reply-To: <20111216213618.GB9832@phenom.dumpdata.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@sisk.pl, xen-devel@lists.xensource.com, jeremy@goop.org, konrad@kernel.org, stefan.bader@canonical.com, Ian.Campbell@citrix.com, mike.mcclurg@citrix.com

On 2011-12-17 5:36, Konrad Rzeszutek Wilk wrote:
> On Wed, Nov 30, 2011 at 12:21:00PM -0500, Konrad Rzeszutek Wilk wrote:
>> From: Kevin Tian<kevin.tian@intel.com>
>>
>> This patch inhibits processing of the CPU idle handler if it is not
>> set to the appropiate one. This is needed by the Xen processor driver
>> which, while still needing processor details, wants to use the default_idle
>> call (which makes a yield hypercall).
> Which I think is not required anymore with the d91ee5863b71e8c90eaf6035bff3078a85e2e7b5
> (cpuidle: replace xen access to x86 pm_idle and default_idle) and
> 62027aea23fcd14478abdddd3b74a4e0f5fb2984
> (cpuidle: create bootparam "cpuidle.off=1")
>
> Liang, can you double-check that please?
>
Hi,Konrad
I just read the code ,I think  don't need that code too. I will double 
check tomorrow.
thanks
liang

>> Signed-off-by: Yu Ke<ke.yu@intel.com>
>> Signed-off-by: Tian Kevin<kevin.tian@intel.com>
>> Signed-off-by: Tang Liang<liang.tang@oracle.com>
>> Signed-off-by: Konrad Rzeszutek Wilk<konrad.wilk@oracle.com>
>> ---
>>   drivers/acpi/processor_idle.c |    8 +++++---
>>   1 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index d88974a..0ad347f 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -1127,7 +1127,7 @@ int acpi_processor_hotplug(struct acpi_processor *pr)
>>   	cpuidle_pause_and_lock();
>>   	cpuidle_disable_device(&pr->power.dev);
>>   	acpi_processor_get_power_info(pr);
>> -	if (pr->flags.power) {
>> +	if (pr->flags.power&&  (cpuidle_get_driver() ==&acpi_idle_driver)) {
>>   		acpi_processor_setup_cpuidle_cx(pr);
>>   		ret = cpuidle_enable_device(&pr->power.dev);
>>   	}
>> @@ -1183,7 +1183,8 @@ int acpi_processor_cst_has_changed(struct acpi_processor *pr)
>>   			if (!_pr || !_pr->flags.power_setup_done)
>>   				continue;
>>   			acpi_processor_get_power_info(_pr);
>> -			if (_pr->flags.power) {
>> +			if (_pr->flags.power&&  (cpuidle_get_driver()
>> +						==&acpi_idle_driver)) {
>>   				acpi_processor_setup_cpuidle_cx(_pr);
>>   				cpuidle_enable_device(&_pr->power.dev);
>>   			}
>> @@ -1237,7 +1238,8 @@ int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
>>   	 * Note that we use previously set idle handler will be used on
>>   	 * platforms that only support C1.
>>   	 */
>> -	if (pr->flags.power) {
>> +	if (pr->flags.power&&  (__acpi_processor_register_driver ==
>> +				acpi_processor_register_driver)) {
>>   		/* Register acpi_idle_driver if not already registered */
>>   		if (!acpi_processor_registered) {
>>   			acpi_processor_setup_cpuidle_states(pr);
>> -- 
>> 1.7.7.3
