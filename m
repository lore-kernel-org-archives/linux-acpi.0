From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 12/15] ACPICA: ACPI 6.1: Add full support for this
 version of ACPI spec
Date: Wed, 24 Feb 2016 17:02:09 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E44BC86@ORSMSX110.amr.corp.intel.com>
References: <cover.1455857575.git.lv.zheng@intel.com>
 <deb7863aba0b4ca2b350f206355a06c4701a2b23.1455857585.git.lv.zheng@intel.com>
 <56C8DD6F.5070506@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3690 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756421AbcBXRCo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Feb 2016 12:02:44 -0500
In-Reply-To: <56C8DD6F.5070506@codeaurora.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Abdulhamid, Harb" <harba@codeaurora.org>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Al Stone <ahs3@redhat.com>, "fu.wei@linaro.org" <fu.wei@linaro.org>, "tbaicar@codeaurora.org" <tbaicar@codeaurora.org>, "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>

Yes, looks like we missed the revision update for the generic update.

We will update the actbl1.h file

Thanks,
Bob


> -----Original Message-----
> From: Abdulhamid, Harb [mailto:harba@codeaurora.org]
> Sent: Saturday, February 20, 2016 1:41 PM
> To: Zheng, Lv; Wysocki, Rafael J; Rafael J. Wysocki; Brown, Len
> Cc: Lv Zheng; linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org;
> Moore, Robert; Al Stone; fu.wei@linaro.org; tbaicar@codeaurora.org;
> rruigrok@codeaurora.org
> Subject: Re: [PATCH 12/15] ACPICA: ACPI 6.1: Add full support for this
> version of ACPI spec
> 
> On 2/19/2016 1:17 AM, Lv Zheng wrote:
> > From: Bob Moore <robert.moore@intel.com>
> >
> > ACPICA commit 5f21bddaa2cec035ca80608803ce2f0858d4f387
> >
> > Small changes:
> > 1) A couple new predefined names
> > 2) New _HID values
> I don't see where you are adding new _HID values in this patch.
> 
> > 3) New subtable for HEST
> >
> > Link: https://github.com/acpica/acpica/commit/5f21bdda
> > Signed-off-by: Bob Moore <robert.moore@intel.com>
> > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > ---
> >  drivers/acpi/acpica/acpredef.h |    9 +++++++++
> >  drivers/acpi/acpica/utdecode.c |   30 +++++++++++++++++-------------
> >  include/acpi/actbl.h           |    2 +-
> >  include/acpi/actbl1.h          |   29 ++++++++++++++++++++++++++---
> >  include/acpi/actypes.h         |    3 ++-
> >  5 files changed, 55 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/acpi/acpica/acpredef.h
> > b/drivers/acpi/acpica/acpredef.h index 5faeab4..4ca426b 100644
> > --- a/drivers/acpi/acpica/acpredef.h
> > +++ b/drivers/acpi/acpica/acpredef.h
> > @@ -523,6 +523,9 @@ const union acpi_predefined_info
> acpi_gbl_predefined_methods[] = {
> >  	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (4 Int) */
> >  	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 4, 0, 0, 0),
> >
> > +	{{"_FIT", METHOD_0ARGS,
> > +	  METHOD_RETURNS(ACPI_RTYPE_BUFFER)}},	/* ACPI 6.0 */
> > +
> >  	{{"_FIX", METHOD_0ARGS,
> >  	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Ints)
> */
> >  	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 0, 0, 0, 0), @@
> > -1053,6 +1056,12 @@ const union acpi_predefined_info
> acpi_gbl_predefined_methods[] = {
> >  	  METHOD_RETURNS(ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING |
> >  			 ACPI_RTYPE_BUFFER)}},
> >
> > +	{{"_WPC", METHOD_0ARGS,
> > +	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},	/* ACPI 6.1 */
> > +
> > +	{{"_WPP", METHOD_0ARGS,
> > +	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},	/* ACPI 6.1 */
> > +
> >  	PACKAGE_INFO(0, 0, 0, 0, 0, 0)	/* Table terminator */
> >  };
> >  #else
> > diff --git a/drivers/acpi/acpica/utdecode.c
> > b/drivers/acpi/acpica/utdecode.c index 6ba65b0..efd7988 100644
> > --- a/drivers/acpi/acpica/utdecode.c
> > +++ b/drivers/acpi/acpica/utdecode.c
> > @@ -446,7 +446,7 @@ const char *acpi_ut_get_mutex_name(u32 mutex_id)
> >
> >  /* Names for Notify() values, used for debug output */
> >
> > -static const char *acpi_gbl_generic_notify[ACPI_NOTIFY_MAX + 1] = {
> > +static const char *acpi_gbl_generic_notify[ACPI_GENERIC_NOTIFY_MAX +
> > +1] = {
> >  	/* 00 */ "Bus Check",
> >  	/* 01 */ "Device Check",
> >  	/* 02 */ "Device Wake",
> > @@ -459,49 +459,53 @@ static const char
> *acpi_gbl_generic_notify[ACPI_NOTIFY_MAX + 1] = {
> >  	/* 09 */ "Device PLD Check",
> >  	/* 0A */ "Reserved",
> >  	/* 0B */ "System Locality Update",
> > -	/* 0C */ "Shutdown Request",
> > +					/* 0C */ "Shutdown Request",
> > +					/* Reserved in ACPI 6.0 */
> >  	/* 0D */ "System Resource Affinity Update"
> >  };
> >
> > -static const char *acpi_gbl_device_notify[4] = {
> > +static const char *acpi_gbl_device_notify[5] = {
> >  	/* 80 */ "Status Change",
> >  	/* 81 */ "Information Change",
> >  	/* 82 */ "Device-Specific Change",
> > -	/* 83 */ "Device-Specific Change"
> > +	/* 83 */ "Device-Specific Change",
> > +	/* 84 */ "Reserved"
> >  };
> >
> > -static const char *acpi_gbl_processor_notify[4] = {
> > +static const char *acpi_gbl_processor_notify[5] = {
> >  	/* 80 */ "Performance Capability Change",
> >  	/* 81 */ "C-State Change",
> >  	/* 82 */ "Throttling Capability Change",
> > -	/* 83 */ "Device-Specific Change"
> > +	/* 83 */ "Guaranteed Change",
> > +	/* 84 */ "Minimum Excursion"
> >  };
> >
> > -static const char *acpi_gbl_thermal_notify[4] = {
> > +static const char *acpi_gbl_thermal_notify[5] = {
> >  	/* 80 */ "Thermal Status Change",
> >  	/* 81 */ "Thermal Trip Point Change",
> >  	/* 82 */ "Thermal Device List Change",
> > -	/* 83 */ "Thermal Relationship Change"
> > +	/* 83 */ "Thermal Relationship Change",
> > +	/* 84 */ "Reserved"
> >  };
> >
> >  const char *acpi_ut_get_notify_name(u32 notify_value,
> > acpi_object_type type)  {
> >
> > -	/* 00 - 0D are common to all object types */
> > +	/* 00 - 0D are "common to all object types" (from ACPI Spec) */
> >
> > -	if (notify_value <= ACPI_NOTIFY_MAX) {
> > +	if (notify_value <= ACPI_GENERIC_NOTIFY_MAX) {
> >  		return (acpi_gbl_generic_notify[notify_value]);
> >  	}
> >
> > -	/* 0D - 7F are reserved */
> > +	/* 0E - 7F are reserved */
> >
> >  	if (notify_value <= ACPI_MAX_SYS_NOTIFY) {
> >  		return ("Reserved");
> >  	}
> >
> > -	/* 80 - 83 are per-object-type */
> > +	/* 80 - 84 are per-object-type */
> >
> > -	if (notify_value <= 0x83) {
> > +	if (notify_value <= ACPI_SPECIFIC_NOTIFY_MAX) {
> >  		switch (type) {
> >  		case ACPI_TYPE_ANY:
> >  		case ACPI_TYPE_DEVICE:
> > diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h index
> > 0cb1a00..6a4e521 100644
> > --- a/include/acpi/actbl.h
> > +++ b/include/acpi/actbl.h
> > @@ -223,7 +223,7 @@ struct acpi_table_facs {
> >
> /*************************************************************************
> ******
> >   *
> >   * FADT - Fixed ACPI Description Table (Signature "FACP")
> > - *        Version 4
> > + *        Version 6
> >   *
> >
> > **********************************************************************
> > ********/
> >
> > diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h index
> > 16e0136..26494dd 100644
> > --- a/include/acpi/actbl1.h
> > +++ b/include/acpi/actbl1.h
> > @@ -236,7 +236,8 @@ enum acpi_einj_actions {
> >  	ACPI_EINJ_CHECK_BUSY_STATUS = 6,
> >  	ACPI_EINJ_GET_COMMAND_STATUS = 7,
> >  	ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS = 8,
> > -	ACPI_EINJ_ACTION_RESERVED = 9,	/* 9 and greater are reserved */
> > +	ACPI_EINJ_GET_EXECUTE_TIMINGS = 9,
> > +	ACPI_EINJ_ACTION_RESERVED = 10,	/* 10 and greater are reserved
> */
> >  	ACPI_EINJ_TRIGGER_ERROR = 0xFF	/* Except for this value */
> >  };
> >
> > @@ -348,7 +349,8 @@ enum acpi_erst_actions {
> >  	ACPI_ERST_GET_ERROR_RANGE = 13,
> >  	ACPI_ERST_GET_ERROR_LENGTH = 14,
> >  	ACPI_ERST_GET_ERROR_ATTRIBUTES = 15,
> > -	ACPI_ERST_ACTION_RESERVED = 16	/* 16 and greater are reserved
> */
> > +	ACPI_ERST_EXECUTE_TIMINGS = 16,
> > +	ACPI_ERST_ACTION_RESERVED = 17	/* 17 and greater are reserved
> */
> >  };
> >
> >  /* Values for Instruction field above */ @@ -427,7 +429,8 @@ enum
> > acpi_hest_types {
> >  	ACPI_HEST_TYPE_AER_ENDPOINT = 7,
> >  	ACPI_HEST_TYPE_AER_BRIDGE = 8,
> >  	ACPI_HEST_TYPE_GENERIC_ERROR = 9,
> > -	ACPI_HEST_TYPE_RESERVED = 10	/* 10 and greater are reserved */
> > +	ACPI_HEST_TYPE_GENERIC_ERROR_V2 = 10,
> > +	ACPI_HEST_TYPE_RESERVED = 11	/* 11 and greater are reserved */
> >  };
> >
> >  /*
> > @@ -603,6 +606,24 @@ struct acpi_hest_generic {
> >  	u32 error_block_length;
> >  };
> >
> > +/* 10: Generic Hardware Error Source, version 2 */
> > +
> > +struct acpi_hest_generic_v2 {
> > +	struct acpi_hest_header header;
> > +	u16 related_source_id;
> > +	u8 reserved;
> > +	u8 enabled;
> > +	u32 records_to_preallocate;
> > +	u32 max_sections_per_record;
> > +	u32 max_raw_data_length;
> > +	struct acpi_generic_address error_status_address;
> > +	struct acpi_hest_notify notify;
> > +	u32 error_block_length;
> > +	struct acpi_generic_address read_ack_register;
> > +	u64 read_ack_preserve;
> > +	u64 read_ack_write;
> > +};
> > +
> >  /* Generic Error Status block */
> >
> >  struct acpi_hest_generic_status {
> > @@ -632,6 +653,7 @@ struct acpi_hest_generic_data {
> >  	u32 error_data_length;
> >  	u8 fru_id[16];
> >  	u8 fru_text[20];
> > +	u64 time_stamp;
> >  };
> There is quite a bit of overlap between this patch and our patch series
> (https://lkml.org/lkml/2016/2/5/544)
> 
> There are few things I see missing in this patch in your updates made to
> actbl1.h, I list them below:
> 
> 1) Adding time stamp as you did breaks backwards compatibility (something
> we discovered during our testing).  We tried to remedy this by adding a
> new version of the acpi_hest_generic_data structure.  Note that we named
> it v3 to reflect this was the updated version number in ACPI 6.1. (see
> https://lkml.org/lkml/2016/2/5/549)
> 
> 2) Missing definition of generic error data validation bits, needed to
> determine whether or not field being read are valid or not (see
> https://lkml.org/lkml/2016/2/5/549)
> 
> 3) Need to extend acpi_hest_notify_types to add GPIO, SEA, SEI, and GSIV
> (see https://lkml.org/lkml/2016/2/5/545)
> 
> 4) Also for the purpose of backwards compatibility, we needed to add both
> acpi_hest_generic and acpi_hest_generic_v2 to the structure "ghes",
> referencing the v2 pointer when needed.
> (https://lkml.org/lkml/2016/2/5/550)
> 
> Can you please review the above patch series patches for comparison, and
> if in agreement, can you please update this patch to better align with the
> changes we need?  We can rework our patch series to depend on your patch
> series (i.e. leaving actbl1.h untouched on our side).
> 
> >
> >
> > /*********************************************************************
> > ********** @@ -1015,6 +1037,7 @@ struct acpi_nfit_memory_map {
> >  #define ACPI_NFIT_MEM_NOT_ARMED         (1<<3)	/* 03: Memory Device
> is not armed */
> >  #define ACPI_NFIT_MEM_HEALTH_OBSERVED   (1<<4)	/* 04: Memory Device
> observed SMART/health events */
> >  #define ACPI_NFIT_MEM_HEALTH_ENABLED    (1<<5)	/* 05: SMART/health
> events enabled */
> > +#define ACPI_NFIT_MEM_MAP_FAILED        (1<<6)	/* 06: Mapping to
> SPA failed */
> >
> >  /* 2: Interleave Structure */
> >
> > diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h index
> > db46546..140886e 100644
> > --- a/include/acpi/actypes.h
> > +++ b/include/acpi/actypes.h
> > @@ -630,7 +630,8 @@ typedef u64 acpi_integer;
> >  #define ACPI_NOTIFY_SHUTDOWN_REQUEST    (u8) 0x0C
> >  #define ACPI_NOTIFY_AFFINITY_UPDATE     (u8) 0x0D
> >
> > -#define ACPI_NOTIFY_MAX                 0x0D
> > +#define ACPI_GENERIC_NOTIFY_MAX         0x0D
> > +#define ACPI_SPECIFIC_NOTIFY_MAX        0x84
> >
> >  /*
> >   * Types associated with ACPI names and objects. The first group of
> >
> 
> Harb
> --
> Qualcomm Technologies, Inc.
> on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux
> Foundation Collaborative Project
