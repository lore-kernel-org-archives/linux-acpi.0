From: iain d broadfoot <ibroadfo-jbDEWmSD8rMwZN84zEGlPg@public.gmane.org>
Subject: Re: [PATCH] Re: 20030619 broken, or is it me?
Date: Sun, 22 Jun 2003 16:19:28 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030622151928.GB5346@iain-vaio-fx405>
References: <20030621032659.GA923@iain-vaio-fx405> <3EF3D289.7030400@nc.rr.com> <20030622145014.GA5346@iain-vaio-fx405>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030622145014.GA5346-v7odo3xQhQm0dmPfeJ3kVA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* iain d broadfoot (ibroadfo-jbDEWmSD8rMwZN84zEGlPg@public.gmane.org) wrote:
> yep, patch attached that works for me.

hmm, maybe this time, eh? :D

iain

-- 
wh33, y1p33 3tc.

"If sharing a thing in no way diminishes it, it is not rightly owned if it is
not shared." -St. Augustine

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=hackacpi

--- linux-2.4.21-normal/drivers/acpi/Config.in	2003-06-22 15:36:07.000000000 +0100
+++ linux-2.4.21-hacked/drivers/acpi/Config.in	2003-06-22 15:36:35.000000000 +0100
@@ -8,9 +8,9 @@
   comment 'ACPI Support'
   bool         'ACPI Support' CONFIG_ACPI
   if [ "$CONFIG_ACPI" = "y" ]; then
-    if [ "$CONFIG_X86_LOCAL_APIC" = "y" ]; then
+    #if [ "$CONFIG_X86_LOCAL_APIC" = "y" ]; then
       bool         'CPU Enumeration Only' CONFIG_ACPI_HT_ONLY
-    fi
+    #fi
 
     if [ "$CONFIG_ACPI_HT_ONLY" = "n" ]; then
       define_bool CONFIG_ACPI_BOOT		y

--gKMricLos+KVdGMg--


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
