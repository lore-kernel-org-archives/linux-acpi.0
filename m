From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH] ACPI: Ignore AE_NOT_FOUND error of EC _REG method and
	continue to initialize EC
Date: Fri, 01 Aug 2008 10:03:16 +0800
Message-ID: <1217556196.6766.24.camel@yakui_zhao.sh.intel.com>
References: <5f6f8c5f0807301903p5018e656y743d131822b4056e@mail.gmail.com>
	 <9D39833986E69849A2A8E74C1078B6B3BFA98A@orsmsx415.amr.corp.intel.com>
	 <1217485738.4006.73.camel@yakui_zhao.sh.intel.com>
	 <48920EE0.6030808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:61305 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355AbYHABui (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jul 2008 21:50:38 -0400
In-Reply-To: <48920EE0.6030808@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Joshua C." <joshuacov@googlemail.com>, linux-acpi@vger.kernel.org, "Lin, Ming M" <ming.m.lin@intel.com>, "Kleen, Andi" <andi.kleen@intel.com>

On Thu, 2008-07-31 at 23:13 +0400, Alexey Starikovskiy wrote:
> NAK.
> 
> As already mentioned, there is no point to put this workaround in ec.c.
> Instead, it should be placed into acpi_register_operation_region, or may 
> be even
> higher (like a flag to ignore errors during execution of the method).
Maybe what your said is right. The generic method about ignoring the
error during the execution of the method is very good. But it will
become more complicated. Maybe it is too aggressive and will have other
side effect that we can't know. 

As the acpi_install_address_space_handler is realized in ACPICA and
called by other drivers, it is not appropriate to ignore the error in
the generic ACPICA function. At the same time this error is related with
EC device, maybe it is more appropriate that EC driver determines
whether OS continues to initialize EC device.

IMO this workaround patch can fix the issue that is related with the EC
_REG method(For example: bug 8953, 10237). At the same time this will
have no effect on the other systems. 

best regards.
   Yakui

> Regards,
> Alex.
> 
> Zhao Yakui wrote:
> > On Wed, 2008-07-30 at 19:11 -0700, Moore, Robert wrote:
> >   
> >> Looking at this patch, I see that it solves a very specific case, namely
> >> the AE_NOT_FOUND exception. However, this is just one of many exceptions
> >> that we may want to ignore. In fact, I wonder if in the general case we
> >> should just ignore all exceptions from _REG methods, other than printing
> >> some kind of message.
> >>     
> > Yes.  This patch only solves the specific case. For example: in the bug
> > 8953, 10237.
> >
> > But if all the exceptions from the _REG methods are ignored, it will be
> > too aggressive. Maybe some potential problems will be hidden. We had
> > better wait for that more people complain the similar bugs.
> >
> > Thanks.
> >
> >   
> >> Bob
> >>
> >>
> >>     
> >>> -----Original Message-----
> >>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> >>> owner@vger.kernel.org] On Behalf Of Joshua C.
> >>> Sent: Wednesday, July 30, 2008 7:03 PM
> >>> To: linux-acpi@vger.kernel.org
> >>> Subject: Re: [PATCH] ACPI: Ignore AE_NOT_FOUND error of EC _REG method
> >>>       
> >> and
> >>     
> >>> continue to initialize EC
> >>>
> >>> On Mon, Jul 28, 2008 at 14:59:26AM +0800, Andi Kleen wrote:
> >>>       
> >>>>> Subject:ACPI: Ignore AE_NOT_FOUND error of EC _REG method and
> >>>>>           
> >> continue
> >>     
> >>> to initialize EC
> >>>       
> >>>>> From: Zhao Yakui <yakui.zhao@intel.com>
> >>>>>           
> >>>> Thanks. Queued for test. How urgent is this? Do we need to consider it
> >>>> for .27?
> >>>>
> >>>> -Andi
> >>>>         
> >>> It will be great if you can put this in .27.
> >>>
> >>> --joshua
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> >>>       
> >> in
> >>     
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>       
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>     
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >   
> 

