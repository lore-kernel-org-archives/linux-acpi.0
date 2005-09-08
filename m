From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Latest acpica
Date: Thu, 8 Sep 2005 09:50:03 -0700
Message-ID: <971FCB6690CD0E4898387DBF7552B90E02A69A30@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

The compilation errors of this form:


dsdt_org.dsl   149:                     , AddressRangeMemory,
TypeStatic)

Error    1094 -                Missing ResourceSource string (required)
^

=20
are caused by specifying a ResourceIndex with no corresponding
ResourceString.  We recently tightened up the iASL compiler to detect
this condition and flag it as an error, as per the following text from
the ACPI specification, 3.0:


DWord Address Space Descriptor=20

Byte 46
 Resource Source Index
 (Optional) Only present if Resource Source (below) is present. This
field gives an index to the specific resource descriptor that this
device consumes from in the current resource template for the device
object pointed to in Resource Source.
=20


A relevant ASL source statement is below.

=20

                DWordMemory (ResourceProducer, PosDecode, MinFixed,
MaxFixed, Cacheable, ReadWrite,

                    0x00000000, // Address Space Granularity

                    0x000A0000, // Address Range Minimum

                    0x000BFFFF, // Address Range Maximum

                    0x00000000, // Address Translation Offset

                    0x00020000, 0x00,,

                    , AddressRangeMemory, TypeStatic)

=20

It is the 0x00 that is causing the issue, it should not be there.

=20

However, we recently changed the disassembler to detect this condition
within existing AML code and to emit ASL code that is compilable.  In
this case, the statement comes out of the disassembler like this:

=20

                DWordMemory (ResourceProducer, PosDecode, MinFixed,
MaxFixed, Cacheable, ReadWrite,

                    0x00000000, // Address Space Granularity

                    0x000A0000, // Address Range Minimum

                    0x000BFFFF, // Address Range Maximum

                    0x00000000, // Address Translation Offset

                    0x00020000,,,

                    , AddressRangeMemory, TypeStatic)

=20

Which is compilable code.

=20

This change to the disassembler appeared in ACPICA version 20050617:

=20

Enhanced the disassembler to emit compilable code in the face of
incorrect AML resource descriptors. If the optional ResourceSourceIndex
is present, but the ResourceSource is not, do not emit the
ResourceSourceIndex in the disassembly. Otherwise, the resulting code
cannot be compiled without errors.


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Thomas Renninger
> Sent: Thursday, September 08, 2005 3:16 AM
> To: ML ACPI-devel
> Subject: [ACPI] Latest acpica
>=20
> acpica-unix-20050902.tar.gz
> is now available under:
> http://developer.intel.com/technology/iapc/acpi/downloads.htm
> Thanks.
>=20
> There is one concern:
> This has been discussed some weeks ago.
> The compiler throws dozens of errors on some DSDTs:
>=20
> DSDT.dsl   777:                     , AddressRangeMemory, TypeStatic)
> Error    1084 -            Missing ResourceSource string (required) ^
>=20
> I cannot find the mail now, but IIRC Len said this was added to
identify
> how many DSDTs violate specs (is it optional or not?) and should be
> removed
> again later.
>=20
> The patch attached lowers the error to a warning, so that you get a
> compiled
> DSDT as output.
> Not sure, maybe the error/warning case should be reverted totally?
>=20
>=20
>       Thomas


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
