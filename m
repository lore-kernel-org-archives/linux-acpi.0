From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: AW: iasl -d now gives segmentation fault !
Date: Mon, 2 Dec 2002 14:44:28 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B95E@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C29A54.5F0AF840"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?ISO-8859-1?Q?=27S=E9rgio_Monteiro_Basto=27?= <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Cc: 'acpi-devel' <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C29A54.5F0AF840
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

I think that I've found the problem with your DSDT, it's an interpreter
problem.  I am working on a fix.  Here's a preliminary fix that may fix =
the
problem on your machine; let me know if it works.

Bob


-----Original Message-----
From: Moore, Robert=20
Sent: Monday, November 25, 2002 9:21 AM
To: 'S=E9rgio Monteiro Basto'; Moore, Robert; Grover, Andrew
Cc: acpi-devel
Subject: RE: AW: [ACPI] iasl -d now gives segmentation fault !

There are 8 contiguous bytes in the DSDT that are very suspiciously =
zero
(and they do not disassemble to valid ASL).  I believe that this is =
what
causes the checksum to be incorrect.

The fix for the segmentation fault appears in version 20021122 which =
has
been completed but I don't think the patches have been posted yet.

Bob


-----Original Message-----
From: S=E9rgio Monteiro Basto [mailto:sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org]=20
Sent: Friday, November 22, 2002 5:47 PM
To: Moore, Robert; Andrew Grover
Cc: acpi-devel
Subject: RE: AW: [ACPI] iasl -d now gives segmentation fault !

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

./iasl: /lib/i686/libc.so.6: version `GLIBC_2.3' not found (required =
by
./iasl)
./iasl: /lib/i686/libc.so.6: version `GLIBC_2.3' not found (required =
by
./iasl)

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
> Disassembly works fine here, but as I think I mentioned before, the =
posted
> DSDT is corrupt;  The checksum is wrong and there are zeroed bytes in =
the
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
> Have you tried compiling your own iasl from the unix source =
distribution?
>=20
> (Just "cd compiler;make")
>=20
> Disassembly seemed to work fine for me, with your DSDT.
>=20
> Regards -- Andy



------_=_NextPart_000_01C29A54.5F0AF840
Content-Type: application/octet-stream;
	name="exstorob.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="exstorob.c"

=0A=
/***********************************************************************=
*******=0A=
 *=0A=
 * Module Name: exstorob - AML Interpreter object store support, store =
to object=0A=
 *              $Revision: 46 $=0A=
 *=0A=
 =
************************************************************************=
*****/=0A=
=0A=
/*=0A=
 *  Copyright (C) 2000 - 2002, R. Byron Moore=0A=
 *=0A=
 *  This program is free software; you can redistribute it and/or =
modify=0A=
 *  it under the terms of the GNU General Public License as published =
by=0A=
 *  the Free Software Foundation; either version 2 of the License, =
or=0A=
 *  (at your option) any later version.=0A=
 *=0A=
 *  This program is distributed in the hope that it will be useful,=0A=
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
 *  GNU General Public License for more details.=0A=
 *=0A=
 *  You should have received a copy of the GNU General Public =
License=0A=
 *  along with this program; if not, write to the Free Software=0A=
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  =
02111-1307  USA=0A=
 */=0A=
=0A=
=0A=
#include "acpi.h"=0A=
#include "acinterp.h"=0A=
=0A=
=0A=
#define _COMPONENT          ACPI_EXECUTER=0A=
	 ACPI_MODULE_NAME    ("exstorob")=0A=
=0A=
=0A=
/***********************************************************************=
********=0A=
 *=0A=
 * FUNCTION:    Acpi_ex_store_buffer_to_buffer=0A=
 *=0A=
 * PARAMETERS:  Source_desc         - Source object to copy=0A=
 *              Target_desc         - Destination object of the copy=0A=
 *=0A=
 * RETURN:      Status=0A=
 *=0A=
 * DESCRIPTION: Copy a buffer object to another buffer object.=0A=
 *=0A=
 =
************************************************************************=
******/=0A=
=0A=
acpi_status=0A=
acpi_ex_store_buffer_to_buffer (=0A=
	acpi_operand_object     *source_desc,=0A=
	acpi_operand_object     *target_desc)=0A=
{=0A=
	u32                     length;=0A=
	u8                      *buffer;=0A=
=0A=
=0A=
	ACPI_FUNCTION_NAME ("Ex_store_buffer_to_buffer");=0A=
=0A=
=0A=
	/*=0A=
	 * We know that Source_desc is a buffer by now=0A=
	 */=0A=
	buffer =3D (u8 *) source_desc->buffer.pointer;=0A=
	length =3D source_desc->buffer.length;=0A=
=0A=
	/*=0A=
	 * If target is a buffer of length zero or is a static buffer,=0A=
	 * allocate a new buffer of the proper length=0A=
	 */=0A=
	if ((target_desc->buffer.length =3D=3D 0) ||=0A=
		(target_desc->common.flags & AOPOBJ_STATIC_POINTER)) {=0A=
		target_desc->buffer.pointer =3D ACPI_MEM_ALLOCATE (length);=0A=
		if (!target_desc->buffer.pointer) {=0A=
			return (AE_NO_MEMORY);=0A=
		}=0A=
=0A=
		target_desc->common.flags &=3D ~AOPOBJ_STATIC_POINTER;=0A=
		target_desc->buffer.length =3D length;=0A=
	}=0A=
=0A=
	/*=0A=
	 * Buffer is a static allocation,=0A=
	 * only place what will fit in the buffer.=0A=
	 */=0A=
	if (length <=3D target_desc->buffer.length) {=0A=
		/* Clear existing buffer and copy in the new one */=0A=
=0A=
		ACPI_MEMSET (target_desc->buffer.pointer, 0, =
target_desc->buffer.length);=0A=
		ACPI_MEMCPY (target_desc->buffer.pointer, buffer, length);=0A=
	}=0A=
	else {=0A=
		/*=0A=
		 * Truncate the source, copy only what will fit=0A=
		 */=0A=
		ACPI_MEMCPY (target_desc->buffer.pointer, buffer, =
target_desc->buffer.length);=0A=
=0A=
		ACPI_DEBUG_PRINT ((ACPI_DB_INFO,=0A=
			"Truncating src buffer from %X to %X\n",=0A=
			length, target_desc->buffer.length));=0A=
	}=0A=
=0A=
	/* Copy flags */=0A=
=0A=
	target_desc->buffer.flags =3D source_desc->buffer.flags;=0A=
	return (AE_OK);=0A=
}=0A=
=0A=
=0A=
/***********************************************************************=
********=0A=
 *=0A=
 * FUNCTION:    Acpi_ex_store_string_to_string=0A=
 *=0A=
 * PARAMETERS:  Source_desc         - Source object to copy=0A=
 *              Target_desc         - Destination object of the copy=0A=
 *=0A=
 * RETURN:      Status=0A=
 *=0A=
 * DESCRIPTION: Copy a String object to another String object=0A=
 *=0A=
 =
************************************************************************=
******/=0A=
=0A=
acpi_status=0A=
acpi_ex_store_string_to_string (=0A=
	acpi_operand_object     *source_desc,=0A=
	acpi_operand_object     *target_desc)=0A=
{=0A=
	u32                     length;=0A=
	u8                      *buffer;=0A=
=0A=
=0A=
	ACPI_FUNCTION_ENTRY ();=0A=
=0A=
=0A=
	/*=0A=
	 * We know that Source_desc is a string by now.=0A=
	 */=0A=
	buffer =3D (u8 *) source_desc->string.pointer;=0A=
	length =3D source_desc->string.length;=0A=
=0A=
	/*=0A=
	 * Setting a string value replaces the old string=0A=
	 */=0A=
	if ((length < target_desc->string.length) &&=0A=
	   (!(target_desc->common.flags & AOPOBJ_STATIC_POINTER))) {=0A=
		/*=0A=
		 * String will fit in existing non-static buffer.=0A=
		 * Clear old string and copy in the new one=0A=
		 */=0A=
		ACPI_MEMSET (target_desc->string.pointer, 0, (ACPI_SIZE) =
target_desc->string.length + 1);=0A=
		ACPI_MEMCPY (target_desc->string.pointer, buffer, length);=0A=
	}=0A=
	else {=0A=
		/*=0A=
		 * Free the current buffer, then allocate a new buffer=0A=
		 * large enough to hold the value=0A=
		 */=0A=
		if (target_desc->string.pointer &&=0A=
		   (!(target_desc->common.flags & AOPOBJ_STATIC_POINTER))) {=0A=
			/*=0A=
			 * Only free if not a pointer into the DSDT=0A=
			 */=0A=
			ACPI_MEM_FREE (target_desc->string.pointer);=0A=
		}=0A=
=0A=
		target_desc->string.pointer =3D ACPI_MEM_CALLOCATE ((ACPI_SIZE) =
length + 1);=0A=
		if (!target_desc->string.pointer) {=0A=
			return (AE_NO_MEMORY);=0A=
		}=0A=
=0A=
		target_desc->common.flags &=3D ~AOPOBJ_STATIC_POINTER;=0A=
		ACPI_MEMCPY (target_desc->string.pointer, buffer, length);=0A=
	}=0A=
=0A=
	/* Set the new target length */=0A=
=0A=
	target_desc->string.length =3D length;=0A=
	return (AE_OK);=0A=
}=0A=
=0A=
=0A=

------_=_NextPart_000_01C29A54.5F0AF840--


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
