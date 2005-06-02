From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: DSDT Problems with Acer Aspire 1691WLMi
Date: Thu, 02 Jun 2005 17:04:00 +0200
Message-ID: <429F1FE0.9080208@suse.de>
References: <1117711110.7363.9.camel@localhost.localdomain> <429F1315.80600@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <429F1315.80600-whniv8GeeGkdnm+yROfE0A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: DJAX <djax-whniv8GeeGkdnm+yROfE0A@public.gmane.org>
Cc: ACPI <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, dani-fQczH/8Hd3rnGZpH1ro7E16hYfS7NtTn@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

DJAX wrote:
> Daniel Solsona a =E9crit :
>=20
>>Hi all, I just buyed an acer aspire 1691WLMi and I'm having some
>>problems with the acpi.
>>
>>I donwloaded the custom dsdt table from acpi.sourceforge.net and the
>>iasl compiler version 20050513 [Jun  1 2005]
>>
>>I'm having problems compiling the dsdt, those are the errors I get:
>>
>>Unknown resource descriptor type [ERRORNODE]
>>dsdt.dsl   950:                     0x0100, 0x00,,)
>>Error    1094 -                                   ^ Missing
>>ResourceSource string (required)
>>........
>>........
>>........
>>dsdt.dsl  1063:                     , AddressRangeMemory, TypeStatic)
>>Error    1094 -            Missing ResourceSource string (required) ^=20
>>
>>dsdt.dsl  1070:                     , AddressRangeMemory, TypeStatic,
>>ResourceSource)
>>Error    1037 -         syntax error, unexpected ',', expecting ')' ^=20
>>
>>ASL Input:  dsdt.dsl - 6918 lines, 243620 bytes, 3165 keywords
>>Compilation complete. 18 Errors, 0 Warnings, 0 Remarks, 1116
>>Optimizations
>>
>>I have two diferent errors, the first one and the 17 others are the
>>same.
>>
>>After reading James Sparenberg problem, and the fix that Bruno Ducrot
>>told him, I tried to eliminate all the  ResourceSourceIndex but on my
>>dsdt there is no ResourceSourceIndex.
>>
>>I have too some errors on syslog:
>>
>>Jun  2 12:59:25 localhost kernel:     ACPI-0352: *** Error: Looking up
>>[Z00B] in namespace, AE_NOT_FOUND
>>Jun  2 12:59:25 localhost kernel: search_node dfa2c1a0 start_node
>>dfa2c1a0
>>return_node 00000000
>>Jun  2 12:59:25 localhost kernel:     ACPI-1138: *** Error: Method
>>execution failed [\_SB_.BAT1._BST] (Node dfa2cf80), AE_NOT_FOUND
>>Jun  2 12:59:26 localhost kernel:     ACPI-0352: *** Error: Looking up
>>[Z00B] in namespace, AE_NOT_FOUND
>>Jun  2 12:59:26 localhost kernel: search_node dfa2c1a0 start_node
>>dfa2c1a0
>>return_node 00000000
>>Jun  2 12:59:26 localhost kernel:     ACPI-1138: *** Error: Method
>>execution failed [\_SB_.BAT1._BST] (Node dfa2cf80), AE_NOT_FOUND
>>
>>
>>Thanks for the help
>>=20
>>
> I notice that the ACER-Aspire_1691WLMi-S3C11-custom.asl compile
> errorfree with the version 20050309:
> ----------------8<----------------
> Intel ACPI Component Architecture
> ASL Optimizing Compiler / AML Disassembler version 20050309 [May  3 200=
5]
> Copyright (C) 2000 - 2005 Intel Corporation
> Supports ACPI Specification Revision 3.0
>=20
> ASL Input:  ACER-Aspire_1691WLMi-S3C11-custom.asl - 6918 lines, 243604
> bytes, 3165 keywords
> AML Output: DSDT.aml - 27193 bytes 669 named objects 2496 executable op=
codes
>=20
> Compilation complete. 0 Errors, 0 Warnings, 0 Remarks, 1111 Optimizatio=
ns
> ---------------->8----------------
> But produce 18 errors with version 20050513
> ----------------8<----------------
> Intel ACPI Component Architecture
> ASL Optimizing Compiler / AML Disassembler version 20050513 [Jun  2 200=
5]
> Copyright (C) 2000 - 2005 Intel Corporation
> Supports ACPI Specification Revision 3.0
>=20
> dsdt.20050507.dsl   978:                     0x0100, 0x00,,)
> Error    1094 -   Missing ResourceSource string (required) ^
>=20
> dsdt.20050507.dsl   985:                     , TypeStatic)
> Error    1094 - Missing ResourceSource string (required) ^
>=20
> dsdt.20050507.dsl   993:                     , TypeStatic)
> Error    1094 - Missing ResourceSource string (required) ^
>=20
> dsdt.20050507.dsl  1000:                     , AddressRangeMemory,
> TypeStatic)
> Error    1094 -                     Missing ResourceSource string
> (required) ^
>=20
> dsdt.20050507.dsl  1007:                     , AddressRangeMemory,
> TypeStatic)
> Error    1094 -                     Missing ResourceSource string
> (required) ^
>=20
> dsdt.20050507.dsl  1014:                     , AddressRangeMemory,
> TypeStatic)
> Error    1094 -                     Missing ResourceSource string
> (required) ^
>=20
> dsdt.20050507.dsl  1021:                     , AddressRangeMemory,
> TypeStatic)
> Error    1094 -                     Missing ResourceSource string
> (required) ^
>=20
> dsdt.20050507.dsl  1028:                     , AddressRangeMemory,
> TypeStatic)
> Error    1094 -                     Missing ResourceSource string
> (required) ^
>=20
> dsdt.20050507.dsl  1035:                     , AddressRangeMemory,
> TypeStatic)
> Error    1094 -                     Missing ResourceSource string
> (required) ^
>=20
> dsdt.20050507.dsl  1042:                     , AddressRangeMemory,
> TypeStatic)
> Error    1094 -                     Missing ResourceSource string
> (required) ^
>=20
> dsdt.20050507.dsl  1049:                     , AddressRangeMemory,
> TypeStatic)
> Error    1094 -                     Missing ResourceSource string
> (required) ^
>=20
> dsdt.20050507.dsl  1056:                     , AddressRangeMemory,
> TypeStatic)
> Error    1094 -                     Missing ResourceSource string
> (required) ^
>=20
> dsdt.20050507.dsl  1063:                     , AddressRangeMemory,
> TypeStatic)
> Error    1094 -                     Missing ResourceSource string
> (required) ^
>=20
> dsdt.20050507.dsl  1070:                     , AddressRangeMemory,
> TypeStatic)
> Error    1094 -                     Missing ResourceSource string
> (required) ^
>=20
> dsdt.20050507.dsl  1077:                     , AddressRangeMemory,
> TypeStatic)
> Error    1094 -                     Missing ResourceSource string
> (required) ^
>=20
> dsdt.20050507.dsl  1084:                     , AddressRangeMemory,
> TypeStatic)
> Error    1094 -                     Missing ResourceSource string
> (required) ^
>=20
> dsdt.20050507.dsl  1091:                     , AddressRangeMemory,
> TypeStatic)
> Error    1094 -                     Missing ResourceSource string
> (required) ^
>=20
> dsdt.20050507.dsl  1098:                     , AddressRangeMemory,
> TypeStatic)
> Error    1094 -                     Missing ResourceSource string
> (required) ^
>=20
> ASL Input:  dsdt.20050507.dsl - 6945 lines, 244248 bytes, 3203 keywords
> Compilation complete. 18 Errors, 0 Warnings, 0 Remarks, 1121 Optimizati=
ons
>=20
> ---------------->8----------------
> I get the same behaviour with the DSDT for an Acer Aspire 1694  WLMi
>=20
> Does the version 20050513 of iasl produce cleaner  ASM than 20050309?
>=20
> Best regards,
> Didier
>=20
>=20
This problem has been discussed some days ago on this list
(Subject - Re: [ACPI] question of appropriateness):

I forward the suggestions from Bruno Ducrot:

_________________________________________________________________________
> But I'm wondering what iasl are you using?  It seems totally broken
> to me.

Actually I am wrong here.  Later iasl (20050513) is now more
restrictive.  When the ResourceSourceIndex exist, then ResourceSource
must exist.

2 solutions if you want to compile:
1- patch iasl in order to restore old behaviour (but this is out of
spec somehow)
or
2- eliminate all the ResourceSourceIndex when there is no ResourceSource.

For point 2, here is an incremental patch to your asl:


--- dsdt.dsl	2005/05/30 17:20:33	1.1
+++ dsdt.dsl	2005/05/30 18:21:40
@@ -740,188 +742,188 @@
                     0x0000, // Address Range Minimum
                     0x00FF, // Address Range Maximum
                     0x0000, // Address Translation Offset
-                    0x0100, 0x00,,)
+                    0x0100, ,,)
...
...
...
_________________________________________________________________________=
__

As you have so many error hits, maybe you should get a bit older iasl com=
piler.

If this is a common problem on many machines maybe the compiler should be=
 a bit less restricted
at this point?

    Thomas


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
