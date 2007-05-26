From: Andi Drebes <lists-receive@programmierforen.de>
Subject: Re: [KJ] [PATCH] drivers/acpi: sizeof/sizeof array size calculations replaced with ARRAY_SIZE
Date: Sat, 26 May 2007 13:53:05 +0000
Message-ID: <200705261553.06352.lists-receive@programmierforen.de>
References: <200705261239.27485.lists-receive@programmierforen.de> <Pine.LNX.4.64.0705260723190.18950@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from server001.webpack.hosteurope.de ([80.237.130.9]:34742 "EHLO
	server001.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760380AbXEZNxU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 May 2007 09:53:20 -0400
In-Reply-To: <Pine.LNX.4.64.0705260723190.18950@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: kernel-janitors@lists.osdl.org, lenb@kernel.org, linux-acpi@vger.kernel.org

<snip>
> > diff --git a/drivers/acpi/resources/rsdump.c b/drivers/acpi/resources/rsdump.c
> > index 46da116..7b8e12d 100644
> > --- a/drivers/acpi/resources/rsdump.c
> > +++ b/drivers/acpi/resources/rsdump.c
> > @@ -76,7 +76,7 @@ acpi_rs_dump_descriptor(void *resource, struct acpi_rsdump_info *table);
> >
> >  #define ACPI_RSD_OFFSET(f)          (u8) ACPI_OFFSET (union acpi_resource_data,f)
> >  #define ACPI_PRT_OFFSET(f)          (u8) ACPI_OFFSET (struct acpi_pci_routing_table,f)
> > -#define ACPI_RSD_TABLE_SIZE(name)   (sizeof(name) / sizeof (struct acpi_rsdump_info))
> > +#define ACPI_RSD_TABLE_SIZE(name)   (ARRAY_SIZE(name))
> >
> >  /*******************************************************************************
> >   *
> 
>   normally, what i would do in a case like the above is delete the
> macro ACPI_RSD_TABLE_SIZE entirely, and replace all invocations of it
> with a direct invocation of ARRAY_SIZE.  there seems to be little
> value in defining a whole new macro whose only purpose in life is to
> do what an already-existing macro does just as well and with more
> clarity.
OK. I just replaced all invocations of ACPI_RSD_TABLE_SIZE with ARRAY_SIZE
and removed the definition.

>   but there's something else about that file that's just a bit weird.
<snip>
>   what's the point of **hard-coding** the array size as "6", only to
> use a macro in the very next line to calculate that same value?  and
> that's done throughout those array definitions.  why not just leave
> the hard-coded array size out, and let the macro take care of things?
I tried to figure out why the value is hardcoded in the _first entry_. Actually, the acpi_rs_dump_*
array definitions are used in drivers/acpi/resources/rsinfo.c in another array
called acpi_gbl_dump_resource_dispatch (Line 124). They are also defined
as externel variables in include/acpi/acresrc.h. But I think the point of the
definitions in the header file is just to make them accessible fro rsinfo.c
(because the only references in drivers/acpi/ are in drivers/acpi/resources/rsinfo.c
and drivers/acpi/resources/rsdump.c (where they are defined)).
acpi_gbl_dump_resource_dispatch seems o be referenced only once. That is in
drivers/acpi/resources/rsdump.c in the function called acpi_rs_dump_resource_list:

acpi_rs_dump_descriptor(&resource_list->data,
					acpi_gbl_dump_resource_dispatch[type]);

acpi_rs_dump_descriptor is defined in the same file and finally uses the table.
The hardcoded sizes of the arrays are used to walk through the array. There's
also a comment about that:

/* First table entry must contain the table length (# of table entries) */

As acpi_rs_dump_descriptor only gets a pointer to an array like that, it's
impossible for it to determine the size (or am I wrong?). So finally, I think
the hardcoded values are really needed. What I dislike is that an ordinary
acpi_rsdump_info entry in the array is used to store the size. So
acpi_rsdump_info.offset is used in two ways. For the first entry this is the
number of entries in the array. For all the following entries it is a real offset.
Perhaps one should use a struct that contains an array for the following entries
instead of using an array directly (or is this a common practice?).
To get back to robert's comment: I think also that the hardcoded values
*in brackets* should be removed. I couldn't find any code that relies on that.
To determine the size, the first entry is used (see above).

However, there's another thing that confuses me. I tried to figure out how
drivers/acpi/resources/rsdump.c is actually compiled. I inspected the Makefile
which says:

obj-y := rsaddr.o rscreate.o rsinfo.o rsio.o rslist.o rsmisc.o rsxface.o \
	 rscalc.o  rsirq.o  rsmemory.o  rsutils.o

obj-$(ACPI_FUTURE_USAGE) += rsdump.o

I couldn't find ACPI_FUTURE_USAGE in the configuration. I tried to add
the object file diretly to obj-y which causes a lot of errors. I found this post
when I searched the web for more information about the symbol:

http://mail.nl.linux.org/kernelnewbies/2006-07/msg00250.html

The message is pretty old (July 2006), but it endorses my assumption that
this code isn't actually used. This is somewhat weird to me. Why is there
code in the kernel tree that is reserved for future use. And why does it live
there for already a year? I would really like to test my changes (even only by
compilation).

Here's a new patch that totally removes the ACPI_RSD_TABLE_SIZE macro,
aswell as the hardcoded array sizes in brackets at the beginning of a definition.
In contrast to the original patch, this one only affects rsdump.c (I split this, because
there's another issue about tbfadt.c pointed out by Richard Knutsson. The other
changes will be in a reply to his message)

	Cheers,
		Andi

The changes haven't been tested yet (see above)
Signed-off-by: Andi Drebes <lists-receive@programmierforen.de>
--


diff --git a/drivers/acpi/resources/rsdump.c b/drivers/acpi/resources/rsdump.c
index 46da116..67a7511 100644
--- a/drivers/acpi/resources/rsdump.c
+++ b/drivers/acpi/resources/rsdump.c
@@ -76,7 +76,6 @@ acpi_rs_dump_descriptor(void *resource, struct acpi_rsdump_info *table);
 
 #define ACPI_RSD_OFFSET(f)          (u8) ACPI_OFFSET (union acpi_resource_data,f)
 #define ACPI_PRT_OFFSET(f)          (u8) ACPI_OFFSET (struct acpi_pci_routing_table,f)
-#define ACPI_RSD_TABLE_SIZE(name)   (sizeof(name) / sizeof (struct acpi_rsdump_info))
 
 /*******************************************************************************
  *
@@ -87,8 +86,8 @@ acpi_rs_dump_descriptor(void *resource, struct acpi_rsdump_info *table);
  *
  ******************************************************************************/
 
-struct acpi_rsdump_info acpi_rs_dump_irq[6] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_irq), "IRQ", NULL},
+struct acpi_rsdump_info acpi_rs_dump_irq[] = {
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_irq), "IRQ", NULL},
 	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(irq.triggering), "Triggering",
 	 acpi_gbl_he_decode},
 	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(irq.polarity), "Polarity",
@@ -101,8 +100,8 @@ struct acpi_rsdump_info acpi_rs_dump_irq[6] = {
 	 "Interrupt List", NULL}
 };
 
-struct acpi_rsdump_info acpi_rs_dump_dma[6] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_dma), "DMA", NULL},
+struct acpi_rsdump_info acpi_rs_dump_dma[] = {
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_dma), "DMA", NULL},
 	{ACPI_RSD_2BITFLAG, ACPI_RSD_OFFSET(dma.type), "Speed",
 	 acpi_gbl_typ_decode},
 	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(dma.bus_master), "Mastering",
@@ -115,8 +114,8 @@ struct acpi_rsdump_info acpi_rs_dump_dma[6] = {
 	 NULL}
 };
 
-struct acpi_rsdump_info acpi_rs_dump_start_dpf[3] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_start_dpf),
+struct acpi_rsdump_info acpi_rs_dump_start_dpf[] = {
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_start_dpf),
 	 "Start-Dependent-Functions", NULL},
 	{ACPI_RSD_2BITFLAG, ACPI_RSD_OFFSET(start_dpf.compatibility_priority),
 	 "Compatibility Priority", acpi_gbl_config_decode},
@@ -124,13 +123,13 @@ struct acpi_rsdump_info acpi_rs_dump_start_dpf[3] = {
 	 "Performance/Robustness", acpi_gbl_config_decode}
 };
 
-struct acpi_rsdump_info acpi_rs_dump_end_dpf[1] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_end_dpf),
+struct acpi_rsdump_info acpi_rs_dump_end_dpf[] = {
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_end_dpf),
 	 "End-Dependent-Functions", NULL}
 };
 
-struct acpi_rsdump_info acpi_rs_dump_io[6] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_io), "I/O", NULL},
+struct acpi_rsdump_info acpi_rs_dump_io[] = {
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_io), "I/O", NULL},
 	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(io.io_decode), "Address Decoding",
 	 acpi_gbl_io_decode},
 	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(io.minimum), "Address Minimum", NULL},
@@ -140,29 +139,29 @@ struct acpi_rsdump_info acpi_rs_dump_io[6] = {
 	 NULL}
 };
 
-struct acpi_rsdump_info acpi_rs_dump_fixed_io[3] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_fixed_io),
+struct acpi_rsdump_info acpi_rs_dump_fixed_io[] = {
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_fixed_io),
 	 "Fixed I/O", NULL},
 	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(fixed_io.address), "Address", NULL},
 	{ACPI_RSD_UINT8, ACPI_RSD_OFFSET(fixed_io.address_length),
 	 "Address Length", NULL}
 };
 
-struct acpi_rsdump_info acpi_rs_dump_vendor[3] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_vendor),
+struct acpi_rsdump_info acpi_rs_dump_vendor[] = {
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_vendor),
 	 "Vendor Specific", NULL},
 	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(vendor.byte_length), "Length", NULL},
 	{ACPI_RSD_LONGLIST, ACPI_RSD_OFFSET(vendor.byte_data[0]), "Vendor Data",
 	 NULL}
 };
 
-struct acpi_rsdump_info acpi_rs_dump_end_tag[1] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_end_tag), "EndTag",
+struct acpi_rsdump_info acpi_rs_dump_end_tag[] = {
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_end_tag), "EndTag",
 	 NULL}
 };
 
-struct acpi_rsdump_info acpi_rs_dump_memory24[6] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_memory24),
+struct acpi_rsdump_info acpi_rs_dump_memory24[] = {
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_memory24),
 	 "24-Bit Memory Range", NULL},
 	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(memory24.write_protect),
 	 "Write Protect", acpi_gbl_rw_decode},
@@ -176,8 +175,8 @@ struct acpi_rsdump_info acpi_rs_dump_memory24[6] = {
 	 "Address Length", NULL}
 };
 
-struct acpi_rsdump_info acpi_rs_dump_memory32[6] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_memory32),
+struct acpi_rsdump_info acpi_rs_dump_memory32[] = {
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_memory32),
 	 "32-Bit Memory Range", NULL},
 	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(memory32.write_protect),
 	 "Write Protect", acpi_gbl_rw_decode},
@@ -191,8 +190,8 @@ struct acpi_rsdump_info acpi_rs_dump_memory32[6] = {
 	 "Address Length", NULL}
 };
 
-struct acpi_rsdump_info acpi_rs_dump_fixed_memory32[4] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_fixed_memory32),
+struct acpi_rsdump_info acpi_rs_dump_fixed_memory32[] = {
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_fixed_memory32),
 	 "32-Bit Fixed Memory Range", NULL},
 	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(fixed_memory32.write_protect),
 	 "Write Protect", acpi_gbl_rw_decode},
@@ -202,8 +201,8 @@ struct acpi_rsdump_info acpi_rs_dump_fixed_memory32[4] = {
 	 "Address Length", NULL}
 };
 
-struct acpi_rsdump_info acpi_rs_dump_address16[8] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_address16),
+struct acpi_rsdump_info acpi_rs_dump_address16[] = {
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_address16),
 	 "16-Bit WORD Address Space", NULL},
 	{ACPI_RSD_ADDRESS, 0, NULL, NULL},
 	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(address16.granularity), "Granularity",
@@ -219,8 +218,8 @@ struct acpi_rsdump_info acpi_rs_dump_address16[8] = {
 	{ACPI_RSD_SOURCE, ACPI_RSD_OFFSET(address16.resource_source), NULL, NULL}
 };
 
-struct acpi_rsdump_info acpi_rs_dump_address32[8] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_address32),
+struct acpi_rsdump_info acpi_rs_dump_address32[] = {
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_address32),
 	 "32-Bit DWORD Address Space", NULL},
 	{ACPI_RSD_ADDRESS, 0, NULL, NULL},
 	{ACPI_RSD_UINT32, ACPI_RSD_OFFSET(address32.granularity), "Granularity",
@@ -236,8 +235,8 @@ struct acpi_rsdump_info acpi_rs_dump_address32[8] = {
 	{ACPI_RSD_SOURCE, ACPI_RSD_OFFSET(address32.resource_source), NULL, NULL}
 };
 
-struct acpi_rsdump_info acpi_rs_dump_address64[8] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_address64),
+struct acpi_rsdump_info acpi_rs_dump_address64[] = {
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_address64),
 	 "64-Bit QWORD Address Space", NULL},
 	{ACPI_RSD_ADDRESS, 0, NULL, NULL},
 	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(address64.granularity), "Granularity",
@@ -253,8 +252,8 @@ struct acpi_rsdump_info acpi_rs_dump_address64[8] = {
 	{ACPI_RSD_SOURCE, ACPI_RSD_OFFSET(address64.resource_source), NULL, NULL}
 };
 
-struct acpi_rsdump_info acpi_rs_dump_ext_address64[8] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_ext_address64),
+struct acpi_rsdump_info acpi_rs_dump_ext_address64[] = {
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_ext_address64),
 	 "64-Bit Extended Address Space", NULL},
 	{ACPI_RSD_ADDRESS, 0, NULL, NULL},
 	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(ext_address64.granularity),
@@ -271,8 +270,8 @@ struct acpi_rsdump_info acpi_rs_dump_ext_address64[8] = {
 	 "Type-Specific Attribute", NULL}
 };
 
-struct acpi_rsdump_info acpi_rs_dump_ext_irq[8] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_ext_irq),
+struct acpi_rsdump_info acpi_rs_dump_ext_irq[] = {
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_ext_irq),
 	 "Extended IRQ", NULL},
 	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(extended_irq.producer_consumer),
 	 "Type", acpi_gbl_consume_decode},
@@ -290,8 +289,8 @@ struct acpi_rsdump_info acpi_rs_dump_ext_irq[8] = {
 	 "Interrupt List", NULL}
 };
 
-struct acpi_rsdump_info acpi_rs_dump_generic_reg[6] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_generic_reg),
+struct acpi_rsdump_info acpi_rs_dump_generic_reg[] = {
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_generic_reg),
 	 "Generic Register", NULL},
 	{ACPI_RSD_UINT8, ACPI_RSD_OFFSET(generic_reg.space_id), "Space ID",
 	 NULL},
@@ -307,8 +306,8 @@ struct acpi_rsdump_info acpi_rs_dump_generic_reg[6] = {
 /*
  * Tables used for common address descriptor flag fields
  */
-static struct acpi_rsdump_info acpi_rs_dump_general_flags[5] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_general_flags), NULL,
+static struct acpi_rsdump_info acpi_rs_dump_general_flags[] = {
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_general_flags), NULL,
 	 NULL},
 	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(address.producer_consumer),
 	 "Consumer/Producer", acpi_gbl_consume_decode},
@@ -320,8 +319,8 @@ static struct acpi_rsdump_info acpi_rs_dump_general_flags[5] = {
 	 "Max Relocatability", acpi_gbl_max_decode}
 };
 
-static struct acpi_rsdump_info acpi_rs_dump_memory_flags[5] = {
-	{ACPI_RSD_LITERAL, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_memory_flags),
+static struct acpi_rsdump_info acpi_rs_dump_memory_flags[] = {
+	{ACPI_RSD_LITERAL, ARRAY_SIZE(acpi_rs_dump_memory_flags),
 	 "Resource Type", (void *)"Memory Range"},
 	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(address.info.mem.write_protect),
 	 "Write Protect", acpi_gbl_rw_decode},
@@ -333,8 +332,8 @@ static struct acpi_rsdump_info acpi_rs_dump_memory_flags[5] = {
 	 "Translation", acpi_gbl_ttp_decode}
 };
 
-static struct acpi_rsdump_info acpi_rs_dump_io_flags[4] = {
-	{ACPI_RSD_LITERAL, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_io_flags),
+static struct acpi_rsdump_info acpi_rs_dump_io_flags[] = {
+	{ACPI_RSD_LITERAL, ARRAY_SIZE(acpi_rs_dump_io_flags),
 	 "Resource Type", (void *)"I/O Range"},
 	{ACPI_RSD_2BITFLAG, ACPI_RSD_OFFSET(address.info.io.range_type),
 	 "Range Type", acpi_gbl_rng_decode},
@@ -347,8 +346,8 @@ static struct acpi_rsdump_info acpi_rs_dump_io_flags[4] = {
 /*
  * Table used to dump _PRT contents
  */
-static struct acpi_rsdump_info acpi_rs_dump_prt[5] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_prt), NULL, NULL},
+static struct acpi_rsdump_info acpi_rs_dump_prt[] = {
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_prt), NULL, NULL},
 	{ACPI_RSD_UINT64, ACPI_PRT_OFFSET(address), "Address", NULL},
 	{ACPI_RSD_UINT32, ACPI_PRT_OFFSET(pin), "Pin", NULL},
 	{ACPI_RSD_STRING, ACPI_PRT_OFFSET(source[0]), "Source", NULL},
