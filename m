From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: Linux ACPI BERT implementation
Date: Fri, 12 Aug 2011 04:43:54 -0500
Message-ID: <6C03668EAF45B747AF947A1603D1B3000197FBCC0D@SAUSEXMBP01.amd.com>
References: <6C03668EAF45B747AF947A1603D1B300018F85B9D6@SAUSEXMBP01.amd.com>
 <4E1FE749.2080707@intel.com>
 <6C03668EAF45B747AF947A1603D1B3000197F3F448@SAUSEXMBP01.amd.com>
 <4E4495E7.3050305@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:23119 "EHLO
	TX2EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751476Ab1HLJn6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 Aug 2011 05:43:58 -0400
In-Reply-To: <4E4495E7.3050305@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Su, Henry" <Henry.Su@amd.com>

Hi Huang,


> -----Original Message-----
> From: Huang Ying [mailto:ying.huang@intel.com]
> Sent: Friday, August 12, 2011 8:25 AM
> To: Nath, Arindam
> Cc: linux-acpi@vger.kernel.org; Su, Henry
> Subject: Re: Linux ACPI BERT implementation
> 
> Hi, Arindam,
> 
> The bert patch is attached with the mail.

Thanks for the patch.

> 
> The testing steps
> 
> 1. Build kernel with APEI enabled.
> 2. Trigger some hardware error so that BERT will be filled
> 3. Reboot system, and check whether there are some kernel message
> (dmesg) begin with
> 
> [Hardware Error] Error record from previous boot:
> 
> We don't know how to do (2).  That is key for this testing.

I will try to contact our design engineers to help me with this.

Thanks,
Arindam

> 
> Best Regards,
> Huang Ying
> 
> On 08/10/2011 02:36 PM, Nath, Arindam wrote:
> > Hi Huang,
> >
> >> -----Original Message-----
> >> From: Huang Ying [mailto:ying.huang@intel.com]
> >> Sent: Friday, July 15, 2011 12:38 PM
> >> To: Nath, Arindam
> >> Cc: linux-acpi@vger.kernel.org; Su, Henry
> >> Subject: Re: Linux ACPI BERT implementation
> >>
> >> On 07/15/2011 02:45 PM, Nath, Arindam wrote:
> >>> Hi Huang,
> >>>
> >>>
> >>>
> >>> Since you have already added some support for APEI into the ACPI
> >>> subsystem, are you planning to add support for BERT too?
> >>
> >> Yes. I have the code.  But have not found a way to test it on my
> >> testing
> >> machine.  Do you have any machine to test it?
> >
> > Sorry for the late response. We do have platform with ACPI BERT
> support, but it has not been tested. So if you provide me the patch, it
> would help if you could also provide me the steps to test the patch.
> >
> > Thanks,
> > Arindam
> >
> >>
> >> Best Regards,
> >> Huang Ying
> >
> >


