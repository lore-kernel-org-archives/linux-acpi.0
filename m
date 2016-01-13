From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC] halt to s4 for WOL
Date: Wed, 13 Jan 2016 23:18:05 +0100
Message-ID: <4414773.OA3SXZMMXi@vostro.rjw.lan>
References: <F6B43707-732A-4D93-9007-5D05A9C40989@exactcode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43507 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755596AbcAMWRc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jan 2016 17:17:32 -0500
In-Reply-To: <F6B43707-732A-4D93-9007-5D05A9C40989@exactcode.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.com>
Cc: linux-acpi@vger.kernel.org

On Wednesday, January 13, 2016 06:06:18 PM Ren=C3=A9 Rebe wrote:
> Hi all,
>=20
> for some years our old Mac Pro and newer Mac mini used for unit testi=
ng and VMs
> annoyed me in that we could never get Wake-On-Lan working on them at =
all.
>=20
> Some people found some pci config bit poking for some older Mac mini =
that did not
> work on our newer Mac mini, nor on our older Mac Pro.
>=20
> 	http://blog.dhampir.no/content/wake-on-lan-on-a-n-intel-mac-mini-wit=
h-linux
>=20
> While we where setting up some new things we finally wanted this solv=
ed, and I found
> a clever workaround by halting the machine to S4 instead of S5.
>=20
> While of course this patch can not be applied as it. I just wanted to=
 ask for feedback -
> maybe a kernel or sysfs interface can be added to have a halt=3DS4 or=
 whatever
> switch as this might be useful to convince other machines to supply p=
ower to the NIC,
> too.

This potentially has side effects beyond the wakeup devices handling, s=
o I won't
recommend doing that in general.

Also, this seems to be a policy decision made by the platform designers=
=2E  Apparently,
they don't want you to wake up from "off" via WoL.

>=20
> --- linux-4.3/drivers/acpi/sleep.c.orig	2015-12-29 15:27:21.100959963=
 +0000
> +++ linux-4.3/drivers/acpi/sleep.c	2015-12-29 15:28:36.828960630 +000=
0
> @@ -811,7 +811,7 @@
> static void acpi_power_off_prepare(void)
> {
> 	/* Prepare to power off the system */
> -	acpi_sleep_prepare(ACPI_STATE_S5);
> +	acpi_sleep_prepare(ACPI_STATE_S4);
> 	acpi_disable_all_gpes();
> 	acpi_os_wait_events_complete();
> }
> @@ -821,7 +821,7 @@
> 	/* acpi_sleep_prepare(ACPI_STATE_S5) should have already been called=
 */
> 	printk(KERN_DEBUG "%s called\n", __func__);
> 	local_irq_disable();
> -	acpi_enter_sleep_state(ACPI_STATE_S5);
> +	acpi_enter_sleep_state(ACPI_STATE_S4);
> }
>=20
> int __init acpi_sleep_init(void)

Thanks,
Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
