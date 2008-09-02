From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: a problem about the two patches in bug 10724 & 11428
Date: Tue, 02 Sep 2008 16:05:38 +0800
Message-ID: <1220342738.4039.157.camel@yakui_zhao.sh.intel.com>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com>
	 <20080901122158.GB21970@khazad-dum.debian.net> <48BC522D.60905@suse.de>
	 <48BC57C9.2040409@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1671 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751021AbYIBHvp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Sep 2008 03:51:45 -0400
In-Reply-To: <48BC57C9.2040409@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Tue, 2008-09-02 at 00:59 +0400, Alexey Starikovskiy wrote:
> Alexey Starikovskiy wrote:
> > Henrique de Moraes Holschuh wrote:
> >> On Mon, 01 Sep 2008, Zhao Yakui wrote:
> >>>     Will the above two patches hit the upstream kernel? If the above 
> >>> two patches hits the upstream kernel, it seems that the boot option 
> >>> of "ec_intr=" comes back again and EC can't be switched from 
> >>> interrupt mode to polling mode if EC GPE interrupt is missing. In 
> >>> such case maybe the battery/AC/thermal driver can't work well if the 
> >>> info of
> >>> battery/AC/thermal is related with EC. Maybe there exists the 
> >>> regression on some laptops.
> >>
> >> Right now, the fact that it gives up on interrupt mode too easily IS 
> >> causing
> >> regressions on ThinkPads (like the T43 I own).  Since polling mode does
> >> work, it is just a performance regression, so you won't get many reports
> >> about it since most people don't look for such stuff in their kernel 
> >> logs.
> >>
> >> Some ECs trigger the interrupt/poll-mode checks just on small windows
> >> (typically during resume -- might even be a bug somewhere in ACPICA or
> >> Linux, and not on the EC).  We should not be giving up using interrupt 
> >> mode
> >> on these so easily.  Maybe retry enabling interrupt mode after some 
> >> seconds
> >> a few times (like 3 or 5)?  If it is a transient problem, that will avoid
> >> the permanent performance regression of polled mode.
> >>
> > How about such patch?
> Or even better (working?) patch ...

The patch looks reasonable. But there is a little problem.
The EC_FLAGS_NO_GPE bit of ec->flags is set when timeout happens.(The EC_FLAGS_GPE_MODE bit is clear)
Maybe in such case the EC_FLAGS_GPE_MODE bit can't be set again when EC GPE interrupt is triggered again.

Thanks.
   Yakui

  
> > Regards,
> > Alex.
> > 
> 

