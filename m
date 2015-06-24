From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH v2 16/28] ACPICA: Namespace: Add support of OSDT table.
Date: Wed, 24 Jun 2015 20:02:12 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D306A15@ORSMSX112.amr.corp.intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com>
 <cover.1435114811.git.lv.zheng@intel.com>
 <ef85374dcb02bbfebc81131d7a83f227b0f21a62.1435114811.git.lv.zheng@intel.com>
 <558B0047.8050102@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58427 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752950AbbFXUCQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Jun 2015 16:02:16 -0400
In-Reply-To: <558B0047.8050102@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <ahs3@redhat.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, "Box, David E" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

It is the current plan to add this to the next revision of the ACPI specification.

In the meantime, the OSDT looks exactly like a DSDT or SSDT (hence the "SDT" suffix), with the only difference being the signature "OSDT":

DefinitionBlock ("osdt.aml", "OSDT", 2, "Intel", "Template", 0x00000001)
{

The current iASL compiler will emit a template for you if you want:

iasl -T OSDT


We are working on the proposal/ECR for the ACPI spec.
Bob


> -----Original Message-----
> From: Al Stone [mailto:ahs3@redhat.com]
> Sent: Wednesday, June 24, 2015 12:09 PM
> To: Zheng, Lv; Wysocki, Rafael J; Brown, Len
> Cc: Lv Zheng; linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org;
> Moore, Robert
> Subject: Re: [PATCH v2 16/28] ACPICA: Namespace: Add support of OSDT
> table.
> 
> On 06/23/2015 09:04 PM, Lv Zheng wrote:
> > From: Bob Moore <robert.moore@intel.com>
> >
> > ACPICA commit 27415c82fcecf467446f66d1007a0691cc5f3709
> >
> > This patch adds OSDT (Override System Definition Table) support.
> > When OSDT is loaded, conflict namespace objects will be overridden by
> > the AML interpreter. Bob Moore, Lv Zheng.
> >
> > Link: https://github.com/acpica/acpica/commit/27415c82
> > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > Signed-off-by: Bob Moore <robert.moore@intel.com>
> > ---
> >  drivers/acpi/acpica/nsparse.c  |    7 +++++++
> >  drivers/acpi/acpica/tbxfload.c |    6 +++++-
> >  drivers/acpi/acpica/utmisc.c   |    3 ++-
> >  include/acpi/actbl.h           |    1 +
> >  4 files changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/acpi/acpica/nsparse.c
> > b/drivers/acpi/acpica/nsparse.c index c95a119..57a4cfe 100644
> > --- a/drivers/acpi/acpica/nsparse.c
> > +++ b/drivers/acpi/acpica/nsparse.c
> > @@ -117,6 +117,13 @@ acpi_ns_one_complete_parse(u32 pass_number,
> >  					       (u8) pass_number);
> >  	}
> >
> > +	/* Found OSDT table, enable the namespace override feature */
> > +
> > +	if (ACPI_COMPARE_NAME(table->signature, ACPI_SIG_OSDT) &&
> > +	    pass_number == ACPI_IMODE_LOAD_PASS1) {
> > +		walk_state->namespace_override = TRUE;
> > +	}
> > +
> >  	if (ACPI_FAILURE(status)) {
> >  		acpi_ds_delete_walk_state(walk_state);
> >  		goto cleanup;
> > diff --git a/drivers/acpi/acpica/tbxfload.c
> > b/drivers/acpi/acpica/tbxfload.c index b63e35d..960bd99 100644
> > --- a/drivers/acpi/acpica/tbxfload.c
> > +++ b/drivers/acpi/acpica/tbxfload.c
> > @@ -173,7 +173,11 @@ static acpi_status acpi_tb_load_namespace(void)
> >  		     &&
> >  		     !ACPI_COMPARE_NAME(&
> >  					(acpi_gbl_root_table_list.tables[i].
> > -					 signature), ACPI_SIG_PSDT))
> > +					 signature), ACPI_SIG_PSDT)
> > +		     &&
> > +		     !ACPI_COMPARE_NAME(&
> > +					(acpi_gbl_root_table_list.tables[i].
> > +					 signature), ACPI_SIG_OSDT))
> >  		    ||
> >  		    ACPI_FAILURE(acpi_tb_validate_table
> >  				 (&acpi_gbl_root_table_list.tables[i]))) { diff --
> git
> > a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c index
> > cbb7034..28099e2 100644
> > --- a/drivers/acpi/acpica/utmisc.c
> > +++ b/drivers/acpi/acpica/utmisc.c
> > @@ -97,7 +97,8 @@ u8 acpi_ut_is_aml_table(struct acpi_table_header
> > *table)
> >
> >  	if (ACPI_COMPARE_NAME(table->signature, ACPI_SIG_DSDT) ||
> >  	    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_PSDT) ||
> > -	    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_SSDT)) {
> > +	    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_SSDT) ||
> > +	    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_OSDT)) {
> >  		return (TRUE);
> >  	}
> >
> > diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h index
> > cb8a6b9..2d5faf5 100644
> > --- a/include/acpi/actbl.h
> > +++ b/include/acpi/actbl.h
> > @@ -65,6 +65,7 @@
> >  #define ACPI_SIG_DSDT           "DSDT"	/* Differentiated System
> Description Table */
> >  #define ACPI_SIG_FADT           "FACP"	/* Fixed ACPI Description Table
> */
> >  #define ACPI_SIG_FACS           "FACS"	/* Firmware ACPI Control
> Structure */
> > +#define ACPI_SIG_OSDT           "OSDT"	/* Override System Description
> Table */
> >  #define ACPI_SIG_PSDT           "PSDT"	/* Persistent System Description
> Table */
> >  #define ACPI_SIG_RSDP           "RSD PTR "	/* Root System Description
> Pointer */
> >  #define ACPI_SIG_RSDT           "RSDT"	/* Root System Description Table
> */
> >
> 
> I'm a little puzzled by this patch and the previous one (15-16/28).  I see
> no definition for OSDT in the ACPI spec nor at http://uefi.org/acpi.
> Personally, I like the feature, but I really don't like the idea that I'm
> now going to have to go dig around to figure out what this table looks
> like and what its semantics are supposed to be.  Without doing that,
> though, it is impossible for me to tell if these patches are doing the
> right thing.
> 
> So, can I get a URL to the OSDT definition?  And if this is going to be
> part of ACPI, please submit it as a change request to the spec; I sit on
> the committee but this table hasn't come up at all to date (I just
> searched the issue data base a few minutes ago to make sure I hadn't
> missed it somewhere).  If OSDT is not going to be part of standard ACPI,
> why the divergence from the spec?
> 
> --
> ciao,
> al
> -----------------------------------
> Al Stone
> Software Engineer
> Red Hat, Inc.
> ahs3@redhat.com
> -----------------------------------
