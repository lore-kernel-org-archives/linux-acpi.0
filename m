From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA / hwreg: Use acpi_gbl_reduced_hardware to
 prevent accessing PM registers
Date: Mon, 16 Sep 2013 17:26:08 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEC56A@ORSMSX103.amr.corp.intel.com>
References: <1379066741-23689-1-git-send-email-hanjun.guo@linaro.org>
 <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEBC6A@ORSMSX103.amr.corp.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEC15B@ORSMSX103.amr.corp.intel.com>
 <52366F91.30204@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34139 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197Ab3IPR0K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Sep 2013 13:26:10 -0400
In-Reply-To: <52366F91.30204@linaro.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "'Rafael J. Wysocki'" <rjw@sisk.pl>, 'Len Brown' <lenb@kernel.org>, "Box, David E" <david.e.box@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, "'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>, "'patches@linaro.org'" <patches@linaro.org>, "'linaro-kernel@lists.linaro.org'" <linaro-kernel@lists.linaro.org>, "'linaro-acpi@lists.linaro.org'" <linaro-acpi@lists.linaro.org>

+ #define ACPI_REDUCED_HARDWARE           TRUE

The intent of this feature is of course, to remove all code that is not needed -- specifically for hardware-reduced machines where the size of the kernel is important.

On a larger machine, the hardware-reduced flag should be sufficient. However, I would think that the host OS would look at this flag and realize that it should not be doing certain ACPI hardware-related things up front, rather than later when it finds out that a write to some ACPI hardware fails because the hardware isn't there.

This is not to say that it is probably a good thing to return an error from the ACPI hardware code in the hardware-reduced case.

Bob


> -----Original Message-----
> From: Hanjun Guo [mailto:hanjun.guo@linaro.org]
> Sent: Sunday, September 15, 2013 7:40 PM
> To: Moore, Robert
> Cc: 'Rafael J. Wysocki'; 'Len Brown'; Box, David E; Zheng, Lv; 'linux-
> acpi@vger.kernel.org'; 'patches@linaro.org'; 'linaro-
> kernel@lists.linaro.org'; 'linaro-acpi@lists.linaro.org'
> Subject: Re: [PATCH] ACPICA / hwreg: Use acpi_gbl_reduced_hardware to
> prevent accessing PM registers
> 
> On 2013-9-14 4:16, Moore, Robert wrote:
> >
> >
> >> -----Original Message-----
> >> From: Moore, Robert
> >> Sent: Friday, September 13, 2013 6:08 AM
> >> To: Hanjun Guo; Rafael J. Wysocki; Len Brown
> >> Cc: Zheng, Lv; linux-acpi@vger.kernel.org; patches@linaro.org;
> >> linaro- kernel@lists.linaro.org; linaro-acpi@lists.linaro.org
> >> Subject: RE: [PATCH] ACPICA / hwreg: Use acpi_gbl_reduced_hardware to
> >> prevent accessing PM registers
> >>
> >> NOT_IMPLEMENTED refers to the software only; therefore AE_SUPPORT
> >> should be returned.
> >>
> >> Otherwise, seems like this may be a good idea.
> >
> >
> > On the other hand, could one not argue that the host OS should darn
> > well know that it is executing on a hardware-reduced platform and not
> > call these functions in the first place?
> 
> Well, there is a macro ACPI_REDUCED_HARDWARE and used to switch off the
> compiling of these functions on hardware-reduced platform, if
> ACPI_REDUCED_HARDWARE is TRUE, those functions will never be called.
> 
> But is that reasonable? When somebody want to use the ACPI code on
> hardware-reduced platform, they should introduce a patch just like:
> 
> - #define ACPI_REDUCED_HARDWARE           FALSE
> + #define ACPI_REDUCED_HARDWARE           TRUE
> in include/acpi/acconfig.h
> 
> and this patch does not exist in upstream, and it will never be accepted
> by upstream too, it is weird. so we should proposal another way.
> 
> I thought about introducing a kernel config such as
> CONFIG_ACPI_REDUCED_HARDWARE to enable ACPI_REDUCED_HARDWARE, but it is
> just the same as a macro, and I drop it.
> 
> So, this is a problem should be solved for hardware-reduced platform, use
> falg acpi_gbl_reduced_hardware seems a good solution.
> 
> Thanks
> Hanjun
> 
> >
> > Bob

