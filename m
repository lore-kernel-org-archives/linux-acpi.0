From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: a problem about the two patches in bug 10724 & 11428
Date: Tue, 02 Sep 2008 09:03:07 +0800
Message-ID: <1220317387.4039.83.camel@yakui_zhao.sh.intel.com>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com>
	 <20080901122158.GB21970@khazad-dum.debian.net> <48BC522D.60905@suse.de>
	 <48BC57C9.2040409@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13065 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545AbYIBAtQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Sep 2008 20:49:16 -0400
In-Reply-To: <48BC57C9.2040409@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Tue, 2008-09-02 at 00:59 +0400, Alexey Starikovskiy wrote:
> Alexey Starikovskiy wrote:
In this patch when timeout happens, EC will try the GPE interrupt mode
after 5 seconds.Of course EC will be in polling mode before switching to
GPE interrupt mode. It seems reasonable. 
In fact there also exists the mode switch from polling mode to interrupt
mode after EC is initialized. Is it more appropriate that ec->gpe_retry
is initialized?
Thanks.
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
> > 
> > Regards,
> > Alex.
> > 
> 

