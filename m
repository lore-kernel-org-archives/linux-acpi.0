From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 01/30] ACPICA: Linuxize: reduce divergences for 20160212
 release
Date: Wed, 23 Mar 2016 18:46:06 -0700
Message-ID: <1458783966.1762.6.camel@perches.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
	 <cc3b66b74c73a66f82cb715092b6f35105a0cbf8.1458714003.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cc3b66b74c73a66f82cb715092b6f35105a0cbf8.1458714003.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2016-03-24 at 09:38 +0800, Lv Zheng wrote:
> The patch reduces source code differences between the Linux kernel an=
d the
> ACPICA upstream so that the linuxized ACPICA 20160212 release can be
> applied with reduced human intervention.

In the very first patch fragment:

> diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwreg=
s.c
[]
> @@ -152,7 +152,7 @@ acpi_hw_validate_register(struct acpi_generic_add=
ress *reg,
> =C2=A0 *
> =C2=A0 **************************************************************=
****************/
> =C2=A0
> -acpi_status acpi_hw_read(u32 *value, struct acpi_generic_address *re=
g)
> +acpi_status acpi_hw_read(u32 *value, struct acpi_generic_address * r=
eg)

The second argument * style appears the opposite of normal style
and a different style than the first argument * style.

> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
[]
> @@ -582,7 +582,7 @@ static char acpi_os_name[ACPI_MAX_OVERRIDE_LEN];
> =C2=A0
> =C2=A0acpi_status
> =C2=A0acpi_os_predefined_override(const struct acpi_predefined_names =
*init_val,
> -			=C2=A0=C2=A0=C2=A0=C2=A0char **new_val)
> +			=C2=A0=C2=A0=C2=A0=C2=A0acpi_string *new_val)

And here:

acpi_string pointer style 1:

> diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
[]
> @@ -96,7 +96,7 @@ acpi_physical_address acpi_os_get_root_pointer(void=
);
> =C2=A0#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_predefined_overrid=
e
> =C2=A0acpi_status
> =C2=A0acpi_os_predefined_override(const struct acpi_predefined_names =
*init_val,
> -			=C2=A0=C2=A0=C2=A0=C2=A0char **new_val);
> +			=C2=A0=C2=A0=C2=A0=C2=A0acpi_string * new_val);

acpi_string pointer style 2:

There are varying styles for acpi_string *

So far, this just looks sloppy.
Should the rest be reviewed?
