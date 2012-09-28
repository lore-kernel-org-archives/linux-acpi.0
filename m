From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: shutdown with toshiba portege
Date: Fri, 28 Sep 2012 16:23:55 +0300
Message-ID: <20120928132354.GG28937@mwanda>
References: <20120920204234.0fb035a89f88a2e1f468aa54@maison.homelinux.net>
 <20120921165753.7a5701fc6a0e1445daa92500@maison.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120921165753.7a5701fc6a0e1445daa92500@maison.homelinux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Fran=E7ois?= Boisson <user.anti-spam@maison.homelinux.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Sep 21, 2012 at 04:57:53PM +0200, Fran=E7ois Boisson wrote:
> Le Thu, 20 Sep 2012 20:42:34 +0200
> Fran=E7ois Boisson  <user.anti-spam@maison.homelinux.net> a =E9crit:
>=20
> > Hey=20
> >=20
> > I have a problem which seems to be related to shutdown for a Toshib=
a portege
> > (it's seems that the problem is also on other Toshiba, on VAIO cw5,=
 y
> [...]
> > If i shutdown the computer and wait some hours, the power consumpti=
on of the
> > computer is not null, it's about the same as the power consumtion d=
uring a
> > suspend of computer. In fact
> >=20
> > Boot and halt with:
> > Windows 7 ---> No power consumption after
> > Linux 2.6.37-486-PAE --->  No power consumption after
> > Linux >=3D 3.0  ---> Power consumption (about 45-50 mW if acpitool =
is correct)
> [...]
>=20
> Well can anybody just tell me the sequence of shutdown and power of a=
 x86
> computer in then linux kernell, or just how to verify that a device i=
s power
> off with a printk, or where to search or even only where is the part =
of code
> doing this. There is many documentation about use device but nothing =
about
> power off.
>=20

So your Toshiba is going into suspend instead of power off...

There are several ways that computers shutdown but modern systems
use ACPI.  It could be that the 2.6.37-486-PAE was using a
different method.  I've CC'd the ACPI list.

regards,
dan carpenter
