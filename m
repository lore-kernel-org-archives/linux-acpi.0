From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Reboot PATCH (ACPI related)
Date: Sat, 12 May 2007 23:44:13 -0700
Message-ID: <20070512234413.54fc6afa.akpm@linux-foundation.org>
References: <20070512201006.GA3569@ics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:48148 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757122AbXEMGoZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 May 2007 02:44:25 -0400
In-Reply-To: <20070512201006.GA3569@ics.muni.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sat, 12 May 2007 22:10:07 +0200 Lukas Hejtmanek <xhejtman@ics.muni.c=
z> wrote:

> why the attached patch is still not included in mainline kernel? It f=
ixes boot
> problems after suspend to RAM.
>=20
> --=20
> Luk=C3=A1=C5=A1 Hejtm=C3=A1nek
>=20
>=20
> [reboot.patch  text/x-diff (564B)]
> --- arch/i386/kernel/reboot.c.old	2006-06-18 03:49:35.000000000 +0200
> +++ arch/i386/kernel/reboot.c	2006-07-01 17:29:23.000000000 +0200
> @@ -31,6 +31,12 @@
>  #ifdef CONFIG_SMP
>  static int reboot_cpu =3D -1;
>  #endif
> +#ifdef CONFIG_ACPI
> +extern u32 acpi_disable(void);
> +#else
> +static u32 acpi_disable(void){};
> +#endif
> +
>  static int __init reboot_setup(char *str)
>  {
>  	while(1) {
> @@ -322,6 +328,7 @@
> =20
>  void machine_emergency_restart(void)
>  {
> +	acpi_disable();
>  	if (!reboot_thru_bios) {
>  		if (efi_enabled) {
>  			efi.reset_system(EFI_RESET_COLD, EFI_SUCCESS, 0, NULL);

We'd prefer to fix the problem, whatever it is, rather than just turnin=
g
APCI off.

Please ensure that a full bug report has been entered at bugzilla.kerne=
l.org,
thanks.
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
