From: Ernst Herzberg <earny-euM3SP4ZHrg@public.gmane.org>
Subject: Re: Re: ACPI source patches updated (20021101)
Date: Sun, 3 Nov 2002 18:17:06 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200211031817.06644.earny@net4u.de>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A49E@orsmsx119.jf.intel.com> <200211031015.52270.acpi@computerdatasafe.com.au> <200211030809.02748.earny@net4u.de>
Reply-To: earny-euM3SP4ZHrg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200211030809.02748.earny-euM3SP4ZHrg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: John Summerfield <summer-bdq14YP6qtSeVB85EesmETSf8X3wrgjD@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
Cc: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



With this patch the kernel will boot with debug messages enabled.

<Earny>


--- bus.c.orig  2002-11-03 18:10:24.000000000 +0100
+++ bus.c       2002-11-03 17:35:13.000000000 +0100
@@ -2035,7 +2035,7 @@
                ACPI_CA_VERSION);

        /* Initial core debug level excludes drivers, so include them now */
-       acpi_set_debug(ACPI_DEBUG_HIGH);
+       acpi_set_debug(ACPI_DEBUG_LOW);

        if (acpi_disabled) {
                printk(KERN_INFO PREFIX "Disabled via command line (acpi=off)\n");


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
