From: matthieu castet <castet.matthieu-GANU6spQydw@public.gmane.org>
Subject: [PATCH] PNPACPI : don't use device not present
Date: Fri, 04 Feb 2005 18:28:21 +0100
Message-ID: <4203B0B5.4080204@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010306090601000000030008"
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------010306090601000000030008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
this patch avoid the pnpacpi layer reconized not present device.

There is still issue [1] with the ACPI code that need to fix in order 
everything work correctly...

Matthieu CASTET


[1] http://bugzilla.kernel.org/show_bug.cgi?id=3358

--------------010306090601000000030008
Content-Type: text/x-patch;
 name="pnpacpi_spec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnpacpi_spec.patch"

--- linux-2.6.9/drivers/pnp/pnpacpi/core.c	2004-11-22 20:35:58.000000000 +0100
+++ linux-2.6.9/drivers/pnp/pnpacpi/core.c	2004-11-26 14:46:54.000000000 +0100
@@ -124,6 +124,10 @@
 	struct pnp_dev *dev;
 
 	pnp_dbg("ACPI device : hid %s", acpi_device_hid(device));
+
+	if(!device->status.present)
+		return -ENODEV;
+
 	dev =  pnpacpi_kmalloc(sizeof(struct pnp_dev), GFP_KERNEL);
 	if (!dev) {
 		pnp_err("Out of memory");

--------------010306090601000000030008--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
