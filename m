From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH -mmotm] acpi/sbs: fix build for ACPI_SYSFS_POWER=n
Date: Fri, 05 Mar 2010 23:37:19 +0300
Message-ID: <4B916B7F.4000204@suse.de>
References: <201003050232.o252WD4K011798@imap1.linux-foundation.org> <4B916169.5040303@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B916169.5040303@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org


Randy Dunlap =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> From: Randy Dunlap <randy.dunlap@oracle.com>
>=20
> When CONFIG_ACPI_SYSFS_POWER is not enabled:
>=20
> drivers/acpi/sbs.c:640: error: implicit declaration of function 'acpi=
_battery_get_alarm'
> drivers/acpi/sbs.c:679: error: implicit declaration of function 'acpi=
_battery_set_alarm'
>=20
>=20
> so move those functions outside of the ifdef/endif block for that
> config option.
>=20
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
>  drivers/acpi/sbs.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> --- mmotm-2010-0304-1805.orig/drivers/acpi/sbs.c
> +++ mmotm-2010-0304-1805/drivers/acpi/sbs.c
> @@ -412,8 +412,6 @@ static int acpi_ac_get_present(struct ac
>  	return result;
>  }
> =20
> -#ifdef CONFIG_ACPI_SYSFS_POWER
> -
>  static int acpi_battery_get_alarm(struct acpi_battery *battery)
>  {
>  	return acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD,
> @@ -450,6 +448,8 @@ static int acpi_battery_set_alarm(struct
>  	return ret;
>  }
> =20
> +#ifdef CONFIG_ACPI_SYSFS_POWER
> +
>  static ssize_t acpi_battery_alarm_show(struct device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
