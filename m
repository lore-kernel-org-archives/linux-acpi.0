From: Sanjoy Mahajan <sanjoy-Bhlo64W4KxTQzY9nttDBhA@public.gmane.org>
Subject: S3 wakeup broken by one commit (was Re: bisect gives strange answer)
Date: Fri, 05 Aug 2005 00:30:46 -0400
Message-ID: <E1E0tr4-0000n5-3z@approximate.corpus.cam.ac.uk>
References: <20050804172635.GA14144@kroah.com>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Your message of "Thu, 04 Aug 2005 10:26:35 PDT."
             <20050804172635.GA14144-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Ivan Kokshaysky <ink-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-4ESfhGDvgol+CIkdHa1UOg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

[Ivan: I've been trying to find why S3 wakeup no longer works on my
       TP600X.  It worked reasonably in 2.6.12.3, and broke somewhere
       between 2.6.13-rc1-git7 and 2.6.13-rc2-git1.  I binary searched
       using git bisect to find the commit, and you might have ideas
       about what to do.]

Greg KH wrote:
> By any chance, is this patch
> [3d3c2ae1101c1f2dff7e2f9d514769779dbd2737] causing you problems?

It wasn't that one, so I redid the bisection very carefully, and found
the troublesome patch (I hope): 299de0343c7d18448a69c635378342e9214b14af

See <http://bugzilla.kernel.org/show_bug.cgi?id=4989> for more details.
[Basic story: IBM TP 600X, i386, booting always with acpi_sleep=s3_bios.
With some kernels it won't wake up from S3 sleep, just sits there with
the disk light on but no disk activity.]

The patch is in the kernel (as of -rc5) so if it causes a problem (it
may not be, it may just have exposed another problem, alas), then it may
be worth tracking down.  Otherwise S3 will never get stable.

Any suggestions on patches to test?  (I'll be away for a few days
teaching but will try any experiments when I get back if I cannot get to
them while travelling.)

Here's the log entry:

$ git log 299de0343c7d18448a69c635378342e9214b14af
commit 299de0343c7d18448a69c635378342e9214b14af
Author: Ivan Kokshaysky <ink-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org>
Date:   Wed Jun 15 18:59:27 2005 +0400

    [PATCH] PCI: pci_assign_unassigned_resources() on x86
    
    - Add sanity check for io[port,mem]_resource in setup-bus.c. These
      resources look like "free" as they have no parents, but obviously
      we must not touch them.
    - In i386.c:pci_allocate_bus_resources(), if a bridge resource cannot be
      allocated for some reason, then clear its flags. This prevents any child
      allocations in this range, so the setup-bus code will work with a clean
      resource sub-tree.
    - i386.c:pcibios_enable_resources() doesn't enable bridges, as it checks
      only resources 0-5, which looks like a clear bug to me. I suspect it
      might break hotplug as well in some cases.
    
    From: Ivan Kokshaysky <ink-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org>
    Signed-off-by: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>

...

And the diff itself:

diff --git a/arch/i386/pci/common.c b/arch/i386/pci/common.c
--- a/arch/i386/pci/common.c
+++ b/arch/i386/pci/common.c
@@ -165,6 +165,7 @@ static int __init pcibios_init(void)
 	if ((pci_probe & PCI_BIOS_SORT) && !(pci_probe & PCI_NO_SORT))
 		pcibios_sort();
 #endif
+	pci_assign_unassigned_resources();
 	return 0;
 }
 
diff --git a/arch/i386/pci/i386.c b/arch/i386/pci/i386.c
--- a/arch/i386/pci/i386.c
+++ b/arch/i386/pci/i386.c
@@ -106,11 +106,16 @@ static void __init pcibios_allocate_bus_
 		if ((dev = bus->self)) {
 			for (idx = PCI_BRIDGE_RESOURCES; idx < PCI_NUM_RESOURCES; idx++) {
 				r = &dev->resource[idx];
-				if (!r->start)
+				if (!r->flags)
 					continue;
 				pr = pci_find_parent_resource(dev, r);
-				if (!pr || request_resource(pr, r) < 0)
+				if (!r->start || !pr || request_resource(pr, r) < 0) {
 					printk(KERN_ERR "PCI: Cannot allocate resource region %d of bridge %s\n", idx, pci_name(dev));
+					/* Something is wrong with the region.
+					   Invalidate the resource to prevent child
+					   resource allocations in this range. */
+					r->flags = 0;
+				}
 			}
 		}
 		pcibios_allocate_bus_resources(&bus->children);
@@ -227,7 +232,7 @@ int pcibios_enable_resources(struct pci_
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	old_cmd = cmd;
-	for(idx=0; idx<6; idx++) {
+	for(idx = 0; idx < PCI_NUM_RESOURCES; idx++) {
 		/* Only set up the requested stuff */
 		if (!(mask & (1<<idx)))
 			continue;
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -273,6 +273,8 @@ find_free_bus_resource(struct pci_bus *b
 
 	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
 		r = bus->resource[i];
+		if (r == &ioport_resource || r == &iomem_resource)
+			continue;
 		if (r && (r->flags & type_mask) == type && !r->parent)
 			return r;
 	}



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
