From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: question of appropriateness
Date: Mon, 30 May 2005 20:38:58 +0200
Message-ID: <20050530183858.GK32472@poupinou.org>
References: <1117244104.21648.1.camel@localhost.localdomain> <20050528101450.GA19354@fingerbrecher> <1117397912.24721.5.camel@localhost.localdomain> <20050530130147.GH32472@poupinou.org> <1117471738.398.18.camel@localhost.localdomain> <20050530172536.GI32472@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050530172536.GI32472-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: James Sparenberg <james-q+VOwRQyn90NJZHkBl2fuw@public.gmane.org>
Cc: ACPI <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, May 30, 2005 at 07:25:36PM +0200, Bruno Ducrot wrote:
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
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x000A0000, // Address Range Minimum
                     0x000BFFFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00020000, 0x00,,
+                    0x00020000, ,,
                     , AddressRangeMemory, TypeStatic)
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x000C0000, // Address Range Minimum
                     0x000C1FFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00002000, 0x00,,
+                    0x00002000, ,,
                     , AddressRangeMemory, TypeStatic)
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x000C2000, // Address Range Minimum
                     0x000C3FFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00002000, 0x00,,
+                    0x00002000, ,,
                     , AddressRangeMemory, TypeStatic)
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x000C4000, // Address Range Minimum
                     0x000C5FFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00002000, 0x00,,
+                    0x00002000, ,,
                     , AddressRangeMemory, TypeStatic)
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x000C6000, // Address Range Minimum
                     0x000C7FFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00002000, 0x00,,
+                    0x00002000, ,,
                     , AddressRangeMemory, TypeStatic)
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x000C8000, // Address Range Minimum
                     0x000C9FFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00002000, 0x00,,
+                    0x00002000, ,,
                     , AddressRangeMemory, TypeStatic)
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x000CA000, // Address Range Minimum
                     0x000CBFFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00002000, 0x00,,
+                    0x00002000, ,,
                     , AddressRangeMemory, TypeStatic)
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x000CC000, // Address Range Minimum
                     0x000CDFFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00002000, 0x00,,
+                    0x00002000, ,,
                     , AddressRangeMemory, TypeStatic)
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x000CE000, // Address Range Minimum
                     0x000CFFFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00002000, 0x00,,
+                    0x00002000, ,,
                     , AddressRangeMemory, TypeStatic)
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x000D0000, // Address Range Minimum
                     0x000D1FFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00002000, 0x00,,
+                    0x00002000, ,,
                     , AddressRangeMemory, TypeStatic)
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x000D2000, // Address Range Minimum
                     0x000D3FFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00002000, 0x00,,
+                    0x00002000, ,,
                     , AddressRangeMemory, TypeStatic)
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x000D4000, // Address Range Minimum
                     0x000D5FFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00002000, 0x00,,
+                    0x00002000, ,,
                     , AddressRangeMemory, TypeStatic)
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x000D6000, // Address Range Minimum
                     0x000D7FFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00002000, 0x00,,
+                    0x00002000, ,,
                     , AddressRangeMemory, TypeStatic)
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x000D8000, // Address Range Minimum
                     0x000D9FFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00002000, 0x00,,
+                    0x00002000, ,,
                     , AddressRangeMemory, TypeStatic)
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x000DA000, // Address Range Minimum
                     0x000DBFFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00002000, 0x00,,
+                    0x00002000, ,,
                     , AddressRangeMemory, TypeStatic)
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x000DC000, // Address Range Minimum
                     0x000DDFFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00002000, 0x00,,
+                    0x00002000, ,,
                     , AddressRangeMemory, TypeStatic)
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x000DE000, // Address Range Minimum
                     0x000DFFFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00002000, 0x00,,
+                    0x00002000, ,,
                     , AddressRangeMemory, TypeStatic)
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x000E0000, // Address Range Minimum
                     0x000E1FFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00002000, 0x00,,
+                    0x00002000, ,,
                     , AddressRangeMemory, TypeStatic)
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x000E2000, // Address Range Minimum
                     0x000E3FFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00002000, 0x00,,
+                    0x00002000, ,,
                     , AddressRangeMemory, TypeStatic)
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x000E4000, // Address Range Minimum
                     0x000E5FFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00002000, 0x00,,
+                    0x00002000, ,,
                     , AddressRangeMemory, TypeStatic)
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x000E6000, // Address Range Minimum
                     0x000E7FFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00002000, 0x00,,
+                    0x00002000, ,,
                     , AddressRangeMemory, TypeStatic)
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x000E8000, // Address Range Minimum
                     0x000E9FFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00002000, 0x00,,
+                    0x00002000, ,,
                     , AddressRangeMemory, TypeStatic)
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x000EA000, // Address Range Minimum
                     0x000EBFFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00002000, 0x00,,
+                    0x00002000, ,,
                     , AddressRangeMemory, TypeStatic)
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x000EC000, // Address Range Minimum
                     0x000EDFFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00002000, 0x00,,
+                    0x00002000, ,,
                     , AddressRangeMemory, TypeStatic)
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x000EE000, // Address Range Minimum
                     0x000EFFFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00002000, 0x00,,
+                    0x00002000, ,,
                     , AddressRangeMemory, TypeStatic)
                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                     0x00000000, // Address Space Granularity
                     0x00000000, // Address Range Minimum
                     0xFFFFFFFF, // Address Range Maximum
                     0x00000000, // Address Translation Offset
-                    0x00000000, 0x00,,
+                    0x00000000, ,,
                     , AddressRangeMemory, TypeStatic)
                 IO (Decode16, 0x0CF8, 0x0CF8, 0x01, 0x08)
                 WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
@@ -929,14 +931,14 @@
                     0x0000, // Address Range Minimum
                     0x0CF7, // Address Range Maximum
                     0x0000, // Address Translation Offset
-                    0x0CF8, 0x00,,
+                    0x0CF8, ,,
                     , TypeStatic)
                 WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                     0x0000, // Address Space Granularity
                     0x0D00, // Address Range Minimum
                     0xFFFF, // Address Range Maximum
                     0x0000, // Address Translation Offset
-                    0xF300, 0x00,,
+                    0xF300, ,,
                     , TypeStatic)
             })
             Method (_CRS, 0, Serialized)



BTW, I'm expecting now some strange iasl error output where it worked
before...

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
