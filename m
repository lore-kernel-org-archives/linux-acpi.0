From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: RE: AW: iasl -d now gives segmentation fault !
Date: 23 Nov 2002 01:46:58 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1038016031.2182.1.camel@darkstar.portugal>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19B8DB@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <B9ECACBD6885D5119ADC00508B68C1EA0D19B8DB-LkGsggTGxVmSsB6bSF6DdVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

hi

I download new iasl binary and sources=20

with sources

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20021115 [Nov 21
2002]
Copyright (C) 2000 - 2002 Intel Corporation
Supports ACPI Specification Revision 2.0b

Loading Acpi table from file acpi_dsdt.dat
Segmentation fault

and with binary for the first time=20

./iasl: /lib/i686/libc.so.6: version `GLIBC_2.3' not found (required by ./i=
asl)
./iasl: /lib/i686/libc.so.6: version `GLIBC_2.3' not found (required by ./i=
asl)

glibc2.3? redhat7.3 stills in 2.2

btw
what does mean zeroed bytes? I have one bios with some cleared
information? and this gives wrong checksum ?
or wrong checksum , clears the information?
and can this information be in other "table"
like the information that is SSDT (
acpidmp SSDT | acpidisasm -n
Scope \_PR_
  Scope \_PR_.CPU0
    Name \_PR_.CPU0._PCT
    Name \_PR_.CPU0._PSS
    Name \_PR_.CPU0._PPC
)=20
What could i do about it ? try clear bios...
finally=20
I am testing in other computer (one desktop with motherboard intel
CAE810 or something like this)
and with this dsdt.bin disassemble well without problems.=20

On Mon, 2002-11-11 at 21:32, Moore, Robert wrote:
>=20
> Disassembly works fine here, but as I think I mentioned before, the poste=
d
> DSDT is corrupt;  The checksum is wrong and there are zeroed bytes in the
> file. =20
>=20
> The resulting disassembly will not compile.
>=20
> I've added a checksum check to the front end of the disassembler
>=20
> Bob
>=20
>=20
> -----Original Message-----
> From: Grover, Andrew [mailto:andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]=20
> Sent: Monday, November 11, 2002 1:15 PM
> To: 'S=E9rgio Monteiro Basto'; Herbert Nachtnebel
> Cc: acpi-devel
> Subject: RE: AW: [ACPI] iasl -d now gives segmentation fault !
>=20
> Hi Sergio,
>=20
> Have you tried compiling your own iasl from the unix source distribution?
>=20
> (Just "cd compiler;make")
>=20
> Disassembly seemed to work fine for me, with your DSDT.
>=20
> Regards -- Andy




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
