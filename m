From: Norbert Preining <preining@logic.at>
Subject: Re: [ACPI] Re: 2.6.12-rc1-mm4 and suspend2ram (and synaptics)
Date: Mon, 4 Apr 2005 00:45:57 +0200
Message-ID: <20050403224557.GB1015@gamma.logic.tuwien.ac.at>
References: <20050331220822.GA22418@gamma.logic.tuwien.ac.at> <20050401113335.GA13160@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261937AbVDCWqO@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050401113335.GA13160@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Fre, 01 Apr 2005, Pavel Machek wrote:
> > I suspends fine, but never resumes. No CapsLock, no sysrq, no netwo=
rk is
> > working. Nothing in the log files. Is there anything which may caus=
e
> > these troubles when compiled into the kernel and not loaded as modu=
le?
> > (as it was with my usb stuff until 2.6.11-mm2, after this I had to =
stop
> > hotplug, before I could go with usb running).
>=20
> Try suspend2disk, first, and try suspend2ram with minimal kernel
> config.

suspend2disk runs without any problem, even with X running.

it is only suspend2ram which stopped working after 2.6.11-mm4 (at least
in 2.6.12-rc1-mm3,4).

Concerning tests with minimal kernel config: I guess since it *was*
working there should not be a change necessary -- but well, from
2.6.11-mm2 to 2.6.11-mm4 I had to stop hotplug/usb to get ot working, s=
o
maybe now I have to stop all the other things. Grrrr. This is not what =
I
want!

Isn't there a different way?

Best wishes

Norbert

-----------------------------------------------------------------------=
--------
Norbert Preining <preining AT logic DOT at>                 Universit=E0=
 di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 5996=
6-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 0=
9C5 B094
-----------------------------------------------------------------------=
--------
DORRIDGE (n.)
Technical term for one of the lame excuses written in very small print
on the side of packets of food or washing powder to explain why
there's hardly anything inside. Examples include 'Contents may have
settled in transit' and 'To keep each biscuit fresh they have been
individually wrapped in silver paper and cellophane and separated with
corrugated lining, a cardboard flap, and heavy industrial tyres'.
			--- Douglas Adams, The Meaning of Liff
