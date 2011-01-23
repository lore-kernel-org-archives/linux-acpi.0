From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus
 laptops)
Date: Sun, 23 Jan 2011 22:24:48 +0200
Message-ID: <4D3C8E90.6010506@pardus.org.tr>
References: <4D3C3B1E.1080500@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lider.pardus.org.tr ([193.140.100.216]:48438 "EHLO
	lider.pardus.org.tr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132Ab1AWUYu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 23 Jan 2011 15:24:50 -0500
In-Reply-To: <4D3C3B1E.1080500@pardus.org.tr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, rjw@sisk.pl, colin.king@canonical.com

On 23.01.2011 16:28, Ozan =C3=87a=C4=9Flayan wrote:
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

(CC'ing: Colin King from Canonical)

Another one for Asus N90Sc which was booting fine with 10.04
but fails to boot with 10.10:
  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/653626

Seen that the issue mostly happens on Asus boxes, it's possible
that their firmwares are buggy but they were booting/shutting down
correctly until a recent change in kernel.


--=20
Pardus Linux
http://www.pardus.org.tr/eng
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
