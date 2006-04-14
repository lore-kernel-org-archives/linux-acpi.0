From: Christian Heimanns <ch.heimanns@gmx.de>
Subject: Re: Suspend to disk
Date: Fri, 14 Apr 2006 13:26:35 +0200
Message-ID: <443F86EB.8060903@gmx.de>
References: <443C0C2D.1020207@gmx.de> <200604112235.18943.rjw@sisk.pl> <200604112238.07166.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.20]:32446 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750990AbWDNL1T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Apr 2006 07:27:19 -0400
In-Reply-To: <200604112238.07166.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, pavel@suse.cz

Sorry for the delay, I was on the road...

Rafael J. Wysocki wrote:
> [update]
>=20
> On Tuesday 11 April 2006 22:35, Rafael J. Wysocki wrote:
>> On Tuesday 11 April 2006 22:06, Christian Heimanns wrote:
>>> Hello to all,
>>> following situation:
>>> On my notebook Samsung X20 1730V I'm running Slackware 10.2 current=
 with
>>> kernel 2.6.15.6. Suspend to RAM and suspend to disk works fine.
>>> Since kernel >=3D 2.6.16 suspend to disk breaks the restore of the
>>> X-Server. That means that the current sessions is lost and the X-Se=
rver
>>> restarts.
>> Does it resume successfully without X (ie. runlevel 3)?
>>
>>> No problems with suspend to RAM. Please find attached the=20
>>> dmesg output for kernel 2.6.15.6 and 2.6.16.2. As well there is the
>>> output frpm lspci. The only difference I can find is that I have wi=
th
>>> kernel 2.6.16 some
>> Do you use a framebuffer driver and if so, is it modular?
>=20
> Sorry, I see in the logs that you do.  Could you please boot with vga=
=3Dnormal
> and see if that helps?
>=20

I tried kernel 2.6.16.2 with vga=3Dnormal. No changes. Suspend to RAM
works well, suspend to disk not. It's just the X-Server who restarts an=
d
 I lose the suspended X-session. The following messages I've found in
the dmesg output after resume:

pnp: Device 00:08 does not supported activation.
pnp: Device 00:09 does not supported activation.
Restarting tasks... done

No idea what pnp device 00:08 and 00:09 is! These problems I have only
with the kernel >=3D 2.6.16

Regards,
Christian
--=20
---
Christian Heimanns
ch.heimanns<at>gmx<dot>de

### Pinguine k=C3=B6nnen nicht fliegen
- Pinguine st=C3=BCrzen auch nicht ab! ###
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
