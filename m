From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 12/15] ACPICA: ACPI 6.1: Add full support for this
 version of ACPI spec
Date: Wed, 24 Feb 2016 17:39:14 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E44BCF7@ORSMSX110.amr.corp.intel.com>
References: <cover.1455857575.git.lv.zheng@intel.com>
 <deb7863aba0b4ca2b350f206355a06c4701a2b23.1455857585.git.lv.zheng@intel.com>
 <56C8DD6F.5070506@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18621 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758264AbcBXRjU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Feb 2016 12:39:20 -0500
In-Reply-To: <56C8DD6F.5070506@codeaurora.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Abdulhamid, Harb" <harba@codeaurora.org>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Al Stone <ahs3@redhat.com>, "fu.wei@linaro.org" <fu.wei@linaro.org>, "tbaicar@codeaurora.org" <tbaicar@codeaurora.org>, "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>


 
> There are few things I see missing in this patch in your updates made to
> actbl1.h, I list them below:
> 
> 1) Adding time stamp as you did breaks backwards compatibility (something
> we discovered during our testing).  We tried to remedy this by adding a
> new version of the acpi_hest_generic_data structure.  Note that we named
> it v3 to reflect this was the updated version number in ACPI 6.1. (see
> https://lkml.org/lkml/2016/2/5/549)

I used V300 in case there is ever some other 3xx version.

Plus, I made a full struct for the V300 case.

> 
> 2) Missing definition of generic error data validation bits, needed to
> determine whether or not field being read are valid or not (see
> https://lkml.org/lkml/2016/2/5/549)

Done.

> 
> 3) Need to extend acpi_hest_notify_types to add GPIO, SEA, SEI, and GSIV
> (see https://lkml.org/lkml/2016/2/5/545)

Done.

> 
> 4) Also for the purpose of backwards compatibility, we needed to add both
> acpi_hest_generic and acpi_hest_generic_v2 to the structure "ghes",
> referencing the v2 pointer when needed.
> (https://lkml.org/lkml/2016/2/5/550)

This doesn't affect the ACPICA code (actbl1.h), I don't think.

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
