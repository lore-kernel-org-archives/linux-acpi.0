From: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Subject: Re: Re: [PATCH] Teach OSL to handle multiple interrupts [1/2]
Date: Tue, 16 Nov 2004 18:46:51 +0000
Message-ID: <20041116184651.GH1108@parcelfarce.linux.theplanet.co.uk>
References: <3ACA40606221794F80A5670F0AF15F84041AC065@pdsmsx403> <20041116032218.GF1108@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041116032218.GF1108-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Fu, Michael" <michael.fu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 16, 2004 at 03:22:18AM +0000, Matthew Wilcox wrote:
> > 1.1  Shouldn't it return AE_ERROR.
> 
> I don't think it really matters.  The driver will attach to these devices,
> but that doesn't do any harm.
> 
> > 2.1 fadt seems always to be 0, So why you need it?
> 
> fadt is only set to 0 when _CRS resources exist.  ie for GPE blocks that
> aren't described in the FADT.  We shouldn't unregister GPE blocks that're
> described in the FADT because we didn't register them in the first place.
> 
> > 3.2  address.reserved must be 0. (You allocate it at stack)
> 
> Doesn't really matter.  It isn't used.  But I'll fix that.

OK, here's an interdiff from the 0.2 to the 0.3 driver which fixes these
issues:

diff -u linux-2.6/drivers/acpi/gpe-block.c linux-2.6/drivers/acpi/gpe-block.c
--- linux-2.6/drivers/acpi/gpe-block.c  7 Nov 2004 14:34:33 -0000
+++ linux-2.6/drivers/acpi/gpe-block.c  16 Nov 2004 18:12:52 -0000
@@ -18,7 +18,7 @@
 
 MODULE_AUTHOR("Matthew Wilcox <willy-VXdhtT5mjnY@public.gmane.org>");
 MODULE_LICENSE("GPL");
-MODULE_VERSION("0.2");
+MODULE_VERSION("0.3");
 
 #define NAME "gpe-block"
 
@@ -83,9 +83,6 @@
 {
        struct acpi_resource_address64 addr;
        int size;
-       int *fadt = context;
-
-       *fadt = 0;
 
        if (res->id != ACPI_RSTYPE_ADDRESS16 &&
            res->id != ACPI_RSTYPE_ADDRESS32 &&
@@ -107,26 +104,24 @@
 {
        struct gpe_block block;
 
-       block.register_count = 0;
+       memset(&block, 0, sizeof(block));
        acpi_walk_resources(device->handle, METHOD_NAME__CRS,
                        acpi_gpe_block_crs_add, &block);
+
+       /* Decline to handle GPE blocks with no _CRS. */
        if (block.register_count == 0)
-               return 0;
+               return -ENODEV;
 
        acpi_install_gpe_block(device->handle, &block.address,
                        block.register_count, block.interrupt_level);
 
-       return AE_OK;
+       return 0;
 }
 
 static int acpi_gpe_block_remove(struct acpi_device *device, int type)
 {
-       int fadt = 1;
-
        acpi_walk_resources(device->handle, METHOD_NAME__CRS,
-                       acpi_gpe_block_crs_remove, &fadt);
-       if (fadt)
-               return AE_OK;
+                       acpi_gpe_block_crs_remove, NULL);
 
        return acpi_remove_gpe_block(device->handle);
 }

This driver still works, so if I don't get any more comments, I'll submit
the 0.3 driver for inclusion ...

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
