From: Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: Possible regression caused by commit a192aa923b66a
Date: Wed, 13 Jun 2018 10:45:23 +0800
Message-ID: <A05971DC-4453-4615-9AE9-8C4608569427@canonical.com>
References: <DEA1AE84-B0FD-481E-8E0D-788CD4EF59AE@canonical.com>
 <CAJZ5v0iyNo+ZZ1O0_j4p6w-+eS1W9MUYs-vjeNHVENFVhReGzw@mail.gmail.com>
 <CAJZ5v0jiWugSt98MXOLUKAsig=uWFsTHK1Mntvy6z0JfiWt9sQ@mail.gmail.com>
 <2505591.oRh3ktjo9V@aspire.rjw.lan>
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2505591.oRh3ktjo9V@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, P HeLiOn <perryhelionsemail@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,

> On Jun 12, 2018, at 5:17 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Monday, June 11, 2018 11:52:34 PM CEST Rafael J. Wysocki wrote:
>> --000000000000703623056e64c488
>> Content-Type: text/plain; charset="UTF-8"
>>
>> On Mon, Jun 11, 2018 at 10:09 AM, Rafael J. Wysocki <rafael@kernel.org>  
>> wrote:
>>> On Mon, Jun 11, 2018 at 8:26 AM, Kai-Heng Feng
>>> <kai.heng.feng@canonical.com> wrote:
>>>> Hi Rafael,
>>>>
>>>> There's a regression report [1] that says commit a192aa923b66a ("ACPI /
>>>> LPSS: Consolidate runtime PM and system sleep handling") is the first  
>>>> bad
>>>> commit.
>>>>
>>>> From the looks of it, it didn't introduce any behavioral change. So your
>>>> help is appreciated.
>>>>
>>>> [1] https://bugs.launchpad.net/bugs/1774950
>>>
>>> Well, the only difference is the iosf quirk AFAICS, but that should be
>>> easy enough to check.  I'll try to cut a patch for that later today.
>>
>> If the iosf quirk is the source of the problem, the attached patch  
>> should help.
>
> The one below should be slightly better, please test this one.

Affected users reported that this patch solves the issue for them.

Kai-Heng

>
> ---
>  drivers/acpi/acpi_lpss.c |   18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> Index: linux-pm/drivers/acpi/acpi_lpss.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpi_lpss.c
> +++ linux-pm/drivers/acpi/acpi_lpss.c
> @@ -22,6 +22,7 @@
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pwm.h>
> +#include <linux/suspend.h>
>  #include <linux/delay.h>
>
>  #include "internal.h"
> @@ -940,9 +941,10 @@ static void lpss_iosf_exit_d3_state(void
>  	mutex_unlock(&lpss_iosf_mutex);
>  }
>
> -static int acpi_lpss_suspend(struct device *dev, bool wakeup)
> +static int acpi_lpss_suspend(struct device *dev, bool runtime)
>  {
>  	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
> +	bool wakeup = runtime || device_may_wakeup(dev);
>  	int ret;
>
>  	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
> @@ -955,13 +957,14 @@ static int acpi_lpss_suspend(struct devi
>  	 * wrong status for devices being about to be powered off. See
>  	 * lpss_iosf_enter_d3_state() for further information.
>  	 */
> -	if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
> +	if ((runtime || !pm_suspend_via_firmware()) &&
> +	    lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
>  		lpss_iosf_enter_d3_state();
>
>  	return ret;
>  }
>
> -static int acpi_lpss_resume(struct device *dev)
> +static int acpi_lpss_resume(struct device *dev, bool runtime)
>  {
>  	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
>  	int ret;
> @@ -970,7 +973,8 @@ static int acpi_lpss_resume(struct devic
>  	 * This call is kept first to be in symmetry with
>  	 * acpi_lpss_runtime_suspend() one.
>  	 */
> -	if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
> +	if ((runtime || !pm_resume_via_firmware()) &&
> +	    lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
>  		lpss_iosf_exit_d3_state();
>
>  	ret = acpi_dev_resume(dev);
> @@ -994,12 +998,12 @@ static int acpi_lpss_suspend_late(struct
>  		return 0;
>
>  	ret = pm_generic_suspend_late(dev);
> -	return ret ? ret : acpi_lpss_suspend(dev, device_may_wakeup(dev));
> +	return ret ? ret : acpi_lpss_suspend(dev, false);
>  }
>
>  static int acpi_lpss_resume_early(struct device *dev)
>  {
> -	int ret = acpi_lpss_resume(dev);
> +	int ret = acpi_lpss_resume(dev, false);
>
>  	return ret ? ret : pm_generic_resume_early(dev);
>  }
> @@ -1014,7 +1018,7 @@ static int acpi_lpss_runtime_suspend(str
>
>  static int acpi_lpss_runtime_resume(struct device *dev)
>  {
> -	int ret = acpi_lpss_resume(dev);
> +	int ret = acpi_lpss_resume(dev, true);
>
>  	return ret ? ret : pm_generic_runtime_resume(dev);
>  }
