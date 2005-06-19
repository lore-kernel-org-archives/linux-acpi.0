From: Rene ONIER <rene-qAWGX91z7iYdbCeoMzGj59i2O/JbrIOy@public.gmane.org>
Subject: Errors compiling a dstd.dsl on MandrivaLE2005/Acer TravelMate
 2304WLMI
Date: Sun, 19 Jun 2005 16:52:34 -0400
Message-ID: <1119214354.26427.17.camel@hermes.shanga.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I'm trying to compile a dsdt.dsl patched against the sbs-linux files.
http://sourceforge.net/projects/sbs-linux/

I can get the DSDT file from /proc/acpi/dsdt, I patch it
(successfully) with acer-tm4xxx-sbs-cm.diff bu
t I fail to compile it.

I'm a REAL newbie with ACPI, so any help is welcome :)
Thanks in advance.
Ren=E9.

PS: I know, being root is EVIL.

--------------------------------------------------------
[root@hermes sbs-cm-20050328]# iasl -d dsdt.dat

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20050513 [Jun 19
2005]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

Loading Acpi table from file dsdt.dat
Acpi table [DSDT] successfully installed and loaded
Pass 1 parse of [DSDT]
Pass 2 parse of [DSDT]
Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
.........................................................................=
.........................................................................=
.........................................................................=
........
Parsing completed
Disassembly completed, written to "dsdt.dsl"

[root@hermes sbs-cm-20050328]# patch < acer-tm4xxx-sbs-cm.diff
patching file dsdt.dsl
Hunk #1 succeeded at 2077 (offset -1178 lines).
Hunk #2 succeeded at 2105 (offset -1178 lines).
Hunk #3 succeeded at 3678 (offset -1249 lines).
[root@hermes sbs-cm-20050328]#

[root@hermes sbs-cm-20050328]# iasl dsdt.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20050513 [Jun 19
2005]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

dsdt.dsl   169:     Method (_WAK, 1, NotSerialized)
Warning  2026 -                ^ Reserved method must return a value
(_WAK)

dsdt.dsl   331:                     0x0100, 0x00,,)
Error    1094 -                                   ^ Missing
ResourceSource string (required)

dsdt.dsl   338:                     , TypeStatic)
Error    1094 -                                 ^ Missing ResourceSource
string (required)

dsdt.dsl   346:                     , TypeStatic)
Error    1094 -                                 ^ Missing ResourceSource
string (required)

dsdt.dsl   353:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   360:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   367:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   374:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   381:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   388:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   395:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   402:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   409:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   416:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   423:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   430:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   437:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   444:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   451:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl   458:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^

dsdt.dsl  3176:                         Method (_STA, 0, NotSerialized)
Warning  2019 -                                    ^ Not all control
paths return a value (_STA)

dsdt.dsl  3176:                         Method (_STA, 0, NotSerialized)
Warning  2026 -                                    ^ Reserved method
must return a value (_STA)

smbus-cm.asl    87:         Method (_SBI, 0, NotSerialized)
Warning  2033 -  Unknown reserved name ^  (_SBI)

smbus-cm.asl   147:         Method (_SBR, 3, NotSerialized)
Warning  2033 -  Unknown reserved name ^  (_SBR)

smbus-cm.asl   237:         Method (_SBW, 5, NotSerialized)
Warning  2033 -  Unknown reserved name ^  (_SBW)

smbus-cm.asl   314:         Method (_SBA, 0, NotSerialized)
Warning  2033 -  Unknown reserved name ^  (_SBA)

ASL Input:  dsdt.dsl - 3690 lines, 174462 bytes, 2344 keywords
Compilation complete. 19 Errors, 7 Warnings, 0 Remarks, 611
Optimizations






-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
