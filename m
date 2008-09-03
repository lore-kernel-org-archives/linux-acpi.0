From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: a problem about the two patches in bug 10724 & 11428
Date: Wed, 03 Sep 2008 16:03:50 +0800
Message-ID: <1220429030.4007.22.camel@yakui_zhao.sh.intel.com>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com>
	 <20080901122158.GB21970@khazad-dum.debian.net> <48BC522D.60905@suse.de>
	 <48BC57C9.2040409@suse.de>
	 <1220421722.4007.4.camel@yakui_zhao.sh.intel.com>  <48BE32AF.0@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26139 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbYICHt4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Sep 2008 03:49:56 -0400
In-Reply-To: <48BE32AF.0@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Wed, 2008-09-03 at 10:46 +0400, Alexey Starikovskiy wrote:
> Zhao Yakui wrote:
> > On Tue, 2008-09-02 at 00:59 +0400, Alexey Starikovskiy wrote:
> >> Alexey Starikovskiy wrote:
> > Hi, Alexey
> >     In this patch after the EC timeout happens, the EC_FLAGS_GPE_MODE of
> > ec->flags will be clear and EC_FLAGS_NO_GPE bit will be set. But the EC
> > GPE won't be disabled again. Right?
> Right
> >     In such case when  EC is accessed, EC will work in polling mode. At
> > the same time EC interrupt still can be triggered. But the
> > EC_FLAGS_GPE_MODE can't be set again. Right?
> Almost. EC by itself (hardware device) still will be working in its 
> "optimized gpe mode" as before, but EC driver (software) will be working in poll mode.
> Regards,
If EC always works in such mode, it seems that we can make EC work more
simply. 
If so, a lot of source code in EC will be useless and we can do a
cleanup. After this, the EC driver will be easier to understand. When
new problems appears, we can easily identify the root cause.

Thanks.
   Yakui



> Alex.
> > 
> > Thanks
> >     Yakui.
> >               
> >>> Henrique de Moraes Holschuh wrote:
> >>>> On Mon, 01 Sep 2008, Zhao Yakui wrote:
> >>>>>     Will the above two patches hit the upstream kernel? If the above 
> >>>>> two patches hits the upstream kernel, it seems that the boot option 
> >>>>> of "ec_intr=" comes back again and EC can't be switched from 
> >>>>> interrupt mode to polling mode if EC GPE interrupt is missing. In 
> >>>>> such case maybe the battery/AC/thermal driver can't work well if the 
> >>>>> info of
> >>>>> battery/AC/thermal is related with EC. Maybe there exists the 
> >>>>> regression on some laptops.
> >>>> Right now, the fact that it gives up on interrupt mode too easily IS 
> >>>> causing
> >>>> regressions on ThinkPads (like the T43 I own).  Since polling mode does
> >>>> work, it is just a performance regression, so you won't get many reports
> >>>> about it since most people don't look for such stuff in their kernel 
> >>>> logs.
> >>>>
> >>>> Some ECs trigger the interrupt/poll-mode checks just on small windows
> >>>> (typically during resume -- might even be a bug somewhere in ACPICA or
> >>>> Linux, and not on the EC).  We should not be giving up using interrupt 
> >>>> mode
> >>>> on these so easily.  Maybe retry enabling interrupt mode after some 
> >>>> seconds
> >>>> a few times (like 3 or 5)?  If it is a transient problem, that will avoid
> >>>> the permanent performance regression of polled mode.
> >>>>
> >>> How about such patch?
> >> Or even better (working?) patch ...
> >>> Regards,
> >>> Alex.
> >>>
> > 
> 

