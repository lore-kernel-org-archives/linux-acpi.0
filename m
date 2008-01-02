From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [linux-pm] Re: [patch] hibernation: utilize ACPI hardware signature
Date: Thu, 03 Jan 2008 08:25:41 +1100
Message-ID: <477C0155.70902@nigel.suspend2.net>
References: <1199257162.14632.4.camel@sli10-desk.sh.intel.com>	<62e5edd40801020208s268aeacbj96481f5a317b8ea7@mail.gmail.com> <200801021512.54140.rjw@sisk.pl>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from home.nigel.suspend2.net ([203.171.70.205]:47497 "EHLO
	server1.example.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752888AbYABVZz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jan 2008 16:25:55 -0500
In-Reply-To: <200801021512.54140.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: =?ISO-8859-15?Q?Erik_Andr=E9n?= <erik.andren@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, linux acpi <linux-acpi@vger.kernel.org>

Hi.

Rafael J. Wysocki wrote:
> On Wednesday, 2 of January 2008, Erik Andr=E9n wrote:
>> Hi,
>>
>> 2008/1/2, Shaohua Li <shaohua.li@intel.com>:
>>> ACPI defines a hardware signature. BIOS calculates the signature
>>> according to hardware configure, if hardware changes, the signature=
 will
>>> change, in this case, S4 resume should fail.
>>>
>>> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
>>> ---
>>
>> Would it be possible to extend this mechanism to prevent the followi=
ng
>> scenario:
>>
>> 1. Linux image A is suspended to disk
>> 2. Linux image B is booted and various changes to the system are don=
e.
>> 3. Linux image B is shut down
>> 4. Linux image A is booted, restoring the suspend to disk image.
>> 5. Chaos is ensured as the file system state is changed in regard to=
 how
>> linux image A expects it.
>>
>> Correct behaviour would naturally be that image A detects that chang=
es have
>> been made under its feet and proceed to perform a normal boot instea=
d of
>> resuming the stored suspend-to-disk image.
>=20
> It should be possible in theory.
>=20
>> Is there another mechanism preventing this?
>=20
> Not at the kernel level, but you can prevent this from happening by r=
unning
> mkswap on all swap spaces that refuse to come up after a fresh boot.

We really should do something about this. It should be possible to
handle this properly if something along the following lines was impleme=
nted:

1) Each filesystem implements a function taking a pointer to a struct
block_device and returns a mount count for that filesystem without
making any modifications to the filesystem.
2) Hibernation implementations store the major & minor numbers and moun=
t
counts for each mounted filesystem in the image header when hibernating=
,
and recheck those values at resume time. If the mount count on any
filesystem has changes, we warn the user, invalidate the image and boot
normally.

Regards,

Nigel
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
