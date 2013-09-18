From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA / hwreg: Use acpi_gbl_reduced_hardware to
 prevent accessing PM registers
Date: Wed, 18 Sep 2013 15:09:04 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FEFA437@ORSMSX102.amr.corp.intel.com>
References: <1379066741-23689-1-git-send-email-hanjun.guo@linaro.org>
 <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEBC6A@ORSMSX103.amr.corp.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEC15B@ORSMSX103.amr.corp.intel.com>
 <52366F91.30204@linaro.org>
 <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEC56A@ORSMSX103.amr.corp.intel.com>
 <523972F4.9070703@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:35255 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414Ab3IRPJH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Sep 2013 11:09:07 -0400
In-Reply-To: <523972F4.9070703@linaro.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "'Rafael J. Wysocki'" <rjw@sisk.pl>, 'Len Brown' <lenb@kernel.org>, "Box, David E" <david.e.box@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, "'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>, "'patches@linaro.org'" <patches@linaro.org>, "'linaro-kernel@lists.linaro.org'" <linaro-kernel@lists.linaro.org>, "'linaro-acpi@lists.linaro.org'" <linaro-acpi@lists.linaro.org>



> -----Original Message-----
> From: Hanjun Guo [mailto:hanjun.guo@linaro.org]
> Sent: Wednesday, September 18, 2013 2:32 AM
> To: Moore, Robert
> Cc: 'Rafael J. Wysocki'; 'Len Brown'; Box, David E; Zheng, Lv; 'linux-
> acpi@vger.kernel.org'; 'patches@linaro.org'; 'linaro-
> kernel@lists.linaro.org'; 'linaro-acpi@lists.linaro.org'
> Subject: Re: [PATCH] ACPICA / hwreg: Use acpi_gbl_reduced_hardware to
> prevent accessing PM registers
> 
> On 2013-9-17 1:26, Moore, Robert wrote:
> > + #define ACPI_REDUCED_HARDWARE           TRUE
> >
> > The intent of this feature is of course, to remove all code that is not
> needed -- specifically for hardware-reduced machines where the size of the
> kernel is important.
> >
> > On a larger machine, the hardware-reduced flag should be sufficient.
> However, I would think that the host OS would look at this flag and
> realize that it should not be doing certain ACPI hardware-related things
> up front, rather than later when it finds out that a write to some ACPI
> hardware fails because the hardware isn't there.
> 
> Do you mean we should change the ACPI device driver instead of changing
> the ACPICA code? that would be a hard job, because hardware ACPI is used
> everywhere.
> 


I don't really know the answer to this, but something tells me that bad things may happen when a driver expects the ACPI hardware to be there, and it finds out that it isn't, simply by calling one of the ACPI hardware interfaces.

Or, we could word it this way: if a driver is expecting the ACPI hardware to exist, and we are running on a hardware-reduced platform, why is the driver being loaded in the first place?

BTW, hardware-reduced is not restricted to ARM platforms.




> Thanks
> Hanjun
> 
> >
> > This is not to say that it is probably a good thing to return an error
> from the ACPI hardware code in the hardware-reduced case.
> >
> > Bob
> >
> 

