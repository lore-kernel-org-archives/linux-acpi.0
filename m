From: Andi Drebes <lists-receive@programmierforen.de>
Subject: Re: [KJ] [PATCH] drivers/acpi: sizeof/sizeof array size calculations replaced with ARRAY_SIZE
Date: Sat, 26 May 2007 13:58:24 +0000
Message-ID: <200705261558.24912.lists-receive@programmierforen.de>
References: <200705261239.27485.lists-receive@programmierforen.de> <46581C06.7000005@student.ltu.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from server001.webpack.hosteurope.de ([80.237.130.9]:52191 "EHLO
	server001.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754376AbXEZN6f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 May 2007 09:58:35 -0400
In-Reply-To: <46581C06.7000005@student.ltu.se>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Knutsson <ricknu-0@student.ltu.se>
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
> Any reason to not just replace ACPI_RSD_TABLE_SIZE with ARRAY_SIZE? Got 
> just 21 instances of it in the file (+ the define) and no more in the 
> rest of the tree.
I agree with that. Robert P. J. Day pointed out something similiar. For
a more verbose answer to that see the reply to his message.

> >  /*******************************************************************************
> >   *
> > diff --git a/drivers/acpi/tables/tbfadt.c b/drivers/acpi/tables/tbfadt.c
> > index 1285e91..4d59de2 100644
> > --- a/drivers/acpi/tables/tbfadt.c
> > +++ b/drivers/acpi/tables/tbfadt.c
> > @@ -104,7 +104,7 @@ static struct acpi_fadt_info fadt_info_table[] = {
> >  	 ACPI_FADT_OFFSET(gpe1_block_length), ACPI_FADT_SEPARATE_LENGTH}
> >  };
> >  
> > -#define ACPI_FADT_INFO_ENTRIES        (sizeof (fadt_info_table) / sizeof (struct acpi_fadt_info))
> > +#define ACPI_FADT_INFO_ENTRIES        (ARRAY_SIZE(fadt_info_table))
> >   
> Normally I think this is ok when it is just a "constant", since the name 
> of it may be more descriptive, but it is just used twice and I find 
> (imho) ARRAY_SIZE(fadt_info_table) easier to understand.
I totally agree with that. Here's a new patch that totally removes the ACPI_FADT_INFO_ENTRIES
macro. In contrast to the original patch, this one only affects tbfadt.c (I split this, because
there's another issue about rsdump.c pointed out by Robert P. J. Day. The other
changes will be in a reply to his message)

Tested by compilation.
Signed-off-by: Andi Drebes <lists-receive@programmierforen.de>
--

diff --git a/drivers/acpi/tables/tbfadt.c b/drivers/acpi/tables/tbfadt.c
index 1285e91..ba6d4a1 100644
--- a/drivers/acpi/tables/tbfadt.c
+++ b/drivers/acpi/tables/tbfadt.c
@@ -104,8 +104,6 @@ static struct acpi_fadt_info fadt_info_table[] = {
 	 ACPI_FADT_OFFSET(gpe1_block_length), ACPI_FADT_SEPARATE_LENGTH}
 };
 
-#define ACPI_FADT_INFO_ENTRIES        (sizeof (fadt_info_table) / sizeof (struct acpi_fadt_info))
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_tb_init_generic_address
@@ -295,7 +293,7 @@ static void acpi_tb_convert_fadt(void)
 	 * Expand the 32-bit V1.0 addresses to the 64-bit "X" generic address
 	 * structures as necessary.
 	 */
-	for (i = 0; i < ACPI_FADT_INFO_ENTRIES; i++) {
+	for (i = 0; i < ARRAY_SIZE(fadt_info_table); i++) {
 		target =
 		    ACPI_ADD_PTR(struct acpi_generic_address, &acpi_gbl_FADT,
 				 fadt_info_table[i].target);
@@ -392,7 +390,7 @@ static void acpi_tb_validate_fadt(void)
 
 	/* Examine all of the 64-bit extended address fields (X fields) */
 
-	for (i = 0; i < ACPI_FADT_INFO_ENTRIES; i++) {
+	for (i = 0; i < ARRAY_SIZE(fadt_info_table); i++) {
 
 		/* Generate pointers to the 32-bit and 64-bit addresses and get the length */
 
