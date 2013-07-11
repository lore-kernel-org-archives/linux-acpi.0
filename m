From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] ACPI:remove panic in case hardware has changed after S4
Date: Fri, 12 Jul 2013 04:50:22 +0800
Message-ID: <1373575822.7539.74.camel@linux-s257.site>
References: <1373544870-15135-1-git-send-email-oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:57880 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756652Ab3GKUvb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jul 2013 16:51:31 -0400
In-Reply-To: <1373544870-15135-1-git-send-email-oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: oliver@neukum.org
Cc: lenb@kernel.org, rjw@sisk.pl, trenn@suse.de, linux-acpi@vger.kernel.org, Oliver Neukum <oneukum@suse.de>

=E6=96=BC =E5=9B=9B=EF=BC=8C2013-07-11 =E6=96=BC 14:14 +0200=EF=BC=8Col=
iver@neukum.org =E6=8F=90=E5=88=B0=EF=BC=9A
> From: Oliver Neukum <oneukum@suse.de>
>=20
> Some BIOSes change hardware based on the state of
> a laptop's lid. If the lid is closed, the touchpad is
> disabled and the checksum changes.
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

This panic is also reflect to the memory size changed by user when
machine in S4 state, BIOS should update hardware_signature to raise
memory changed.

Does it a good idea don't panic here if memory size changed?

Should we need try to detect the change of memory or touchpad for know
should we panic or not?

>  	/* Restore the NVS memory area */
>  	suspend_nvs_restore();
>  	/* Allow EC transactions to happen. */

On the other hand, I saw another BIOS changed hardware_signature becaus=
e
the VGA detect output resolution changed when S4 resume. It's a problem
for sometimes BIOS widely used hardware_signature on non-critical
hardware change.


Thanks a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
