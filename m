From: =?UTF-8?B?UmljaGFyZCBTY2jDvHR6?= <r.schtz@t-online.de>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus
 laptops)
Date: Sun, 23 Jan 2011 16:00:53 +0100
Message-ID: <4D3C42A5.6060909@t-online.de>
References: <4D3C3B1E.1080500@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D3C3B1E.1080500@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, rjw@sisk.pl
List-Id: linux-acpi@vger.kernel.org

> Hi,
>
> I'm getting a lot of bug reports about hanging boot/shutdowns on thes=
e
> days.
>
> Most of the affected hardware are ASUS laptops. The problem is that I
> don't have access to any of those problematic laptops and the users a=
re
> not able at all to debug/bisect what is going on. However, I have
> collected dmesgs of good/bad boots, acpidump, etc.
>
> Here are the current status:
>
> "Asus F50SV does not boot unless lapic is passed"
> https://bugzilla.kernel.org/show_bug.cgi?id=3D26502
>
> "Regression between 2.6.35-020635-rc1 and 2.6.35-020635 breaks acpi
> support on Asus X71 laptop"
> https://bugs.launchpad.net/ubuntu/+source/linux-meta/+bug/689796
>
> "Asus N61JQ hangs at shutdown unless lapic is passed"
> (Not reported upstream yet, I've only downstream bug report which is
> Turkish)
> http://bugs.pardus.org.tr/show_bug.cgi?id=3D15969
>
> "Asus X61S does not boot unless acpi=3Doff is given"
> (Not reported upstream yet, I've only downstream bug report which is
> Turkish)
> http://bugs.pardus.org.tr/show_bug.cgi?id=3D16322
> (I've told the reporter to try with nolapic, it will probably fix the
> issue but until confirmed acpi=3Doff is the only solution. 2.6.36 was=
 fine)
>
> I'll post more bugs in here as I've found them.
>
> Thanks,
>

Looks like these are all Intel machines. Do they use intel_idle for the=
=20
CPU powersaving features?
(cat /sys/devices/system/cpu/cpuidle/current_driver)

If yes - does booting with intel_idle.max_cstate=3D0 or=20
intel_idle.max_cstate=3D3 boot parameter help?

It could be related to https://bugzilla.kernel.org/show_bug.cgi?id=3D21=
952=20
somehow, which seems to be an 2.6.35 regression.

--=20
Regards,
Richard Sch=C3=BCtz
