From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: [PATCH 2/2] acpi4asus update: fix param description
Date: Wed, 6 Apr 2005 01:00:40 +0200
Message-ID: <20050405230040.GF21320@hell.org.pl>
References: <20050405225551.GE21320@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050405225551.GE21320-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
This patch fixes inconsistent parameter descriptions and also deprecates the
parameters themselves (I always wanted to kill this code but it has its
users so it's safer to remove it later).

This is also a 2.6.12 candidate.
Please apply, TIA

Signed-off-by: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>

--- a/drivers/acpi/asus_acpi.c	2005-03-01 22:15:44.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c	2005-04-06 00:36:20.000000000 +0200
@@ -79,9 +79,9 @@ MODULE_LICENSE("GPL");
 static uid_t asus_uid;
 static gid_t asus_gid;
 module_param(asus_uid, uint, 0);
-MODULE_PARM_DESC(uid, "UID for entries in /proc/acpi/asus.\n");
+MODULE_PARM_DESC(asus_uid, "UID for entries in /proc/acpi/asus.\n");
 module_param(asus_gid, uint, 0);
-MODULE_PARM_DESC(gid, "GID for entries in /proc/acpi/asus.\n");
+MODULE_PARM_DESC(asus_gid, "GID for entries in /proc/acpi/asus.\n");
 
 
 /* For each model, all features implemented, 
@@ -862,6 +862,8 @@ static int __init asus_hotk_add_fs(struc
 		mode = S_IFREG | S_IRUGO | S_IWUGO;
 	} else {
 		mode = S_IFREG | S_IRUSR | S_IRGRP | S_IWUSR | S_IWGRP;
+		printk(KERN_WARNING "  asus_uid and asus_gid parameters are "
+		       "deprecated, use chown and chmod instead!\n");
 	}
 
 	acpi_device_dir(device) = asus_proc_dir;


-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
