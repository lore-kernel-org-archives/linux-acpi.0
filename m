From: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Subject: Why can't _CRS be found in ->remove?
Date: Sun, 7 Nov 2004 02:47:30 +0000
Message-ID: <20041107024730.GA23303@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


In the driver's ->add method, I can walk _CRS just fine:

acpi_gpe_block_add; handle = e0000763fdf8bd80
acpi_gpe_block_add; handle = e0000763fdf8bc40
acpi_gpe_block_add; handle = e0000763fefc03c0
acpi_gpe_block_add; handle = e0000763fefc0240

But in the ->remove method, it fails:

acpi_gpe_block_remove: handle = e0000763fdf8bd80
report_method_error: Could not get node _CRS
acpi_gpe_block_remove: handle = e0000763fdf8bc40
report_method_error: Could not get node _CRS
acpi_gpe_block_remove: handle = e0000763fefc03c0
report_method_error: Could not get node _CRS
acpi_gpe_block_remove: handle = e0000763fefc0240
report_method_error: Could not get node _CRS

Here's the relevant code snippets:

static int acpi_gpe_block_add(struct acpi_device *device)
{
        struct gpe_block block;

        printk("acpi_gpe_block_add; handle = %p\n", device->handle);

        block.register_count = 0;
        acpi_walk_resources(device->handle, METHOD_NAME__CRS,
                        acpi_gpe_block_crs_add, &block);
        if (block.register_count == 0)
                return 0;

        printk("calling acpi_install_gpe_block\n");
        return acpi_install_gpe_block(device->handle, &block.address,
                        block.register_count, block.interrupt_level);
}

static int acpi_gpe_block_remove(struct acpi_device *device, int type)
{
        int status = acpi_remove_gpe_block(device->handle);
        printk("acpi_gpe_block_remove: handle = %p\n", device->handle);
        acpi_walk_resources(device->handle, METHOD_NAME__CRS,
                        acpi_gpe_block_crs_remove, NULL);
        return status;
}

static struct acpi_driver acpi_gpe_block_driver = {
        .name =         NAME,
        .ids =          "ACPI0006",
        .ops =  {
                .add =          acpi_gpe_block_add,
                .remove =       acpi_gpe_block_remove,
        },
};

BTW, I made a small change to get a better error message.  I'd appreciate
something like this being in future ACPICA releases:

Index: drivers/acpi/namespace/nsutils.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/acpi/namespace/nsutils.c,v
retrieving revision 1.5
diff -u -p -r1.5 nsutils.c
--- drivers/acpi/namespace/nsutils.c    30 Mar 2004 12:42:26 -0000      1.5
+++ drivers/acpi/namespace/nsutils.c    7 Nov 2004 02:37:21 -0000
@@ -143,7 +143,8 @@ acpi_ns_report_method_error (
        if (path) {
                status = acpi_ns_get_node_by_path (path, prefix_node, ACPI_NS_NO
_UPSEARCH, &node);
                if (ACPI_FAILURE (status)) {
-                       acpi_os_printf ("report_method_error: Could not get node
\n");
+                       acpi_os_printf ("report_method_error: Could not get "
+                                       "node %s\n", path);
                        return;
                }
        }


-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
