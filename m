From: Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH] Add bluetooth support to toshiba-acpi driver
Date: Mon, 22 Oct 2007 15:28:46 +0100
Message-ID: <20071022142845.GL1880@earth.li>
References: <20071021173529.GH1880@earth.li> <471C88E2.3020102@neggie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753263AbXJVO26@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <471C88E2.3020102@neggie.net>
Sender: linux-kernel-owner@vger.kernel.org
To: John Belmonte <john@neggie.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Oct 22, 2007 at 07:26:26AM -0400, John Belmonte wrote:
> > This patch adds bluetooth support to the toshiba-acpi driver. I hav=
e
> > tried to follow the same format for the /proc/acpi/toshiba/bluetoot=
h
> > file as followed in the thinkpad-acpi driver. In the long term the
> > rfkill infrastructure looks like the way forward for this functiona=
lity,
> > but at present it doesn't seem to be suitable.
> >
> > Traditionally the userland "toshset" program would have been used t=
o
> > enable bluetooth, but this requires either CONFIG_TOSHIBA or a patc=
hed
> > toshiba-acpi to emulate the /dev/toshiba device. Also toshset doesn=
't
> > currently run in 64bit mode.
> >
> > Patch has been successfully tested on a Port=E9g=E9 R200 (in 32bit =
mode) and
> > an R500 (in 64bit mode).
> >
> > Signed-Off-By: Jonathan McDowell <noodles@earth.li>
>=20
> The /proc/acpi/toshiba interface should not be expanded-- do not appl=
y
> this patch.  If any patch is applied, it would be to optionally
> implement the generic /dev/toshiba interface so that user space tools
> like toshset can operate.

There's been a patch to add the /dev/toshiba functionality floating
around for at least a year or two. Is there a reason it hasn't already
been applied?

I'm not entirely convinced that userland is the right way to do this
though. In the long run rfkill appears to be the correct generic
infrastructure, but at present it's not able to cope with devices that
don't exist when switched off and I can't find any other users in
mainline anyway. Assuming that changes, would you accept a patch adding
support for it to toshiba-acpi?

J.

--=20
                                            jid: noodles@jabber.earth.l=
i
I had a life once... but now I have a
                                            modem.
