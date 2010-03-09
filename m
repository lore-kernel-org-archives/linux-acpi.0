From: Rakib Mullick <rakib.mullick@gmail.com>
Subject: Re: [PATCH -mmotm] acpi/sbs: fix build for ACPI_SYSFS_POWER=n
Date: Tue, 9 Mar 2010 12:21:15 +0600
Message-ID: <b9df5fa11003082221u4f8ad73mee4397f3cc0f9aa9@mail.gmail.com>
References: <201003050232.o252WD4K011798@imap1.linux-foundation.org>
	 <4B916169.5040303@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B916169.5040303@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Alexey Starikovskiy <astarikovskiy@suse.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Randy,

On 3/6/10, Randy Dunlap <randy.dunlap@oracle.com> wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
>
> When CONFIG_ACPI_SYSFS_POWER is not enabled:
>
> drivers/acpi/sbs.c:640: error: implicit declaration of function
> 'acpi_battery_get_alarm'
> drivers/acpi/sbs.c:679: error: implicit declaration of function
> 'acpi_battery_set_alarm'
>
This problem is introduced by the patch
(http://lkml.org/lkml/2010/3/1/29) named
acpi-put-acpi_battery_get-set_alarm-into-config_acpi_sysfs_power.patch.
If we use CONFIG_ACPI_SYSFS_POWER=3Dy then we are warned by the
following warning:

drivers/acpi/sbs.c:399: warning: =91acpi_battery_get_alarm=92 defined b=
ut not used
drivers/acpi/sbs.c:406: warning: =91acpi_battery_set_alarm=92 defined b=
ut not used

So, I think it's better that we wrap CONFIG_ACPI_SYSFS_POWER with
#ifdef and #else. Otherwise we have to face the above warning.

Thanks,
Rakib

>
> so move those functions outside of the ifdef/endif block for that
> config option.
>
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  drivers/acpi/sbs.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- mmotm-2010-0304-1805.orig/drivers/acpi/sbs.c
> +++ mmotm-2010-0304-1805/drivers/acpi/sbs.c
> @@ -412,8 +412,6 @@ static int acpi_ac_get_present(struct ac
>  	return result;
>  }
>
> -#ifdef CONFIG_ACPI_SYSFS_POWER
> -
>  static int acpi_battery_get_alarm(struct acpi_battery *battery)
>  {
>  	return acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD,
> @@ -450,6 +448,8 @@ static int acpi_battery_set_alarm(struct
>  	return ret;
>  }
>
> +#ifdef CONFIG_ACPI_SYSFS_POWER
> +
>  static ssize_t acpi_battery_alarm_show(struct device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
