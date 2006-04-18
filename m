From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [1/2] ACPI: make _OSI strings static
Date: Tue, 18 Apr 2006 15:29:14 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4200553@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8030 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750778AbWDRW3R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Apr 2006 18:29:17 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>

While I'm certainly all for letting the compiler do such things, if we
are going to do something like this, I would like to convert all similar
instances all at once, not just onesey-twosey -- just to keep everything
consistent.

As far as the "Module Device" string, would this support not be
appropriate for any OS that implements this feature? If so, it should be
an OS-specific header configuration option.

Actually, I find this even more readable:
#define ACPI_NUM_OSI_STRINGS    ACPI_ARRAY_SIZE (acpi_valid_osi_strings)

and leave the existing code as: 
for (i = 0; i < ACPI_NUM_OSI_STRINGS; i++) {

> -----Original Message-----
> From: Bjorn Helgaas [mailto:bjorn.helgaas@hp.com]
> Sent: Tuesday, April 18, 2006 3:18 PM
> To: Moore, Robert
> Cc: Brown, Len; linux-acpi@vger.kernel.org; Andrew Morton
> Subject: Re: [1/2] ACPI: make _OSI strings static
> 
> On Tuesday 18 April 2006 16:02, Moore, Robert wrote:
> > This seems like an incredible long way around just to get rid of one
> > configuration constant. Is it really that much hassle to update
> > NUM_OSI_STRINGS? There is a big comment about this in front of the
osi
> > string declarations.
> 
> No, it's not *that* much hassle.  But what's the point of mentioning
> acpi_gbl_valid_osi_strings[] in three files when it's only used in
> one?  And why define NUM_OSI_STRINGS when you can easily have the
> compiler compute it and remove the possibility for error?
> 
> It might make more sense if you look at the second part of the patch,
> which adds "Module Device" to _OSI.  That's trivial, but without this
> first path, we'd have to do something like:
> 
>     #ifdef CONFIG_ACPI_CONTAINER
>     #define ACPI_NUM_OSI_STRINGS            11
>     #else
>     #define ACPI_NUM_OSI_STRINGS            10
>     #endif
> 
> which is ugly but maybe OK with only one CONFIG option involved.
> But when we add another one or two options, and we want to handle
> all combinations of them being enabled, it would be unmanageable.
> 
> > > -----Original Message-----
> > > From: Bjorn Helgaas [mailto:bjorn.helgaas@hp.com]
> > > Sent: Tuesday, April 18, 2006 2:57 PM
> > > To: Brown, Len
> > > Cc: linux-acpi@vger.kernel.org; Andrew Morton; Moore, Robert
> > > Subject: [1/2] ACPI: make _OSI strings static
> > >
> > > Move acpi_gbl_valid_osi_strings[] from utglobal.c to uteval.c and
> > > make it static.  Then we can remove ACPI_NUM_OSI_STRINGS, which is
> > > a maintenance problem for OSPMs that want to change the features
> > > reported by _OSI.
> > >
> > > This patch is against the Linux-ized ACPI CA, since I don't have
> > > a good way to modify or test the original Intel version.  I hope
> > > it's small enough that you can easily make the corresponding
change
> > > to the Intel version.
> > >
> > > This modification may be used under either the GPL or the
BSD-style
> > > license used for the Intel ACPI CA.
> > >
> > > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > >
> > > Index: work-mm5/drivers/acpi/utilities/uteval.c
> > >
===================================================================
> > > --- work-mm5.orig/drivers/acpi/utilities/uteval.c	2006-04-03
> > > 15:04:31.000000000 -0600
> > > +++ work-mm5/drivers/acpi/utilities/uteval.c	2006-04-18
> > > 15:31:22.000000000 -0600
> > > @@ -48,6 +48,29 @@
> > >  #define _COMPONENT          ACPI_UTILITIES
> > >  ACPI_MODULE_NAME("uteval")
> > >
> > > +#define ACPI_ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> > > +
> > > +/*
> > > + * Strings supported by the _OSI predefined (internal) method.
> > > + */
> > > +static const char *acpi_valid_osi_strings[] = {
> > > +	/* Operating System Vendor Strings */
> > > +
> > > +	"Linux",
> > > +	"Windows 2000",
> > > +	"Windows 2001",
> > > +	"Windows 2001.1",
> > > +	"Windows 2001 SP0",
> > > +	"Windows 2001 SP1",
> > > +	"Windows 2001 SP2",
> > > +	"Windows 2001 SP3",
> > > +	"Windows 2001 SP4",
> > > +
> > > +	/* Feature Group Strings */
> > > +
> > > +	"Extended Address Space Descriptor",
> > > +};
> > > +
> > >  /* Local prototypes */
> > >  static void
> > >  acpi_ut_copy_id_string(char *destination, char *source, acpi_size
> > > max_length);
> > > @@ -93,10 +116,9 @@
> > >
> > >  	/* Compare input string to table of supported strings */
> > >
> > > -	for (i = 0; i < ACPI_NUM_OSI_STRINGS; i++) {
> > > +	for (i = 0; i < ACPI_ARRAY_SIZE(acpi_valid_osi_strings); i++) {
> > >  		if (!ACPI_STRCMP(string_desc->string.pointer,
> > > -				 ACPI_CAST_PTR(char,
> > > -
> > acpi_gbl_valid_osi_strings[i])))
> > > +
> > acpi_valid_osi_strings[i]))
> > >  		{
> > >
> > >  			/* This string is supported */
> > > Index: work-mm5/drivers/acpi/utilities/utglobal.c
> > >
===================================================================
> > > --- work-mm5.orig/drivers/acpi/utilities/utglobal.c
2006-04-18
> > > 12:42:24.000000000 -0600
> > > +++ work-mm5/drivers/acpi/utilities/utglobal.c	2006-04-18
> > > 12:55:24.000000000 -0600
> > > @@ -184,28 +184,6 @@
> > >  	"_S4D"
> > >  };
> > >
> > > -/*
> > > - * Strings supported by the _OSI predefined (internal) method.
> > > - * When adding strings, be sure to update ACPI_NUM_OSI_STRINGS.
> > > - */
> > > -const char *acpi_gbl_valid_osi_strings[ACPI_NUM_OSI_STRINGS] = {
> > > -	/* Operating System Vendor Strings */
> > > -
> > > -	"Linux",
> > > -	"Windows 2000",
> > > -	"Windows 2001",
> > > -	"Windows 2001.1",
> > > -	"Windows 2001 SP0",
> > > -	"Windows 2001 SP1",
> > > -	"Windows 2001 SP2",
> > > -	"Windows 2001 SP3",
> > > -	"Windows 2001 SP4",
> > > -
> > > -	/* Feature Group Strings */
> > > -
> > > -	"Extended Address Space Descriptor"
> > > -};
> > > -
> > >
> > >
> >
/***********************************************************************
> > **
> > > ******
> > >   *
> > >   * Namespace globals
> > > Index: work-mm5/include/acpi/acconfig.h
> > >
===================================================================
> > > --- work-mm5.orig/include/acpi/acconfig.h	2006-04-18
> > 12:42:24.000000000 -
> > > 0600
> > > +++ work-mm5/include/acpi/acconfig.h	2006-04-18
12:42:58.000000000 -
> > > 0600
> > > @@ -187,10 +187,6 @@
> > >
> > >  #define ACPI_SMBUS_BUFFER_SIZE          34
> > >
> > > -/* Number of strings associated with the _OSI reserved method */
> > > -
> > > -#define ACPI_NUM_OSI_STRINGS            10
> > > -
> > >
> > >
> >
/***********************************************************************
> > **
> > > *****
> > >   *
> > >   * ACPI AML Debugger
> > > Index: work-mm5/include/acpi/acglobal.h
> > >
===================================================================
> > > --- work-mm5.orig/include/acpi/acglobal.h	2006-03-23
> > 10:22:17.000000000 -
> > > 0700
> > > +++ work-mm5/include/acpi/acglobal.h	2006-04-18
15:24:33.000000000 -
> > > 0600
> > > @@ -244,7 +244,6 @@
> > >  extern const char *acpi_gbl_highest_dstate_names[4];
> > >  extern const struct acpi_opcode_info
> > > acpi_gbl_aml_op_info[AML_NUM_OPCODES];
> > >  extern const char
> > *acpi_gbl_region_types[ACPI_NUM_PREDEFINED_REGIONS];
> > > -extern const char
*acpi_gbl_valid_osi_strings[ACPI_NUM_OSI_STRINGS];
> > >
> > >
> > >
> >
/***********************************************************************
> > **
> > > ****
> > >   *
> >
