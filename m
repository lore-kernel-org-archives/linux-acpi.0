From: Norbert Preining <preining@logic.at>
Subject: Re: [ACPI] Call for help: list of machines with working S3
Date: Wed, 16 Feb 2005 10:51:59 +0100
Message-ID: <20050216095159.GA25764@gamma.logic.tuwien.ac.at>
References: <20050214211105.GA12808@elf.ucw.cz> <20050215125555.GD16394@gamma.logic.tuwien.ac.at> <42121EC5.8000004@gmx.net> <20050215170837.GA6336@gamma.logic.tuwien.ac.at> <4212460A.4000100@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-Disposition: inline
In-Reply-To: <4212460A.4000100@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Cc: Pavel Machek <pavel@suse.cz>, ACPI mailing list <acpi-devel@lists.sourceforge.net>, kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
List-Id: linux-acpi@vger.kernel.org

Hi Carl-Daniel, hi all,

On Die, 15 Feb 2005, Carl-Daniel Hailfinger wrote:
> > - DRI must be disabled I guess?! Even with newer X server (x.org)?
>=20
> I never disabled it.

Here X freezes (Sysrq-b works) with DRI enabled (debian sid, x4.3.0.1,
kernel 2.6.11-rc3-mm2, radeon, drm as modules)

> I used to unload modules, shutdown network interfaces etc. until I
> tried without all that stuff and it still worked. So I concluded

YOu are right. I only have to stop the mysql server and everything is
working. Thanks.

Only one thing (maybe covered somewhere else): After resuming (without
having stopped the usb system) my external mouse (USB) stopped working.

Is there a way to reactive the external mouse?

> I'll prepare a web page with detailed S3/S4 suspend/resume
> information for ATI graphics card owners including step-by-step
> howtos for smooth suspend/resume cycles.

Great idea! I was really searching for something like this. I will chec=
k
as soon as you have something online wether I have to add something!

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
CORRIEVORRIE (n.)
Corridor etiquette demands that one a corriedoo (q.v.) has been
declared, corrievorrie must be employed. Both protagonists must now
embellish their approach with an embarrassing combination of waving,
grinning, making idiot faces, doing pirate impressions, and waggling
the head from side to side while holding the other person's eyes as
the smile drips off their face, until with great relief, they pass
each other.
			--- Douglas Adams, The Meaning of Liff
