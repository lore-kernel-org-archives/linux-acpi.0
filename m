From: Norbert Preining <preining@logic.at>
Subject: Re: b44 driver suspend/resume (was Re: [ACPI] Re: Re: various problems with Acer TM654, suspend, ACAD, radeon)
Date: Wed, 25 Aug 2004 16:40:38 +0200
Sender: linux-net-owner@vger.kernel.org
Message-ID: <20040825144038.GA17522@gamma.logic.tuwien.ac.at>
References: <20040820161911.GA24510@gamma.logic.tuwien.ac.at> <20040823070534.GD24853@message-id.gmane0305.slipkontur.de> <20040823103515.GH8635@gamma.logic.tuwien.ac.at> <20040824233153.GA15474@message-id.gmane0305.slipkontur.de> <20040825131109.GD6119@gamma.logic.tuwien.ac.at> <412C9980.803@optonline.net> <412CA0F5.4@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-net-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <412CA0F5.4@optonline.net>
To: Nathan Bryant <nbryant@optonline.net>
Cc: Stefan Seyfried <seife@gmane0305.slipkontur.de>, acpi-devel@lists.sourceforge.net, linux-net@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Nathan!

On Mit, 25 Aug 2004, Nathan Bryant wrote:
> >Somebody needs to check if there is some code path that could preven=
t=20
> >b44 from calling request_irq()...
>=20
> Oops, never mind that. That's just because you hadn't ifup'd the devi=
ce=20

I did.

> yet. But I still suspect a driver issue; your IRQ routing looks like =
it=20
> should be OK, but somebody is sending repeated interrupts. You could=20
> test with "acpi=3Dnoirq", but I don't think that will help.

It worked!!!! Yes, no problems. Booting with acpi=3Dnoirq and loading t=
he
b44 module let it find irq 5 and it is working. I am writing this email
from after a resume, even X worked out of the box.

> Maybe what's happening here is the kernel believes I/O is already=20
> mapped, because it has loaded the memory image from before suspend.
>=20
> I think the first step is to fix the b44 driver's suspend and resume=20
> callbacks. They are definitely missing some critical PCI calls.

What it means that it works with acpi=3Dnoirq with regard to the above =
--
no idea. YOu know better.

So, is this something which should be fixed? That it is not working
without acpi=3Dnoirq?

Best wishes

Norbert

-----------------------------------------------------------------------=
--------
Norbert Preining <preining AT logic DOT at>         Technische Universi=
t=E4t Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 0=
9C5 B094
-----------------------------------------------------------------------=
--------
What the hell, he thought, you're only young once, and
threw himself out of the window. That would at least keep
the element of surprise on his side.
                 --- Ford outwitting a Vogon with a rocket launcher by =
going
                 --- into another certain death situation.
                 --- Douglas Adams, The Hitchhikers Guide to the Galaxy
