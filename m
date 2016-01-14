From: =?iso-8859-1?Q?Ren=E9_Rebe?= <rene@exactcode.com>
Subject: Re: [RFC] halt to s4 for WOL
Date: Thu, 14 Jan 2016 15:30:36 +0100
Message-ID: <9462F2FD-78CF-4F45-B668-F69114BF6DAB@exactcode.com>
References: <F6B43707-732A-4D93-9007-5D05A9C40989@exactcode.com> <4414773.OA3SXZMMXi@vostro.rjw.lan>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.exactcode.de ([144.76.154.42]:46390 "EHLO mx.exactcode.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754440AbcANQoR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jan 2016 11:44:17 -0500
In-Reply-To: <4414773.OA3SXZMMXi@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org

Hi,

On Jan 13, 2016, at 23:18, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> On Wednesday, January 13, 2016 06:06:18 PM Ren=E9 Rebe wrote:
>> Hi all,
>>=20
>> for some years our old Mac Pro and newer Mac mini used for unit test=
ing and VMs
>> annoyed me in that we could never get Wake-On-Lan working on them at=
 all.
>>=20
>> Some people found some pci config bit poking for some older Mac mini=
 that did not
>> work on our newer Mac mini, nor on our older Mac Pro.
>>=20
>> 	http://blog.dhampir.no/content/wake-on-lan-on-a-n-intel-mac-mini-wi=
th-linux
>>=20
>> While we where setting up some new things we finally wanted this sol=
ved, and I found
>> a clever workaround by halting the machine to S4 instead of S5.
>>=20
>> While of course this patch can not be applied as it. I just wanted t=
o ask for feedback -
>> maybe a kernel or sysfs interface can be added to have a halt=3DS4 o=
r whatever
>> switch as this might be useful to convince other machines to supply =
power to the NIC,
>> too.
>=20
> This potentially has side effects beyond the wakeup devices handling,=
 so I won't
> recommend doing that in general.
>=20
> Also, this seems to be a policy decision made by the platform designe=
rs.  Apparently,
> they don't want you to wake up from "off" via WoL.

Yes, this appears to be their policy, however, that does not help us ve=
ry much.

So far this workaround works here without any issue. E.g. no spurious w=
akeups
or other side effects that I would notice.

Of course I can happily keep it my private patch collection, the questi=
on is
if this would be worth to wire to some halt=3Ds4 codlin option or other=
 alternative
sysfs etc. config option.

	Ren=E9

>> --- linux-4.3/drivers/acpi/sleep.c.orig	2015-12-29 15:27:21.10095996=
3 +0000
>> +++ linux-4.3/drivers/acpi/sleep.c	2015-12-29 15:28:36.828960630 +00=
00
>> @@ -811,7 +811,7 @@
>> static void acpi_power_off_prepare(void)
>> {
>> 	/* Prepare to power off the system */
>> -	acpi_sleep_prepare(ACPI_STATE_S5);
>> +	acpi_sleep_prepare(ACPI_STATE_S4);
>> 	acpi_disable_all_gpes();
>> 	acpi_os_wait_events_complete();
>> }
>> @@ -821,7 +821,7 @@
>> 	/* acpi_sleep_prepare(ACPI_STATE_S5) should have already been calle=
d */
>> 	printk(KERN_DEBUG "%s called\n", __func__);
>> 	local_irq_disable();
>> -	acpi_enter_sleep_state(ACPI_STATE_S5);
>> +	acpi_enter_sleep_state(ACPI_STATE_S4);
>> }
>>=20
>> int __init acpi_sleep_init(void)
>=20
> Thanks,
> Rafael
>=20

--=20
 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
 http://exactcode.com | http://exactscan.com | http://ocrkit.com | http=
://t2-project.org | http://rene.rebe.de

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
