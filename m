From: Lionel Debroux <lionel_debroux@yahoo.fr>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus laptops)
Date: Mon, 24 Jan 2011 09:04:35 +0000 (GMT)
Message-ID: <179044.7274.qm@web28416.mail.ukl.yahoo.com>
References: <4D3C8E90.6010506@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nm9.bullet.mail.ukl.yahoo.com ([217.146.182.250]:46442 "HELO
	nm9.bullet.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751413Ab1AXJEh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Jan 2011 04:04:37 -0500
In-Reply-To: <4D3C8E90.6010506@pardus.org.tr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, rjw@sisk.pl, colin.king@canonical.com, =?utf-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>



--- En date de=C2=A0: Dim 23.1.11, Ozan =C3=87a=C4=9Flayan <ozan@pardus=
=2Eorg.tr>
a =C3=A9crit=C2=A0:

> De: Ozan =C3=87a=C4=9Flayan <ozan@pardus.org.tr>
> Objet: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly=
 Asus laptops)
> =C3=80: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, pla=
tform-driver-x86@vger.kernel.org, rjw@sisk.pl, colin.king@canonical.com
> Date: Dimanche 23 janvier 2011, 21h24
> On 23.01.2011 16:28, Ozan =C3=87a=C4=9Flayan
> wrote:
> > Hi,
> >
> > I'm getting a lot of bug reports about hanging
> boot/shutdowns on these
> > days.
> >
> > Most of the affected hardware are ASUS laptops. The
> problem is that I
> > don't have access to any of those problematic laptops
> and the users are
> > not able at all to debug/bisect what is going on.
> However, I have
> > collected dmesgs of good/bad boots, acpidump, etc.
> >
> > Here are the current status:
> >
> > "Asus F50SV does not boot unless lapic is passed"
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D26502
> >
> > "Regression between 2.6.35-020635-rc1 and
> 2.6.35-020635 breaks acpi
> > support on Asus X71 laptop"
> > https://bugs.launchpad.net/ubuntu/+source/linux-meta/+bug/689796
> >
> > "Asus N61JQ hangs at shutdown unless lapic is passed"
> > (Not reported upstream yet, I've only downstream bug
> report which is
> > Turkish)
> > http://bugs.pardus.org.tr/show_bug.cgi?id=3D15969
> >
> > "Asus X61S does not boot unless acpi=3Doff is given"
> > (Not reported upstream yet, I've only downstream bug
> report which is
> > Turkish)
> > http://bugs.pardus.org.tr/show_bug.cgi?id=3D16322
> > (I've told the reporter to try with nolapic, it will
> probably fix the
> > issue but until confirmed acpi=3Doff is the only
> solution. 2.6.36 was fine)
> >
> > I'll post more bugs in here as I've found them.
>=20
> (CC'ing: Colin King from Canonical)
>=20
> Another one for Asus N90Sc which was booting fine with
> 10.04
> but fails to boot with 10.10:
> =C2=A0 https://bugs.launchpad.net/ubuntu/+source/linux/+bug/653626
>=20
> Seen that the issue mostly happens on Asus boxes, it's
> possible
> that their firmwares are buggy but they were
> booting/shutting down
> correctly until a recent change in kernel.
My ASUS F3Jv-AS022P (Core 2 Duo T7200, 2 GB RAM, BIOS version
207) has trouble (read: it reboots within one second of the
vmlinuz being loaded) with recent kernels as well.

While I haven't performed a full bisection yet (which is why=20
I didn't try reporting the problem until I saw this thread),
I have narrowed down the problem by compiling several tagged
versions:
* 2.6.35 series: .4 and .6 boot successfully, .8 and .10 fail;
* 2.6.36 series: -rc2 boots successfully, .1 fails;
* 2.6.37 series: -rc4 fails.


I can perform further testing if needed.


Regards,
Lionel.


     =20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
