From: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>
Subject: [PATCH] (trivial) correct ACPI URL
Date: Mon, 22 Dec 2003 10:24:53 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031222102453.43360853.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Please apply to 2.6.0 updates.


description:	correct URL for ACPI spec.
product_versions: Linux 2.6.0
maintainer:	len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org

diffstat:=
 arch/i386/boot/setup.S |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./arch/i386/boot/setup.S~acpi-url ./arch/i386/boot/setup.S
--- ./arch/i386/boot/setup.S~acpi-url	2003-12-17 18:58:57.000000000 -0800
+++ ./arch/i386/boot/setup.S	2003-12-22 10:18:00.000000000 -0800
@@ -307,7 +307,7 @@ loader_ok:
 # a whole bunch of different types, and allows memory holes and
 # everything.  We scan through this memory map and build a list
 # of the first 32 memory areas, which we return at [E820MAP].
-# This is documented at http://www.teleport.com/~acpi/acpihtml/topic245.htm
+# This is documented at http://www.acpi.info/ , in the ACPI 2.0 spec file.
 
 #define SMAP  0x534d4150
 


--
~Randy


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
