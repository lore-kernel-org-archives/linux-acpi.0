From: Piotr Hosowicz <piotr@hosowicz.com>
Subject: Re: BUG: scheduling while atomic: swapper/0/0x10000002
Date: Tue, 10 Aug 2010 17:19:21 +0200
Message-ID: <4C616DF9.1070309@example.com>
References: <20100810142951.GA7156@arch.tripp.de>
Reply-To: piotr@hosowicz.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100810142951.GA7156@arch.tripp.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: Heinz Diehl <htd@fancy-poultry.org>, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 10.08.2010 16:29, Markus Trippelsdorf wrote:

> This bug already has two patches available to fix it:
>
> http://lkml.org/lkml/2010/8/6/672
> https://patchwork.kernel.org/patch/113092/

None of them works for me. I do:

cat patch.txt | patch -p1

And get:

aapi205:/usr/src/linux# cat ../smp-bug.txt | patch -p1
patching file include/acpi/platform/aclinux.h
Hunk #1 FAILED at 152.
1 out of 1 hunk FAILED -- saving rejects to file=20
include/acpi/platform/aclinux.h.rej

Help me please.

Regards,

Piotr Hosowicz

--=20
Zatrzymuje si=EA samoch=F3d na sejmowym parkingu. Podchodzi do niego=20
ochroniarz i m=F3wi:
- Pan tu parkuje?! Tu Sejm ... Ministrowie, politycy, pos=B3owiei ...
- Dzi=EAki, w=B3=B1cz=EA alarm.
NP: Peter Green Splinter Group - There's A River
NB: 2.6.35-git9
