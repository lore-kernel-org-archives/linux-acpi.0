From: Zhao Yakui <yakui.zhao@intel.com>
Subject: RE: [PATCH] ACPI: Ignore AE_NOT_FOUND error of EC _REG method and
	continue to initialize EC
Date: Thu, 31 Jul 2008 14:28:58 +0800
Message-ID: <1217485738.4006.73.camel@yakui_zhao.sh.intel.com>
References: <5f6f8c5f0807301903p5018e656y743d131822b4056e@mail.gmail.com>
	 <9D39833986E69849A2A8E74C1078B6B3BFA98A@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:52731 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755640AbYGaGQI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jul 2008 02:16:08 -0400
In-Reply-To: <9D39833986E69849A2A8E74C1078B6B3BFA98A@orsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Joshua C." <joshuacov@googlemail.com>, linux-acpi@vger.kernel.org, "Lin, Ming M" <ming.m.lin@intel.com>, "Kleen, Andi" <andi.kleen@intel.com>

On Wed, 2008-07-30 at 19:11 -0700, Moore, Robert wrote:
> Looking at this patch, I see that it solves a very specific case, namely
> the AE_NOT_FOUND exception. However, this is just one of many exceptions
> that we may want to ignore. In fact, I wonder if in the general case we
> should just ignore all exceptions from _REG methods, other than printing
> some kind of message.
Yes.  This patch only solves the specific case. For example: in the bug
8953, 10237.

But if all the exceptions from the _REG methods are ignored, it will be
too aggressive. Maybe some potential problems will be hidden. We had
better wait for that more people complain the similar bugs.

Thanks.

> 
> Bob
> 
> 
> >-----Original Message-----
> >From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> >owner@vger.kernel.org] On Behalf Of Joshua C.
> >Sent: Wednesday, July 30, 2008 7:03 PM
> >To: linux-acpi@vger.kernel.org
> >Subject: Re: [PATCH] ACPI: Ignore AE_NOT_FOUND error of EC _REG method
> and
> >continue to initialize EC
> >
> >On Mon, Jul 28, 2008 at 14:59:26AM +0800, Andi Kleen wrote:
> >> >Subject:ACPI: Ignore AE_NOT_FOUND error of EC _REG method and
> continue
> >to initialize EC
> >> >From: Zhao Yakui <yakui.zhao@intel.com>
> >>Thanks. Queued for test. How urgent is this? Do we need to consider it
> >>for .27?
> >>
> >>-Andi
> >
> >It will be great if you can put this in .27.
> >
> >--joshua
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

