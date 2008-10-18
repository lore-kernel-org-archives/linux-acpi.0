From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: ACPICA header files
Date: Sat, 18 Oct 2008 14:05:36 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858032E075F@orsmsx503.amr.corp.intel.com>
References: <200810171449.m9HEnoHM018514@los-vmm.sc.intel.com>
 <4911F71203A09E4D9981D27F9D830858032E0245@orsmsx503.amr.corp.intel.com>
 <alpine.LFD.1.10.0810171653510.3006@localhost.localdomain>
 <4911F71203A09E4D9981D27F9D830858032E0503@orsmsx503.amr.corp.intel.com>
 <4911F71203A09E4D9981D27F9D830858032E0739@orsmsx503.amr.corp.intel.com>
 <48FA1FF8.1090806@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58381 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905AbYJRVFj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Oct 2008 17:05:39 -0400
In-Reply-To: <48FA1FF8.1090806@suse.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Len Brown <lenb@kernel.org>, "Dugger, Donald D" <donald.d.dugger@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "bjorn.helgaas@hp.com" <bjorn.helgaas@hp.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Lin, Ming M" <ming.m.lin@intel.com>

Right. We would change acpi.h to only pull in the public headers.

This would only break code that is cheating.

-----Original Message-----
From: Alexey Starikovskiy [mailto:astarikovskiy@suse.de]
Sent: Saturday, October 18, 2008 10:42 AM
To: Moore, Robert
Cc: Len Brown; Dugger, Donald D; linux-acpi@vger.kernel.org; bjorn.helgaas@hp.com; akpm@linux-foundation.org; Lin, Ming M
Subject: Re: ACPICA header files

The problem with linux acpi headers is that all drivers include <linux/acpi.h>, which will include private headers.
We need to remove all private headers from this public one.

Moore, Robert wrote:
> The actual "public" acpica headers are:
>
> acexcep.h    // ACPICA exceptions
> actypes.h    // ACPICA data types
> actbl.h      // ACPI table definitions
> acpixf.h     // Prototypes for ACPICA interfaces (host-to-ACPICA)
> acpiosxf.h   // Prototypes for OSL interfaces (ACPICA-to-host)
>
> And the entire contents of the include/platform directory
>
> Would it make sense (would it be helpful) to leave these public headers in the current acpi include directory and to move everything else to a new directory?
>
> How about include/internal.
>
> We could keep the existing acpi.h file and have it only pull in the files above, so the disruption to existing acpica users would be minimal. The only code that would be affected would be code that is cheating by using ACPICA internal interfaces.
>
> It may be the case that some internal functions are actually useful to the ACPI-related device drivers. I don't have any issue with making these interfaces public (and beefing up the parameter validation, etc.)
>
> Comments?
> Thanks,
> Bob
>
>
>
> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Moore, Robert
> Sent: Friday, October 17, 2008 2:50 PM
> To: Len Brown
> Cc: Dugger, Donald D; linux-acpi@vger.kernel.org; bjorn.helgaas@hp.com; akpm@linux-foundation.org; astarikovskiy@suse.de; Lin, Ming M
> Subject: RE: [PATCH] Fix possible null ptr dereference
>
> It's on the TBD list.
>
> Not true that everything includes everything, however. But everything is in the same directory.
>
> How would you organize things?
>
>
>> -----Original Message-----
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>> owner@vger.kernel.org] On Behalf Of Len Brown
>> Sent: Friday, October 17, 2008 1:55 PM
>> To: Moore, Robert
>> Cc: Dugger, Donald D; linux-acpi@vger.kernel.org; bjorn.helgaas@hp.com;
>> akpm@linux-foundation.org; astarikovskiy@suse.de; Lin, Ming M
>> Subject: RE: [PATCH] Fix possible null ptr dereference
>>
>>
>>> In general, the internal ACPICA functions do not perform nearly as much
>> parameter validation as the external functions. The Host OS should not be
>> calling any of the ACPICA internal functions for this and a few other good
>> reasons -- such as the fact that internal functions can disappear, be
>> renamed, or have the parameters changed without warning at any time.
>>> It would probably be a good idea to audit Linux for the use of internal
>> ACPICA functions and fix these bugs.
>>
>> I think the way to do this is to clean up the headers
>> so that code outside of ACPICA doesn't even see
>> the declarations of the internal ACPICA functions.
>>
>> Right now everything includes everything, so the headers can't help us.
>>
>> -Len
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

