From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate
 on BYT/CHT
Date: Wed, 3 Apr 2019 10:54:31 +0200
Message-ID: <eb1462c9-ebef-7bd6-c263-3f4f2e8ba63d@redhat.com>
References: <20190403054352.30120-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403054352.30120-1-kai.heng.feng@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, rjw@rjwysocki.net
Cc: lenb@kernel.org, rhowell@uwyo.edu, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On 03-04-19 07:43, Kai-Heng Feng wrote:
> i2c-designware-platdrv fails to work after the system restored from
> hibernation:
> [ 272.775692] i2c_designware 80860F41:00: Unknown Synopsys component type: 0xffffffff
> 
> Commit 48402cee6889 ("ACPI / LPSS: Resume BYT/CHT I2C controllers from
> resume_noirq") makes acpi_lpss_{suspend_late,resume_early}() bail early
> on BYT/CHT as resume_from_noirq is set. This means dw_i2c_plat_resume()
> doesn't gets called by acpi_lpss_resume_early(), and this causes the
> issue.
> 
> Introduce acpi_lpss_{poweroff_late,restore_early}() to make sure
> driver's own poweroff_late and restore_early get called.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202139
> Fixes: 48402cee6889 ("ACPI / LPSS: Resume BYT/CHT I2C controllers from resume_noirq")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

The ordering problem fixed by commit 48402cee6889 can hit hibernate too,
so I think it would be better to do this instead to fix this problem:

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 1e2a10a06b9d..cf768608437e 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -1142,8 +1142,8 @@ static struct dev_pm_domain acpi_lpss_pm_domain = {
  		.thaw_noirq = acpi_subsys_thaw_noirq,
  		.poweroff = acpi_subsys_suspend,
  		.poweroff_late = acpi_lpss_suspend_late,
-		.poweroff_noirq = acpi_subsys_suspend_noirq,
-		.restore_noirq = acpi_subsys_resume_noirq,
+		.poweroff_noirq = acpi_lpss_suspend_noirq,
+		.restore_noirq = acpi_lpss_resume_noirq,
  		.restore_early = acpi_lpss_resume_early,
  #endif
  		.runtime_suspend = acpi_lpss_runtime_suspend,

Then the i2c controllers on platforms with the resume_from_noirq
flag set for them will be ready for use while the PCI subsystem
runs the _PS0 / _PS3 methods of PCI devices which may use the
i2c controllers (which is what commit 48402cee6889 set out to fix
in the first place).

If people affected by the problem can give my version of the fix a test,
then that would be great.

Regards,

Hans




> ---
>   drivers/acpi/acpi_lpss.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 1e2a10a06b9d..49aef186d73d 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -1058,6 +1058,11 @@ static int acpi_lpss_suspend_late(struct device *dev)
>   	return acpi_lpss_do_suspend_late(dev);
>   }
>   
> +static int acpi_lpss_poweroff_late(struct device *dev)
> +{
> +	return acpi_lpss_do_suspend_late(dev);
> +}
> +
>   static int acpi_lpss_suspend_noirq(struct device *dev)
>   {
>   	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
> @@ -1089,6 +1094,11 @@ static int acpi_lpss_resume_early(struct device *dev)
>   	return acpi_lpss_do_resume_early(dev);
>   }
>   
> +static int acpi_lpss_restore_early(struct device *dev)
> +{
> +	return acpi_lpss_do_resume_early(dev);
> +}
> +
>   static int acpi_lpss_resume_noirq(struct device *dev)
>   {
>   	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
> @@ -1141,10 +1151,10 @@ static struct dev_pm_domain acpi_lpss_pm_domain = {
>   		.freeze_noirq = acpi_subsys_freeze_noirq,
>   		.thaw_noirq = acpi_subsys_thaw_noirq,
>   		.poweroff = acpi_subsys_suspend,
> -		.poweroff_late = acpi_lpss_suspend_late,
> +		.poweroff_late = acpi_lpss_poweroff_late,
>   		.poweroff_noirq = acpi_subsys_suspend_noirq,
>   		.restore_noirq = acpi_subsys_resume_noirq,
> -		.restore_early = acpi_lpss_resume_early,
> +		.restore_early = acpi_lpss_restore_early,
>   #endif
>   		.runtime_suspend = acpi_lpss_runtime_suspend,
>   		.runtime_resume = acpi_lpss_runtime_resume,
> 
