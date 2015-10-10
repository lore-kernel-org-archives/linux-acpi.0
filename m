From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to find \_Sx
 should not result in a loud warning [v2]
Date: Sat, 10 Oct 2015 01:22:20 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BAC6BF4@SHSMSX101.ccr.corp.intel.com>
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
Received: from mga01.intel.com ([192.55.52.88]:25627 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956AbbJJBWY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Oct 2015 21:22:24 -0400
In-Reply-To: <5617A525.2070806@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>, "Moore, Robert" <robert.moore@intel.com>, "devel@acpica.org" <devel@acpica.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>

Hi,

> From: Prarit Bhargava [mailto:prarit@redhat.com]
> Sent: Friday, October 09, 2015 7:30 PM
> 
> On 10/09/2015 01:26 AM, Zheng, Lv wrote:
> > Please ignore this.
> > The fix is against the caller.

As I said, the previous email is sent due to lack of confirmation.
So you needn't reply the previous message.

Thanks
-Lv

> >
> > Thanks and best regards
> > -Lv
> >
> >> From: Devel [mailto:devel-bounces@acpica.org] On Behalf Of Zheng, Lv
> >> Sent: Friday, October 09, 2015 10:02 AM
> >>
> >> Why don't you fix this in the invoker side?
> >> For example:
> >> If (acpi_get_handle())
> >> 	acpi_evaluate_object()
> 
> That seems like a sloppy workaround an actual bug in ACPICA.
> 
> >> So that the AE_NOT_FOUND warning can still be kept for the real troubles?
> 
> The code is warning 100% of the time on something that is optional.
> 
> >> There are really scenarios that such warning is useful for catching bugs.
> >>
> 
> What scenario is possible where this causes a problem?  Issuing an error on
> something that is optional is not a good idea.
> 
> P.
