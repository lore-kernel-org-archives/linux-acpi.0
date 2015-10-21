From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [Devel] [PATCH] acpi: set return value to const char for some
	functions
Date: Wed, 21 Oct 2015 17:44:54 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D982850@ORSMSX112.amr.corp.intel.com>
References: <1444849635-14456-1-git-send-email-clabbe.montjoie@gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D9803BD@ORSMSX112.amr.corp.intel.com>
 <20151019120255.GA18559@Red>
  <94F2FBAB4432B54E8AACC7DFDE6C92E37D981F39@ORSMSX112.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50614 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752552AbbJURo4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Oct 2015 13:44:56 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37D981F39@ORSMSX112.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, LABBE Corentin <montjoie.mailing@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, LABBE Corentin <clabbe.montjoie@gmail.com>, "devel@acpica.org" <devel@acpica.org>

I think we have everything applied. As I said, we try to be careful about const, but that doesn't mean we are against it.

So, thanks for your help.
Bob


> -----Original Message-----
> From: Devel [mailto:devel-bounces@acpica.org] On Behalf Of Moore, Robert
> Sent: Monday, October 19, 2015 10:16 AM
> To: LABBE Corentin
> Cc: Wysocki, Rafael J; linux-kernel@vger.kernel.org; linux-
> acpi@vger.kernel.org; LABBE Corentin; devel@acpica.org
> Subject: Re: [Devel] [PATCH] acpi: set return value to const char for some
> functions
> 
> You may have missed this, from last week:
> 
> 
> > All that being said, I went ahead and made the actual ACPICA changes
> > corresponding to your patches. There were no pollution issues, and it
> > actually simplified the code by eliminating the need for some uses of
> > ACPI_CAST_PTR.
> >
> > The only issue I found was here, so we won't do this one:
> >
> > const char
> > AcpiUtHexToAsciiChar
> >
> > \acpica\source\include\acutils.h(322) :
> >     warning C4180: qualifier applied to function type has no meaning;
> > ignored
> >
> 
> 
> 
> 
> 
> 
> 
> > -----Original Message-----
> > From: Moore, Robert
> > Sent: Monday, October 19, 2015 10:05 AM
> > To: 'LABBE Corentin'
> > Cc: LABBE Corentin; Zheng, Lv; Wysocki, Rafael J; lenb@kernel.org;
> > linux- acpi@vger.kernel.org; devel@acpica.org;
> > linux-kernel@vger.kernel.org
> > Subject: RE: [PATCH] acpi: set return value to const char for some
> > functions
> >
> > Actually, I thought I got most of the changes.
> >
> > Again, ACPICA code is in a different format than the Linux version of
> > the code, so your patch cannot be directly applied.
> >
> > Bob
> >
> >
> > > -----Original Message-----
> > > From: LABBE Corentin [mailto:montjoie.mailing@gmail.com]
> > > Sent: Monday, October 19, 2015 5:03 AM
> > > To: Moore, Robert
> > > Cc: LABBE Corentin; Zheng, Lv; Wysocki, Rafael J; lenb@kernel.org;
> > > linux- acpi@vger.kernel.org; devel@acpica.org;
> > > linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH] acpi: set return value to const char for some
> > > functions
> > >
> > > On Wed, Oct 14, 2015 at 08:53:19PM +0000, Moore, Robert wrote:
> > > > In ACPICA, we tend to be very careful concerning the "const"
> > > > keyword in
> > > order to avoid a phenomenon known as "const pollution".
> > > >
> > > > That is not to say that we won't use const in some limited cases.
> > > >
> > > > Bob
> > > >
> > >
> > > Hello
> > >
> > > The problem is that all function in this patch return a pointer to
> > > string literal without giving that information.
> > > I am sad to see that you seems to agree with that but, for resuming
> > > your conversation with Joe Perches, you reject this patch just
> > > because you worry that perhaps in the future it will make you more
> > > works do deal with it.
> > >
> > > Does you will accept the subset of this patch for adding const to
> > > "static char xxx[] = {}" ?
> > >
> > > Regards
> > >
> > > >
> > > > > -----Original Message-----
> > > > > From: LABBE Corentin [mailto:clabbe.montjoie@gmail.com]
> > > > > Sent: Wednesday, October 14, 2015 12:07 PM
> > > > > To: Moore, Robert; Zheng, Lv; Wysocki, Rafael J; lenb@kernel.org
> > > > > Cc: linux-acpi@vger.kernel.org; devel@acpica.org; linux-
> > > > > kernel@vger.kernel.org; LABBE Corentin
> > > > > Subject: [PATCH] acpi: set return value to const char for some
> > > > > functions
> > > > >
> > > > > This patch set some array of const char as const.
> > > > > In the same time, some function return pointer to thoses array
> > > > > without properly giving the information that the data is const.
> > > > > This patch set the return type of thoses functions as const char
> > > > > *
> > > > >
> > > > > Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> > > > > ---
> > > > >  drivers/acpi/acpica/acutils.h  | 12 ++++++------
> > > > > drivers/acpi/acpica/utdecode.c | 24 ++++++++++++------------
> > > > >  drivers/acpi/acpica/uthex.c    |  4 ++--
> > > > >  drivers/acpi/tables.c          |  6 ++++--
> > > > >  4 files changed, 24 insertions(+), 22 deletions(-)
> > > > >
> > > > > diff --git a/drivers/acpi/acpica/acutils.h
> > > > > b/drivers/acpi/acpica/acutils.h index fb2aa50..e5d9d4f 100644
> > > > > --- a/drivers/acpi/acpica/acutils.h
> > > > > +++ b/drivers/acpi/acpica/acutils.h
> > > > > @@ -189,21 +189,21 @@ char *acpi_ut_get_mutex_name(u32
> > > > > mutex_id); const char *acpi_ut_get_notify_name(u32 notify_value,
> > > > > acpi_object_type type); #endif
> > > > >
> > > > > -char *acpi_ut_get_type_name(acpi_object_type type);
> > > > > +const char *acpi_ut_get_type_name(acpi_object_type type);
> > > > >
> > > > >  char *acpi_ut_get_node_name(void *object);
> > > > >
> > > > > -char *acpi_ut_get_descriptor_name(void *object);
> > > > > +const char *acpi_ut_get_descriptor_name(void *object);
> > > > >
> > > > >  const char *acpi_ut_get_reference_name(union
> > > > > acpi_operand_object *object);
> > > > >
> > > > > -char *acpi_ut_get_object_type_name(union acpi_operand_object
> > > > > *obj_desc);
> > > > > +const char *acpi_ut_get_object_type_name(union
> > > > > +acpi_operand_object *obj_desc);
> > > > >
> > > > > -char *acpi_ut_get_region_name(u8 space_id);
> > > > > +const char *acpi_ut_get_region_name(u8 space_id);
> > > > >
> > > > > -char *acpi_ut_get_event_name(u32 event_id);
> > > > > +const char *acpi_ut_get_event_name(u32 event_id);
> > > > >
> > > > > -char acpi_ut_hex_to_ascii_char(u64 integer, u32 position);
> > > > > +const char acpi_ut_hex_to_ascii_char(u64 integer, u32
> > > > > +position);
> > > > >
> > > > >  u8 acpi_ut_ascii_char_to_hex(int hex_char);
> > > > >
> > > > > diff --git a/drivers/acpi/acpica/utdecode.c
> > > > > b/drivers/acpi/acpica/utdecode.c index 988e23b..e08cdb1 100644
> > > > > --- a/drivers/acpi/acpica/utdecode.c
> > > > > +++ b/drivers/acpi/acpica/utdecode.c
> > > > > @@ -114,7 +114,7 @@ const char
> > > > > *acpi_gbl_region_types[ACPI_NUM_PREDEFINED_REGIONS] = {
> > > > >  	"PCC"			/* 0x0A */
> > > > >  };
> > > > >
> > > > > -char *acpi_ut_get_region_name(u8 space_id)
> > > > > +const char *acpi_ut_get_region_name(u8 space_id)
> > > > >  {
> > > > >
> > > > >  	if (space_id >= ACPI_USER_REGION_BEGIN) { @@ -127,7 +127,7 @@
> > > > > char
> > > > > *acpi_ut_get_region_name(u8 space_id)
> > > > >  		return ("InvalidSpaceId");
> > > > >  	}
> > > > >
> > > > > -	return (ACPI_CAST_PTR(char, acpi_gbl_region_types[space_id]));
> > > > > +	return (ACPI_CAST_PTR(const char,
> > > > > +acpi_gbl_region_types[space_id]));
> > > > >  }
> > > > >
> > > > >
> > > > > /***************************************************************
> > > > > **
> > > > > **
> > > > > ******
> > > > > ******
> > > > > @@ -152,14 +152,14 @@ static const char
> > > > > *acpi_gbl_event_types[ACPI_NUM_FIXED_EVENTS] = {
> > > > >  	"RealTimeClock",
> > > > >  };
> > > > >
> > > > > -char *acpi_ut_get_event_name(u32 event_id)
> > > > > +const char *acpi_ut_get_event_name(u32 event_id)
> > > > >  {
> > > > >
> > > > >  	if (event_id > ACPI_EVENT_MAX) {
> > > > >  		return ("InvalidEventID");
> > > > >  	}
> > > > >
> > > > > -	return (ACPI_CAST_PTR(char, acpi_gbl_event_types[event_id]));
> > > > > +	return (ACPI_CAST_PTR(const char,
> > > > > +acpi_gbl_event_types[event_id]));
> > > > >  }
> > > > >
> > > > >
> > > > > /***************************************************************
> > > > > **
> > > > > **
> > > > > ******
> > > > > ******
> > > > > @@ -220,17 +220,17 @@ static const char
> > > > > *acpi_gbl_ns_type_names[] =
> > {
> > > > >  	/* 30 */ "Invalid"
> > > > >  };
> > > > >
> > > > > -char *acpi_ut_get_type_name(acpi_object_type type)
> > > > > +const char *acpi_ut_get_type_name(acpi_object_type type)
> > > > >  {
> > > > >
> > > > >  	if (type > ACPI_TYPE_INVALID) {
> > > > > -		return (ACPI_CAST_PTR(char, acpi_gbl_bad_type));
> > > > > +		return (ACPI_CAST_PTR(const char, acpi_gbl_bad_type));
> > > > >  	}
> > > > >
> > > > > -	return (ACPI_CAST_PTR(char, acpi_gbl_ns_type_names[type]));
> > > > > +	return (ACPI_CAST_PTR(const char,
> > > > > +acpi_gbl_ns_type_names[type]));
> > > > >  }
> > > > >
> > > > > -char *acpi_ut_get_object_type_name(union acpi_operand_object
> > > > > *obj_desc)
> > > > > +const char *acpi_ut_get_object_type_name(union
> > > > > +acpi_operand_object
> > > > > +*obj_desc)
> > > > >  {
> > > > >
> > > > >  	if (!obj_desc) {
> > > > > @@ -318,7 +318,7 @@ static const char
> > > > > *acpi_gbl_desc_type_names[] =
> > {
> > > > >  	/* 15 */ "Node"
> > > > >  };
> > > > >
> > > > > -char *acpi_ut_get_descriptor_name(void *object)
> > > > > +const char *acpi_ut_get_descriptor_name(void *object)
> > > > >  {
> > > > >
> > > > >  	if (!object) {
> > > > > @@ -329,7 +329,7 @@ char *acpi_ut_get_descriptor_name(void
> *object)
> > > > >  		return ("Not a Descriptor");
> > > > >  	}
> > > > >
> > > > > -	return (ACPI_CAST_PTR(char,
> > > > > +	return (ACPI_CAST_PTR(const char,
> > > > >
> > acpi_gbl_desc_type_names[ACPI_GET_DESCRIPTOR_TYPE
> > > > >  						       (object)]));
> > > > >
> > > > > @@ -400,7 +400,7 @@ const char *acpi_ut_get_reference_name(union
> > > > > acpi_operand_object *object)
> > > > >
> > > > >  /* Names for internal mutex objects, used for debug output */
> > > > >
> > > > > -static char *acpi_gbl_mutex_names[ACPI_NUM_MUTEX] = {
> > > > > +static const char *acpi_gbl_mutex_names[ACPI_NUM_MUTEX] = {
> > > > >  	"ACPI_MTX_Interpreter",
> > > > >  	"ACPI_MTX_Namespace",
> > > > >  	"ACPI_MTX_Tables",
> > > > > @@ -411,7 +411,7 @@ static char
> > > > > *acpi_gbl_mutex_names[ACPI_NUM_MUTEX]
> > > = {
> > > > >  	"ACPI_MTX_CommandReady"
> > > > >  };
> > > > >
> > > > > -char *acpi_ut_get_mutex_name(u32 mutex_id)
> > > > > +const char *acpi_ut_get_mutex_name(u32 mutex_id)
> > > > >  {
> > > > >
> > > > >  	if (mutex_id > ACPI_MAX_MUTEX) { diff --git
> > > > > a/drivers/acpi/acpica/uthex.c b/drivers/acpi/acpica/uthex.c
> > > > > index
> > > > > fda8b3d..9239711 100644
> > > > > --- a/drivers/acpi/acpica/uthex.c
> > > > > +++ b/drivers/acpi/acpica/uthex.c
> > > > > @@ -48,7 +48,7 @@
> > > > >  ACPI_MODULE_NAME("uthex")
> > > > >
> > > > >  /* Hex to ASCII conversion table */ -static char
> > > > > acpi_gbl_hex_to_ascii[] = {
> > > > > +static const char acpi_gbl_hex_to_ascii[] = {
> > > > >  	'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B',
> > 'C',
> > > > > 'D',
> > > > >  	    'E', 'F'
> > > > >  };
> > > > > @@ -67,7 +67,7 @@ static char acpi_gbl_hex_to_ascii[] = {
> > > > >   *
> > > > >
> > > > > ****************************************************************
> > > > > **
> > > > > **
> > > > > ******
> > > > > ****/
> > > > >
> > > > > -char acpi_ut_hex_to_ascii_char(u64 integer, u32 position)
> > > > > +const char acpi_ut_hex_to_ascii_char(u64 integer, u32 position)
> > > > >  {
> > > > >
> > > > >  	return (acpi_gbl_hex_to_ascii[(integer >> position) & 0xF]);
> > > > > diff
> > > > > -- git a/drivers/acpi/tables.c b/drivers/acpi/tables.c index
> > > > > 17a6fa0..7c8a037
> > > > > 100644
> > > > > --- a/drivers/acpi/tables.c
> > > > > +++ b/drivers/acpi/tables.c
> > > > > @@ -35,8 +35,10 @@
> > > > >
> > > > >  #define ACPI_MAX_TABLES		128
> > > > >
> > > > > -static char *mps_inti_flags_polarity[] = { "dfl", "high",
> > > > > "res", "low" }; -static char *mps_inti_flags_trigger[] = {
> > > > > "dfl", "edge",
> > > "res", "level"
> > > > > };
> > > > > +static const char * const mps_inti_flags_polarity[] = {
> > > > > +	"dfl", "high", "res", "low" }; static const char * const
> > > > > +mps_inti_flags_trigger[] = {
> > > > > +	"dfl", "edge", "res", "level" };
> > > > >
> > > > >  static struct acpi_table_desc initial_tables[ACPI_MAX_TABLES]
> > > > > __initdata;
> > > > >
> > > > > --
> > > > > 2.4.9
> > > >
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe
> > > > linux-kernel" in the body of a message to
> > > > majordomo@vger.kernel.org More majordomo info at
> > > > http://vger.kernel.org/majordomo-info.html
> > > > Please read the FAQ at  http://www.tux.org/lkml/
> _______________________________________________
> Devel mailing list
> Devel@acpica.org
> https://lists.acpica.org/mailman/listinfo/devel
