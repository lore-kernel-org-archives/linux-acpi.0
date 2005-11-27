From: Daniel Drake <dsd-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] ACPI scan: Revert acpi_bus_find_driver() return value check
Date: Sun, 27 Nov 2005 13:57:25 +0000
Message-ID: <4389BB45.7050108@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040501000308070609050005"
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
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------040501000308070609050005
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

2.6.13 introduced a change to drivers/acpi/scan.c along the lines of:

          *
          * TBD: Assumes LDM provides driver hot-plug capability.
          */
-       result = acpi_bus_find_driver(device);
+       acpi_bus_find_driver(device);

        end:
         if (!result)

This was inside this commit:
http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=3fb02738b0fd36f47710a2bf207129efd2f5daa2

Since then, various HP/Compaq laptops have not been able to boot, freezing 
after these messages:

PCI: Using ACPI for IRQ routing
PCI: If a device does not work, try "pci=routeirq". If it helps, post a report
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.1

Rajesh Shah (the author of said commit) has since then acked that this small 
change should probably be reverted:
> Looking at this closely now, checking for the result does appear
> to be wrong. Binding a driver for a device should be optional,
> and should not fail adding the device to the acpi list. I suspect
> a previous iteration through this code failed to find a driver
> match, returned failure to the caller and caused bad things to
> happen. So, your patch looks good to me.

The main diagnosis/discussion has been at:
https://bugzilla.novell.com/show_bug.cgi?id=116763

There are also some other reports elsewhere:
http://bugzilla.kernel.org/show_bug.cgi?id=5221
http://bugs.gentoo.org/112601

So far the investigation/fixing has been done by Thomas Renninger and others. 
I'm just hoping to breathe some life into an issue which has been sitting 
around for nearly 3 months.

If acceptable, please apply.

--------------040501000308070609050005
Content-Type: text/x-patch;
 name="acpi-scan.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi-scan.patch"

From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>

This patch reverts the acpi_bus_find_driver() return value check which was
accidentally added in a big commit titled:

	[PATCH] acpi bridge hotadd: Allow ACPI .add and .start operations to be
	done independently

This particular change broke booting of some HP/Compaq laptops unless
acpi=noirq is used.

See http://bugzilla.kernel.org/show_bug.cgi?id=5221

Signed-off-by: Daniel Drake <dsd-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>

--- vanilla-linux-2.6.14-rc3.orig/drivers/acpi/scan.c	2005-10-03 18:21:35.000000000 +0200
+++ vanilla-linux-2.6.14-rc3/drivers/acpi/scan.c	2005-10-03 18:21:58.000000000 +0200
@@ -1111,7 +1111,7 @@
 	 *
 	 * TBD: Assumes LDM provides driver hot-plug capability.
 	 */
-	result = acpi_bus_find_driver(device);
+	acpi_bus_find_driver(device);
 
       end:
 	if (!result)

--------------040501000308070609050005--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
