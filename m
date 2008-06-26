From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH3/4] ACPI :  Add boot option of "idle=nomwait" to
	disable mwait for CPU C-states
Date: Thu, 26 Jun 2008 14:21:54 +0800
Message-ID: <1214461314.7055.45.camel@yakui_zhao.sh.intel.com>
References: <1213685035.19901.15.camel@yakui_zhao.sh.intel.com>
	 <alpine.LFD.1.10.0806200235260.22284@localhost.localdomain>
	 <alpine.LFD.1.10.0806200310160.22284@localhost.localdomain>
	 <1214202030.25786.77.camel@yakui_zhao.sh.intel.com>
	 <alpine.LFD.1.10.0806260003590.3279@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40313 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751513AbYFZGKz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jun 2008 02:10:55 -0400
In-Reply-To: <alpine.LFD.1.10.0806260003590.3279@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Thu, 2008-06-26 at 00:06 -0400, Len Brown wrote:
> 
> On Mon, 23 Jun 2008, Zhao Yakui wrote:
> 
> > On Fri, 2008-06-20 at 03:14 -0400, Len Brown wrote:
> > > 
> > > I notice on the T61 that this disables MWAIT for C2 and C3,
> > > but not for C1.
> > > 
> > > While I know that the issue at hand is C2 and C3,
> > > it seems misleading to boot with idle=nomwait
> > > and see that MWAIT is used for C1.
> 
> > What you said is correct. The description is not appropriate.Maybe the
> > following title will be appropriate.
> 
> >  >Add boot option of "idle=nomwait" to disable mwait for CPU C2/C3
> > 
> > The boot option of "idle=nomwait" will disable mwait for CPU C2/C3 and
> > still use mwait for C1 if mwait is supported. 
> > In fact we only hope to disable mwait for CPU C2/C3 on some broken
> > system by adding this boot option.
> 
> How can I tell the system with 3 C-states to use all 3,
> but not to use MWAIT for any of them?
In the update patch when the boot option of "idle=nomwait" is added, OS will disable mwait for all the CPU C-states.
In fact the original purpose of "idle=nomwait" is only to disable mwait
for C2/C3 states on the broken system(there should be no obvious
difference between halt and mwait for C1 state.). Now according to your
suggestion the option "idle=nomwait" will disable mwait for all the CPU
C-states.
> idle=halt will not do, since it will delete C2 and C3 completely.
As you said, "idle=halt" only allows OS to use halt for CPU idle. And in
the updated patch cpuidle driver will be loaded normally but C1 is the
upper power level and Halt is for C1.

Thanks.
> As I said, I think that "idle=nomwait" should do this.
> If we have a parameter that disables MWAIT only for C2 and C3,
> then it should not be called "idle=nomwait".
> 
> -Len
> 
> 

