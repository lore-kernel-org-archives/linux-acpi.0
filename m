From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: RE: AW: iasl -d now gives segmentation fault !
Date: 04 Dec 2002 00:24:03 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1038961445.1895.14.camel@darkstar.portugal>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19B95E@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <B9ECACBD6885D5119ADC00508B68C1EA0D19B95E-LkGsggTGxVmSsB6bSF6DdVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: 'acpi-devel' <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Bob
Thanks very much
I download acpica-unix-20021126.tar.gz.

I tried disassemble my DSDT and ...
the ZEROS had disappears, yes!
I fix the .dsl
and I try to override DSDT and finally works normally.

so the exstorob.c (that you send), is not needed to disassemble DSDT
but I try to compile acpica-unix with it, but the file don't match, give
many errors.
After I realize that could be applied to the kernel, and replace this
file in kernel and make the a new bzImage and try it, and I don't note
(see) any difference.

thanks=20

S=E9rgio Basto

PS: if you need more information, I will be here :)

On Mon, 2002-12-02 at 22:44, Moore, Robert wrote:
> I think that I've found the problem with your DSDT, it's an interpreter
> problem.  I am working on a fix.  Here's a preliminary fix that may fix t=
he
> problem on your machine; let me know if it works.
>=20
> Bob
>=20
>=20
> -----Original Message-----
> From: Moore, Robert=20
> Sent: Monday, November 25, 2002 9:21 AM
> To: 'S=E9rgio Monteiro Basto'; Moore, Robert; Grover, Andrew
> Cc: acpi-devel
> Subject: RE: AW: [ACPI] iasl -d now gives segmentation fault !
>=20
> There are 8 contiguous bytes in the DSDT that are very suspiciously zero
> (and they do not disassemble to valid ASL).  I believe that this is what
> causes the checksum to be incorrect.
>=20
> The fix for the segmentation fault appears in version 20021122 which has
> been completed but I don't think the patches have been posted yet.
>=20
> Bob
>=20
>=20
> -----Original Message-----
> From: S=E9rgio Monteiro Basto [mailto:sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org]=20
> Sent: Friday, November 22, 2002 5:47 PM
> To: Moore, Robert; Andrew Grover
> Cc: acpi-devel
> Subject: RE: AW: [ACPI] iasl -d now gives segmentation fault !
>=20
> hi
>=20
> I download new iasl binary and sources=20
>=20
> with sources
>=20
> Intel ACPI Component Architecture
> ASL Optimizing Compiler / AML Disassembler version 20021115 [Nov 21
> 2002]
> Copyright (C) 2000 - 2002 Intel Corporation
> Supports ACPI Specification Revision 2.0b
>=20
> Loading Acpi table from file acpi_dsdt.dat
> Segmentation fault
>=20
> and with binary for the first time=20
>=20
> ./iasl: /lib/i686/libc.so.6: version `GLIBC_2.3' not found (required by
> ./iasl)
> ./iasl: /lib/i686/libc.so.6: version `GLIBC_2.3' not found (required by
> ./iasl)
>=20
> glibc2.3? redhat7.3 stills in 2.2
>=20
> btw
> what does mean zeroed bytes? I have one bios with some cleared
> information? and this gives wrong checksum ?
> or wrong checksum , clears the information?
> and can this information be in other "table"
> like the information that is SSDT (
> acpidmp SSDT | acpidisasm -n
> Scope \_PR_
>   Scope \_PR_.CPU0
>     Name \_PR_.CPU0._PCT
>     Name \_PR_.CPU0._PSS
>     Name \_PR_.CPU0._PPC
> )=20
> What could i do about it ? try clear bios...
> finally=20
> I am testing in other computer (one desktop with motherboard intel
> CAE810 or something like this)
> and with this dsdt.bin disassemble well without problems.=20
>=20
> On Mon, 2002-11-11 at 21:32, Moore, Robert wrote:
> >=20
> > Disassembly works fine here, but as I think I mentioned before, the pos=
ted
> > DSDT is corrupt;  The checksum is wrong and there are zeroed bytes in t=
he
> > file. =20
> >=20
> > The resulting disassembly will not compile.
> >=20
> > I've added a checksum check to the front end of the disassembler
> >=20
> > Bob
> >=20
> >=20
> > -----Original Message-----
> > From: Grover, Andrew [mailto:andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]=20
> > Sent: Monday, November 11, 2002 1:15 PM
> > To: 'S=E9rgio Monteiro Basto'; Herbert Nachtnebel
> > Cc: acpi-devel
> > Subject: RE: AW: [ACPI] iasl -d now gives segmentation fault !
> >=20
> > Hi Sergio,
> >=20
> > Have you tried compiling your own iasl from the unix source distributio=
n?
> >=20
> > (Just "cd compiler;make")
> >=20
> > Disassembly seemed to work fine for me, with your DSDT.
> >=20
> > Regards -- Andy
>=20
>=20




-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
