From: "Therien, Guy" <guy.therien@intel.com>
Subject: RE: [1/2] ACPI: make _OSI strings static
Date: Wed, 19 Apr 2006 10:48:34 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392D58E020@orsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39603 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751022AbWDSRs5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2006 13:48:57 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>

My view has always been that _OSI strings  should be run time loadable.
However, it is clear that drivers that may load the strings may not
always be loaded before their positive evaluation is required. I had
suggested a registration interface that means that the support exists on
the system  i.e. it will be available later but certainly that has some
caveats also.
Guy

-----Original Message-----
From: Moore, Robert 
Sent: Wednesday, April 19, 2006 8:37 AM
To: Bjorn Helgaas
Cc: Brown, Len; linux-acpi@vger.kernel.org; Andrew Morton; Therien, Guy
Subject: RE: [1/2] ACPI: make _OSI strings static

I'm thinking about defining a new OSL interface to let the host match
the optional _OSI strings like "Module Device", "Processor Device", "3.0
Thermal Model", etc.

This seems to me to be the easiest way to configure these strings
(rather than a bunch of #ifdefs), and is also much easier to expand as
the host implements new features and new strings are added in future
ACPI specifications.

Bob


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi- 
> owner@vger.kernel.org] On Behalf Of Bjorn Helgaas
> Sent: Tuesday, April 18, 2006 3:38 PM
> To: Moore, Robert
> Cc: Brown, Len; linux-acpi@vger.kernel.org; Andrew Morton
> Subject: Re: [1/2] ACPI: make _OSI strings static
> 
> On Tuesday 18 April 2006 16:29, Moore, Robert wrote:
> > While I'm certainly all for letting the compiler do such things, if 
> > we are going to do something like this, I would like to convert all 
> > similar instances all at once, not just onesey-twosey -- just to 
> > keep everything consistent.
> 
> Sure, that sounds fine.  I don't want to get involved in that effort 
> though, because any patches I would come up with would be against the 
> Linux-ized source and hence less useful to you.
> 
> > As far as the "Module Device" string, would this support not be 
> > appropriate for any OS that implements this feature? If so, it 
> > should be an OS-specific header configuration option.
> 
> Yup, that sounds reasonable.  I confess I don't really know where 
> options like that live.  include/acpi/platform/aclinux.h?  I can dream

> up a patch for that if you want, but it would probably depend on 
> something like my first patch and it'd probably be more work for you 
> to integrate than for you to just do it yourself.
> 
> > Actually, I find this even more readable:
> > #define ACPI_NUM_OSI_STRINGS    ACPI_ARRAY_SIZE
(acpi_valid_osi_strings)
> >
> > and leave the existing code as:
> > for (i = 0; i < ACPI_NUM_OSI_STRINGS; i++) {
> 
> OK.
> 
> > > -----Original Message-----
> > > From: Bjorn Helgaas [mailto:bjorn.helgaas@hp.com]
> > > Sent: Tuesday, April 18, 2006 3:18 PM
> > > To: Moore, Robert
> > > Cc: Brown, Len; linux-acpi@vger.kernel.org; Andrew Morton
> > > Subject: Re: [1/2] ACPI: make _OSI strings static
> > >
> > > On Tuesday 18 April 2006 16:02, Moore, Robert wrote:
> > > > This seems like an incredible long way around just to get rid of

> > > > one configuration constant. Is it really that much hassle to 
> > > > update NUM_OSI_STRINGS? There is a big comment about this in 
> > > > front of the
> > osi
> > > > string declarations.
> > >
> > > No, it's not *that* much hassle.  But what's the point of 
> > > mentioning acpi_gbl_valid_osi_strings[] in three files when it's 
> > > only used in one?  And why define NUM_OSI_STRINGS when you can 
> > > easily have the compiler compute it and remove the possibility for
error?
> > >
> > > It might make more sense if you look at the second part of the 
> > > patch, which adds "Module Device" to _OSI.  That's trivial, but 
> > > without this first path, we'd have to do something like:
> > >
> > >     #ifdef CONFIG_ACPI_CONTAINER
> > >     #define ACPI_NUM_OSI_STRINGS            11
> > >     #else
> > >     #define ACPI_NUM_OSI_STRINGS            10
> > >     #endif
> > >
> > > which is ugly but maybe OK with only one CONFIG option involved.
> > > But when we add another one or two options, and we want to handle 
> > > all combinations of them being enabled, it would be unmanageable.
> > >
> > > > > -----Original Message-----
> > > > > From: Bjorn Helgaas [mailto:bjorn.helgaas@hp.com]
> > > > > Sent: Tuesday, April 18, 2006 2:57 PM
> > > > > To: Brown, Len
> > > > > Cc: linux-acpi@vger.kernel.org; Andrew Morton; Moore, Robert
> > > > > Subject: [1/2] ACPI: make _OSI strings static
> > > > >
> > > > > Move acpi_gbl_valid_osi_strings[] from utglobal.c to uteval.c 
> > > > > and make it static.  Then we can remove ACPI_NUM_OSI_STRINGS, 
> > > > > which is a maintenance problem for OSPMs that want to change 
> > > > > the features reported by _OSI.
> > > > >
> > > > > This patch is against the Linux-ized ACPI CA, since I don't 
> > > > > have a good way to modify or test the original Intel version.

> > > > > I hope it's small enough that you can easily make the 
> > > > > corresponding
> > change
> > > > > to the Intel version.
> > > > >
> > > > > This modification may be used under either the GPL or the
> > BSD-style
> > > > > license used for the Intel ACPI CA.
> > > > >
> > > > > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > > > >
> > > > > Index: work-mm5/drivers/acpi/utilities/uteval.c
> > > > >
> > ===================================================================
> > > > > --- work-mm5.orig/drivers/acpi/utilities/uteval.c
2006-04-03
> > > > > 15:04:31.000000000 -0600
> > > > > +++ work-mm5/drivers/acpi/utilities/uteval.c	2006-04-18
> > > > > 15:31:22.000000000 -0600
> > > > > @@ -48,6 +48,29 @@
> > > > >  #define _COMPONENT          ACPI_UTILITIES
> > > > >  ACPI_MODULE_NAME("uteval")
> > > > >
> > > > > +#define ACPI_ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> > > > > +
> > > > > +/*
> > > > > + * Strings supported by the _OSI predefined (internal)
method.
> > > > > + */
> > > > > +static const char *acpi_valid_osi_strings[] = {
> > > > > +	/* Operating System Vendor Strings */
> > > > > +
> > > > > +	"Linux",
> > > > > +	"Windows 2000",
> > > > > +	"Windows 2001",
> > > > > +	"Windows 2001.1",
> > > > > +	"Windows 2001 SP0",
> > > > > +	"Windows 2001 SP1",
> > > > > +	"Windows 2001 SP2",
> > > > > +	"Windows 2001 SP3",
> > > > > +	"Windows 2001 SP4",
> > > > > +
> > > > > +	/* Feature Group Strings */
> > > > > +
> > > > > +	"Extended Address Space Descriptor", };
> > > > > +
> > > > >  /* Local prototypes */
> > > > >  static void
> > > > >  acpi_ut_copy_id_string(char *destination, char *source, 
> > > > > acpi_size max_length); @@ -93,10 +116,9 @@
> > > > >
> > > > >  	/* Compare input string to table of supported strings */
> > > > >
> > > > > -	for (i = 0; i < ACPI_NUM_OSI_STRINGS; i++) {
> > > > > +	for (i = 0; i < ACPI_ARRAY_SIZE(acpi_valid_osi_strings);

> > > > > +i++)
> {
> > > > >  		if (!ACPI_STRCMP(string_desc->string.pointer,
> > > > > -				 ACPI_CAST_PTR(char,
> > > > > -
> > > > acpi_gbl_valid_osi_strings[i])))
> > > > > +
> > > > acpi_valid_osi_strings[i]))
> > > > >  		{
> > > > >
> > > > >  			/* This string is supported */
> > > > > Index: work-mm5/drivers/acpi/utilities/utglobal.c
> > > > >
> > ===================================================================
> > > > > --- work-mm5.orig/drivers/acpi/utilities/utglobal.c
> > 2006-04-18
> > > > > 12:42:24.000000000 -0600
> > > > > +++ work-mm5/drivers/acpi/utilities/utglobal.c
2006-04-18
> > > > > 12:55:24.000000000 -0600
> > > > > @@ -184,28 +184,6 @@
> > > > >  	"_S4D"
> > > > >  };
> > > > >
> > > > > -/*
> > > > > - * Strings supported by the _OSI predefined (internal)
method.
> > > > > - * When adding strings, be sure to update
ACPI_NUM_OSI_STRINGS.
> > > > > - */
> > > > > -const char *acpi_gbl_valid_osi_strings[ACPI_NUM_OSI_STRINGS]
= {
> > > > > -	/* Operating System Vendor Strings */
> > > > > -
> > > > > -	"Linux",
> > > > > -	"Windows 2000",
> > > > > -	"Windows 2001",
> > > > > -	"Windows 2001.1",
> > > > > -	"Windows 2001 SP0",
> > > > > -	"Windows 2001 SP1",
> > > > > -	"Windows 2001 SP2",
> > > > > -	"Windows 2001 SP3",
> > > > > -	"Windows 2001 SP4",
> > > > > -
> > > > > -	/* Feature Group Strings */
> > > > > -
> > > > > -	"Extended Address Space Descriptor"
> > > > > -};
> > > > > -
> > > > >
> > > > >
> > > >
> > /*******************************************************************
> > ****
> > > > **
> > > > > ******
> > > > >   *
> > > > >   * Namespace globals
> > > > > Index: work-mm5/include/acpi/acconfig.h
> > > > >
> > ===================================================================
> > > > > --- work-mm5.orig/include/acpi/acconfig.h	2006-04-18
> > > > 12:42:24.000000000 -
> > > > > 0600
> > > > > +++ work-mm5/include/acpi/acconfig.h	2006-04-18
> > 12:42:58.000000000 -
> > > > > 0600
> > > > > @@ -187,10 +187,6 @@
> > > > >
> > > > >  #define ACPI_SMBUS_BUFFER_SIZE          34
> > > > >
> > > > > -/* Number of strings associated with the _OSI reserved method

> > > > > */
> > > > > -
> > > > > -#define ACPI_NUM_OSI_STRINGS            10
> > > > > -
> > > > >
> > > > >
> > > >
> > /*******************************************************************
> > ****
> > > > **
> > > > > *****
> > > > >   *
> > > > >   * ACPI AML Debugger
> > > > > Index: work-mm5/include/acpi/acglobal.h
> > > > >
> > ===================================================================
> > > > > --- work-mm5.orig/include/acpi/acglobal.h	2006-03-23
> > > > 10:22:17.000000000 -
> > > > > 0700
> > > > > +++ work-mm5/include/acpi/acglobal.h	2006-04-18
> > 15:24:33.000000000 -
> > > > > 0600
> > > > > @@ -244,7 +244,6 @@
> > > > >  extern const char *acpi_gbl_highest_dstate_names[4];
> > > > >  extern const struct acpi_opcode_info 
> > > > > acpi_gbl_aml_op_info[AML_NUM_OPCODES];
> > > > >  extern const char
> > > > *acpi_gbl_region_types[ACPI_NUM_PREDEFINED_REGIONS];
> > > > > -extern const char
> > *acpi_gbl_valid_osi_strings[ACPI_NUM_OSI_STRINGS];
> > > > >
> > > > >
> > > > >
> > > >
> > /*******************************************************************
> > ****
> > > > **
> > > > > ****
> > > > >   *
> > > >
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
