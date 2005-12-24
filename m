From: "Jaco Kroon" <jkroon-P18QfuJFXGPYkQIYctQFYw@public.gmane.org>
Subject: Add Toshiba Satellite P10-792 to Doc*/power/video.txt
Date: Sat, 24 Dec 2005 10:08:46 +0200
Message-ID: <20051224080203.3FFF587146@belrog.fns.co.za>
Reply-To: jaco-P18QfuJFXGPYkQIYctQFYw@public.gmane.org
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This patch adds the Toshiba Satellite P10-792 to the list of systems where video can be made to work during suspend-to-ram.

Signed-of-by: Jaco Kroon <jaco-P18QfuJFXGPYkQIYctQFYw@public.gmane.org>

--- linux/Documentation/power/video.txt.orig	2005-12-24 09:57:04.000000000 +0200
+++ linux/Documentation/power/video.txt	2005-12-24 09:57:15.000000000 +0200
@@ -134,6 +134,7 @@
 Toshiba Satellite 4080XCDT      s3_mode (3)
 Toshiba Satellite 4090XCDT      ??? (*)
 Toshiba Satellite P10-554       s3_bios,s3_mode (4)(****)
+Toshiba Satellite P10-792       s3_bios,s3_mode (4)(****)
 Toshiba M30                     (2) xor X with nvidia driver using internal AGP
 Uniwill 244IIO			??? (*)
 


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
