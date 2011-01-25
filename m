From: Ozan =?utf-8?q?=C3=87a=C4=9Flayan?= <ozan@pardus.org.tr>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus laptops)
Date: Tue, 25 Jan 2011 08:22:48 +0200
Message-ID: <201101250822.48287.ozan@pardus.org.tr>
References: <556624.21214.qm@web28409.mail.ukl.yahoo.com> <4D3DDDA4.2080202@yahoo.fr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4D3DDDA4.2080202@yahoo.fr>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Lionel Debroux <lionel_debroux@yahoo.fr>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, rjw@sisk.pl, colin.king@canonical.com
List-Id: linux-acpi@vger.kernel.org

Pazartesi 24 Ocak 2011 g=C3=BCn=C3=BC (saat 22:14:28) Lionel Debroux =C5=
=9Funlar=C4=B1 yazm=C4=B1=C5=9Ft=C4=B1:
> On 24.01.2011 10:47, Lionel Debroux wrote:

> None of nolapic, acpi=3Doff, nolapic acpi=3Doff enables 2.6.35.8 to b=
oot
> on my ASUS F3Jv-AS022P.
> The kernel line is
> kernel /boot/vmlinuz root=3D/dev/sda9 nomce vga=3D791 nomodeset
> I've attached the 2.6.35.6 config.

Yes one of my reporters also tells that on 2.6.35 the problem can't be =
cured with nolapic
but on 2.6.37 it helps.



---
Ozan =C3=87a=C4=9Flayan
TUBITAK/UEKAE - Pardus Linux
http://www.pardus.org.tr/eng
