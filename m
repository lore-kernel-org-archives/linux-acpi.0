From: Norbert Preining <preining@logic.at>
Subject: Re: b44 driver suspend/resume (was Re: [ACPI] Re: Re: various problems with Acer TM654, suspend, ACAD, radeon)
Date: Wed, 25 Aug 2004 16:54:53 +0200
Sender: linux-net-owner@vger.kernel.org
Message-ID: <20040825145453.GC17522@gamma.logic.tuwien.ac.at>
References: <20040820161911.GA24510@gamma.logic.tuwien.ac.at> <20040823070534.GD24853@message-id.gmane0305.slipkontur.de> <20040823103515.GH8635@gamma.logic.tuwien.ac.at> <20040824233153.GA15474@message-id.gmane0305.slipkontur.de> <20040825131109.GD6119@gamma.logic.tuwien.ac.at> <412C9980.803@optonline.net> <412CA0F5.4@optonline.net> <20040825144038.GA17522@gamma.logic.tuwien.ac.at> <412CA7DE.8050706@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-net-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <412CA7DE.8050706@optonline.net>
To: Nathan Bryant <nbryant@optonline.net>
Cc: Stefan Seyfried <seife@gmane0305.slipkontur.de>, acpi-devel@lists.sourceforge.net, linux-net@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mit, 25 Aug 2004, Nathan Bryant wrote:
> >It worked!!!! Yes, no problems. Booting with acpi=3Dnoirq and loadin=
g the
> >b44 module let it find irq 5 and it is working. I am writing this em=
ail
> >from after a resume, even X worked out of the box.
>=20
> Back to the drawing board. :( That means there's still something wron=
g=20
> with pci_link.c

SOme more information: I successfully completed a suspend/resume cycle
even with b44 loaded! Not even my ssh connection broke down!

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
HIGH OFFLEY (n.)
Gossnargh (q.v.) three weeks later.
			--- Douglas Adams, The Meaning of Liff
