From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: ethernet effectively hangs machine (2.4.22+acpi)
Date: 04 Nov 2003 01:47:43 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1067928463.2727.50.camel@dhcppc4>
References: <Pine.NEB.4.58.0311022050090.24086@panix1.panix.com>
	 <1067830424.1434.6.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1067830424.1434.6.camel-4/PLUo9XfK/yXfm4dIG/yWZHpeb/A1Y/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Cc: Jonathan Gold <jgold-VmQCmMdMyN0AvxtiuMwx3w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

The latest ACPI patch against 2.4.22 lives here:

http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2=
.4.22/

If you apply this patch to 2.4.22 and find that the default
configuration hangs, but acpi=3Dht, acpi=3Doff, noapic, or acpi=3Doff
work, then please let me know.

Note that the -ac patch below and the ACPI patch above are mutually
exclusive (unless you manually merge the conflicts).

thanks,
-Len



On Sun, 2003-11-02 at 22:33, S=E9rgio Monteiro Basto wrote:
> Hi=20
> if for you, it is simple .
> Can you make the same test
> withhttp://www.kernel.org/pub/linux/kernel/people/alan/linux-2.4/2.4.22=
/patch-2.4.22-ac4.bz2
>=20
> you can use almost the same kernel configuration.
> This version are very stable (for me).
> If you made some tests with it, let me know!=20
>=20
> thanks
>=20
> On Mon, 2003-11-03 at 01:50, Jonathan Gold wrote:
> > i've been reading through the last month or so of this list, and
> > trying various searches on google for this issue, but can't find
> > anything. i imagine it's something fairly basic which i'm not doing,
> > but i don't know what that might be.
> >=20
> > i compiled a 2.4.22 from scratch with the acpi stuff statically linke=
d
> > into the kernel. i had some problems with usb for awhile, but got tha=
t
> > figured out. now i can boot into the acpi-enable kernel, but the
> > system essentially hangs when bringing up eth0 (it might timeout
> > eventually, but i haven't seen it do that yet). i tried manually
> > bringing up eth0 and assigning it a static ip, which worked, but when
> > i tried to ping another machine, i froze up again.
> >=20
> > can someone possible forward me an earlier discussion of this issue. =
i
> > can't be the first.
> >=20
> > thank you,
> >=20
> > jon
> >=20
> >=20
> > -------------------------------------------------------
> > This SF.net email is sponsored by: SF.net Giveback Program.
> > Does SourceForge.net help you be more productive?  Does it
> > help you create better code?   SHARE THE LOVE, and help us help
> > YOU!  Click Here: http://sourceforge.net/donate/
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
