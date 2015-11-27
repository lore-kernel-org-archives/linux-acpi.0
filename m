From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 2/7] ACPI / LPSS: allow to use specific PM domain
 during ->probe()
Date: Fri, 27 Nov 2015 09:05:46 +0200
Message-ID: <565800CA.4040003@linux.intel.com>
References: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1448551153-84719-3-git-send-email-andriy.shevchenko@linux.intel.com>
 <565733A2.6050900@linux.intel.com>
 <1448556317.15393.77.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448556317.15393.77.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On 11/26/2015 06:45 PM, Andy Shevchenko wrote:
> On Thu, 2015-11-26 at 18:30 +0200, Jarkko Nikula wrote:
>> On 11/26/2015 05:19 PM, Andy Shevchenko wrote:
>>> This is an amendment to previously pushed commit 01ac170ba29a (ACPI
>>> / LPSS:
>>> allow to use specific PM domain during ->probe()). We can't assign
>>> anything to
>>> the platform device on ADD_DEVICE stage since it might be changed
>>> during
>>> unbound / bind cycle.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> ---
>>>    drivers/acpi/acpi_lpss.c | 9 +++++++--
>>>    1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
>>> index f9e0d09..e840229 100644
>>> --- a/drivers/acpi/acpi_lpss.c
>>> +++ b/drivers/acpi/acpi_lpss.c
>>> @@ -705,8 +705,14 @@ static int acpi_lpss_platform_notify(struct
>>> notifier_block *nb,
>>>    	}
>>>
>>>    	switch (action) {
>>> -	case BUS_NOTIFY_ADD_DEVICE:
>>> +	case BUS_NOTIFY_BIND_DRIVER:
>>>    		pdev->dev.pm_domain = &acpi_lpss_pm_domain;
>>> +		break;
>>> +	case BUS_NOTIFY_BIND_DRIVER_ERROR:
>>> +	case BUS_NOTIFY_UNBOUND_DRIVER:
>>> +		pdev->dev.pm_domain = NULL;
>>> +		break;
>>> +	case BUS_NOTIFY_ADD_DEVICE:
>>
>> This won't fix like revert of original commit does. Primary problem
>> here
>> is that there is no explicit power on at all during LPSS device probe
>> because dev->pm_domain is set before probing.
>
> And we can't do this as in very original code of acpi_lpss.c since DMA
> has to be sure it's powered on while probing. We could guarantee this
> only in case when PM domain is assigned already and we do our quirk for
> it.
>
I'm not sure do I follow here. Is the power on chain different for LPSS 
DMA because setting the domain at BIND stage prevents the call to 
acpi_dev_pm_full_power() before driver probe? See below.

driver_probe_device
   really_probe
     driver_sysfs_add -> BUS_NOTIFY_BIND_DRIVER
     -> platform_drv_prove
       dev_pm_domain_attach
         acpi_dev_pm_attach
           if (dev->pm_domain) return -EEXIST;
           ...
           if (power_on) { acpi_dev_pm_full_power(adev);... }
       -> probe
   driver_bound -> BUS_NOTIFY_BOUND_DRIVER

>  From my point of view we have to fix hang first since it's most painful
> case for users and their experience. Though I'm open to any better
> solution if you have any in mind.
>
Sure.

-- 
Jarkko
