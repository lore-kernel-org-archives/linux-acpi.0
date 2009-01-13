From: "Karthik Gopalakrishnan" <karthik.g.krishnan@gmail.com>
Subject: Re: [RFC] [PATCH] panasonic-laptop.c: add support for CD power management
Date: Tue, 13 Jan 2009 12:16:45 -0500
Message-ID: <5e0a1fd80901130916x510395ddwdab40c867e32212b@mail.gmail.com>
References: <20090113163233.GA734@dezo.moloch.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:33605 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204AbZAMRQs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Jan 2009 12:16:48 -0500
Received: by ey-out-2122.google.com with SMTP id 22so20530eye.37
        for <linux-acpi@vger.kernel.org>; Tue, 13 Jan 2009 09:16:46 -0800 (PST)
In-Reply-To: <20090113163233.GA734@dezo.moloch.sk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Martin Lucina <mato@kotelna.sk>
Cc: linux-acpi@vger.kernel.org, laforge@gnumonks.org

Hi Martin.

To an end user, writing "0" to enable the device & "1" to disable it
sounds counter-intuitive, especially when the sysfs entry is called
"cdpower". Is there a reason to not flip that?

Regards,
Karthik

On Tue, Jan 13, 2009 at 11:32 AM, Martin Lucina <mato@kotelna.sk> wrote:
> Hello,
>
> attached is a patch to the panasonic-laptop driver to enable power
> management (i.e. on/off) of the built-in optical drive.  It creates a
> sysfs interface /sys/devices/platform/panasonic/cdpower which can be
> either queried or written to.  Writing "0" enables the device, "1"
> disables it.
>
> This code is based on reading the existing code[1][2],
> examining the DSDT on my CF-W4 system and experimentation.
>
> The presence of the CF-Y series in the DMI table is based on the
> assumption that this method works on recent CF-Yx models.
>
> I have a few questions I'd like to clear up before actually submitting
> this for inclusion:
>
> 1) Is a platform device the right way to do this?
>
> 2) Rather than checking the DMI system vendor and product name would it
> be a better approach to simply check for the presence of the \_SB.FBAY()
> and \_SB.STAT() ACPI methods and enable the platform device on any
> (Panasonic) system where these are present?  This would seem like a
> more future-proof approach.
>
> 3) Please advise on the correct way to propagate an error result from
> the functions that call the ACPI methods {get,set}optd_power_state() to
> userspace in the sysfs interface.  I couldn't find a straightforward
> example anywhere.
>
> Thanks!
>
> -mato
>
> [1] Referenced here http://www.da-cha.jp/letsnote as "A patch to handle
> CD on/off button(need to merge)" (now a dead link)
> [2] http://www.netlab.is.tsukuba.ac.jp/~yokota/izumi/panasonic_acpi/,
> see the 20070907 version ("includes small hack for CD-ROM drive")
>
> ---
>
> --- linux-2.6.28/drivers/misc/panasonic-laptop.c.orig   2009-01-13 17:01:53.327106958 +0100
> +++ linux-2.6.28/drivers/misc/panasonic-laptop.c        2009-01-13 17:04:04.911106197 +0100
> @@ -24,6 +24,8 @@
>  *---------------------------------------------------------------------------
>  *
>  * ChangeLog:
> + *     Jan.13, 2009    Martin Lucina <mato@kotelna.sk>
> + *             -v0.96  add support for optical drive power in Y and W series
>  *     Sep.23, 2008    Harald Welte <laforge@gnumonks.org>
>  *             -v0.95  rename driver from drivers/acpi/pcc_acpi.c to
>  *                     drivers/misc/panasonic-laptop.c
> @@ -127,6 +129,8 @@
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
>  #include <linux/input.h>
> +#include <linux/platform_device.h>
> +#include <linux/dmi.h>
>
>
>  #ifndef ACPI_HOTKEY_COMPONENT
> @@ -219,6 +223,7 @@ struct pcc_acpi {
>        struct acpi_device      *device;
>        struct input_dev        *input_dev;
>        struct backlight_device *backlight;
> +       struct platform_device  *platform;
>        int                     keymap[KEYMAP_SIZE];
>  };
>
> @@ -226,6 +231,27 @@ struct pcc_keyinput {
>        struct acpi_hotkey      *hotkey;
>  };
>
> +/* known models with optical drive */
> +static struct dmi_system_id pcc_platform_dmi_table[] = {
> +       {
> +               .ident = "Panasonic Toughbook W Series",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR,
> +                               "Matsushita Electric Industrial Co.,Ltd."),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "CF-W"),
> +               },
> +       },
> +       {
> +                .ident = "Panasonic Toughbook Y Series",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR,
> +                               "Matsushita Electric Industrial Co.,Ltd."),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "CF-Y"),
> +               },
> +       },
> +       { }
> +};
> +
>  /* method access functions */
>  static int acpi_pcc_write_sset(struct pcc_acpi *pcc, int func, int val)
>  {
> @@ -360,6 +386,63 @@ static struct backlight_ops pcc_backligh
>        .update_status  = bl_set_status,
>  };
>
> +/* get optical driver power state */
> +
> +static int get_optd_power_state(void)
> +{
> +       acpi_status status;
> +       unsigned long long state;
> +       int result;
> +
> +       status = acpi_evaluate_integer(NULL, "\\_SB.STAT", NULL, &state);
> +       if (ACPI_FAILURE(status)) {
> +               result = -EIO;
> +               goto out;
> +       }
> +       switch (state) {
> +       case 0: /* power off */
> +               result = 1;
> +               break;
> +       case 0x0f: /* power on */
> +               result = 0;
> +               break;
> +       default:
> +               result = -EIO;
> +               break;
> +       }
> +out:
> +       return result;
> +}
> +
> +/* set optical drive power state */
> +
> +static int set_optd_power_state(int new_state)
> +{
> +       int state, result;
> +       acpi_status status;
> +
> +       state = get_optd_power_state();
> +       if (new_state == state)
> +               return 0;
> +
> +       result = 0;
> +       switch (new_state) {
> +       case 0: /* power on */
> +               status = acpi_evaluate_object (NULL, "\\_SB.FBAY", NULL, NULL);
> +               if (ACPI_FAILURE(status))
> +                       result = -EIO;
> +               break;
> +       case 1: /* power off */
> +               status = acpi_evaluate_object (NULL, "\\_SB.CDDI", NULL, NULL);
> +               if (ACPI_FAILURE(status))
> +                       result = -EIO;
> +               break;
> +       default:
> +               result = -EINVAL;
> +               break;
> +       }
> +       return result;
> +}
>
>  /* sysfs user interface functions */
>
> @@ -427,10 +510,29 @@ static ssize_t set_sticky(struct device
>        return count;
>  }
>
> +static ssize_t show_cdpower(struct device *dev, struct device_attribute *attr,
> +                           char *buf)
> +{
> +       return snprintf(buf, PAGE_SIZE, "%d\n", get_optd_power_state());
> +}
> +
> +static ssize_t set_cdpower(struct device *dev, struct device_attribute *attr,
> +                          const char *buf, size_t count)
> +{
> +       int value;
> +
> +       if (count) {
> +               value = simple_strtoul(buf, NULL, 10);
> +               set_optd_power_state (value);
> +       }
> +       return count;
> +}
> +
>  static DEVICE_ATTR(numbatt, S_IRUGO, show_numbatt, NULL);
>  static DEVICE_ATTR(lcdtype, S_IRUGO, show_lcdtype, NULL);
>  static DEVICE_ATTR(mute, S_IRUGO, show_mute, NULL);
>  static DEVICE_ATTR(sticky_key, S_IRUGO | S_IWUSR, show_sticky, set_sticky);
> +static DEVICE_ATTR(cdpower, S_IRUGO | S_IWUSR, show_cdpower, set_cdpower);
>
>  static struct attribute *pcc_sysfs_entries[] = {
>        &dev_attr_numbatt.attr,
> @@ -691,8 +793,26 @@ static int acpi_pcc_hotkey_add(struct ac
>        if (result)
>                goto out_backlight;
>
> +       /* platform device initialization */
> +       if (!dmi_check_system(pcc_platform_dmi_table)) {
> +               pcc->platform = NULL;
> +               goto out_no_optd;
> +       }
> +       pcc->platform = platform_device_register_simple("panasonic", -1,
> +               NULL, 0);
> +       if (IS_ERR(pcc->platform)) {
> +               result = PTR_ERR(pcc->platform);
> +               goto out_backlight;
> +       }
> +       result = device_create_file(&pcc->platform->dev, &dev_attr_cdpower);
> +       if (result)
> +               goto out_platform;
> +
> +out_no_optd:
>        return 0;
>
> +out_platform:
> +       platform_device_unregister(pcc->platform);
>  out_backlight:
>        backlight_device_unregister(pcc->backlight);
>  out_notify:
> @@ -738,6 +858,11 @@ static int acpi_pcc_hotkey_remove(struct
>        if (!device || !pcc)
>                return -EINVAL;
>
> +       if (pcc->platform) {
> +               device_remove_file(&pcc->platform->dev, &dev_attr_cdpower);
> +               platform_device_unregister(pcc->platform);
> +       }
> +
>        sysfs_remove_group(&device->dev.kobj, &pcc_attr_group);
>
>        backlight_device_unregister(pcc->backlight);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
