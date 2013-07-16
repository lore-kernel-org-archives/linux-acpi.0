From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] ACPI:remove panic in case hardware has changed after S4
Date: Tue, 16 Jul 2013 15:32:01 +0800
Message-ID: <1373959921.6260.61.camel@linux-s257.site>
References: <1373888637-20737-1-git-send-email-oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:53459 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161Ab3GPHcJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jul 2013 03:32:09 -0400
In-Reply-To: <1373888637-20737-1-git-send-email-oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: oliver@neukum.org
Cc: lenb@kernel.org, rjw@sisk.pl, trenn@suse.de, linux-acpi@vger.kernel.org, Oliver Neukum <oneukum@suse.de>

=E6=96=BC =E4=B8=80=EF=BC=8C2013-07-15 =E6=96=BC 13:43 +0200=EF=BC=8Col=
iver@neukum.org =E6=8F=90=E5=88=B0=EF=BC=9A
> From: Oliver Neukum <oneukum@suse.de>
>=20
> Some BIOSes change hardware based on the state of
> a laptop's lid. If the lid is closed, the touchpad is
> disabled and the checksum changes. Windows 8 no longer
> aborts resume if the checksum has changed.
>=20
> Signed-off-by: Oliver Neukum <oneukum@suse.de>
> ---
>  drivers/acpi/sleep.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 9c1a435..14744e5 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -664,11 +664,9 @@ static void acpi_hibernation_leave(void)
>  	/* Reprogram control registers */
>  	acpi_leave_sleep_state_prep(ACPI_STATE_S4);
>  	/* Check the hardware signature */
> -	if (facs && s4_hardware_signature !=3D facs->hardware_signature) {
> -		printk(KERN_EMERG "ACPI: Hardware changed while hibernated, "
> -			"cannot resume!\n");
> -		panic("ACPI S4 hardware signature mismatch");
> -	}
> +	if (facs && s4_hardware_signature !=3D facs->hardware_signature)
> +		printk(KERN_CRIT "ACPI: Hardware changed while hibernated, "
> +			"success doubtful!\n");
>  	/* Restore the NVS memory area */
>  	suspend_nvs_restore();
>  	/* Allow EC transactions to happen. */

This morning I tried to reproduce the hardware_signature change on my
Acer notebook, I hope can monitor the change on Linux then use Windows =
8
to check the behavior.
Unfortunately I can not reproduce the hardware_signature change by
remove memory or PCI device(wifi module) with Linux kernel.

=46or PCI device, as ACPI spec's declare, it didn't causes
hardware_signature change, I print out in acpi_hibernation_leave() to
confirm it.

=46or memory size, before the S4 resume path run to
acpi_hibernation_leave(), kernel check the physical memory pages number
in snapshot_write_next() then -EPERM if physical pages change . So, it
doesn't have chance to check the hardware_signature changed.

Base on the above testing, correct my originally thinking, the
hardware_signature check could not detect the change of memory size
because it's too late.

Sorry for I didn't find out the actual behavior of Windows 8 to confirm
it ignore hardware_signature change. At least could not verify on my
machine.


Thanks a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
