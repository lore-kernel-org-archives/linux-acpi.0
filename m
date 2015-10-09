From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to find \_Sx
 should not result in a loud warning [v2]
Date: Fri, 9 Oct 2015 14:04:22 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D9784D0@ORSMSX112.amr.corp.intel.com>
References: <94F2FBAB4432B54E8AACC7DFDE6C92E37D36303A@ORSMSX112.amr.corp.intel.com>
 <1444243849-27929-1-git-send-email-prarit@redhat.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D970F57@ORSMSX111.amr.corp.intel.com>
 <56167C58.8000405@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E883BAC675E@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E883BAC67EE@SHSMSX101.ccr.corp.intel.com>
 <5617A525.2070806@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40578 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231AbbJIOEX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Oct 2015 10:04:23 -0400
In-Reply-To: <5617A525.2070806@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>, "Zheng, Lv" <lv.zheng@intel.com>, "devel@acpica.org" <devel@acpica.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>

I have no issues with the original solution. We don't warn on other ACPI_NOT_FOUND exceptions.


> -----Original Message-----
> From: Prarit Bhargava [mailto:prarit@redhat.com]
> Sent: Friday, October 09, 2015 4:30 AM
> To: Zheng, Lv; Moore, Robert; devel@acpica.org
> Cc: linux-acpi@vger.kernel.org; Wysocki, Rafael J
> Subject: Re: [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to find \_Sx
> should not result in a loud warning [v2]
> 
> 
> 
> On 10/09/2015 01:26 AM, Zheng, Lv wrote:
> > Please ignore this.
> > The fix is against the caller.
> >
> > Thanks and best regards
> > -Lv
> >
> >> -----Original Message-----
> >> From: Devel [mailto:devel-bounces@acpica.org] On Behalf Of Zheng, Lv
> >> Sent: Friday, October 09, 2015 10:02 AM
> >> To: Prarit Bhargava; Moore, Robert; devel@acpica.org
> >> Cc: linux-acpi@vger.kernel.org; Wysocki, Rafael J
> >> Subject: Re: [Devel] [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to
> >> find \_Sx should not result in a loud warning [v2]
> >>
> >> Why don't you fix this in the invoker side?
> >> For example:
> >> If (acpi_get_handle())
> >> 	acpi_evaluate_object()
> 
> That seems like a sloppy workaround an actual bug in ACPICA.
> 
> >> So that the AE_NOT_FOUND warning can still be kept for the real
> troubles?
> 
> The code is warning 100% of the time on something that is optional.
> 
> >> There are really scenarios that such warning is useful for catching
> bugs.
> >>
> 
> What scenario is possible where this causes a problem?  Issuing an error
> on something that is optional is not a good idea.
> 
> P.
