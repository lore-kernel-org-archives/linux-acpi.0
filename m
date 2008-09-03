From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: a problem about the two patches in bug 10724 & 11428
Date: Wed, 03 Sep 2008 16:34:16 +0800
Message-ID: <1220430856.4007.38.camel@yakui_zhao.sh.intel.com>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com>
	 <20080901122158.GB21970@khazad-dum.debian.net> <48BC522D.60905@suse.de>
	 <48BC57C9.2040409@suse.de>
	 <1220421722.4007.4.camel@yakui_zhao.sh.intel.com>  <48BE32AF.0@suse.de>
	 <1220429030.4007.22.camel@yakui_zhao.sh.intel.com>
	 <48BE427C.3070204@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56055 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170AbYICIUR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Sep 2008 04:20:17 -0400
In-Reply-To: <48BE427C.3070204@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Wed, 2008-09-03 at 11:53 +0400, Alexey Starikovskiy wrote:
> Zhao Yakui wrote:
> > On Wed, 2008-09-03 at 10:46 +0400, Alexey Starikovskiy wrote:
> >> Zhao Yakui wrote:
> >>> On Tue, 2008-09-02 at 00:59 +0400, Alexey Starikovskiy wrote:
> >>>> Alexey Starikovskiy wrote:
> >>> Hi, Alexey
> >>>     In this patch after the EC timeout happens, the EC_FLAGS_GPE_MODE of
> >>> ec->flags will be clear and EC_FLAGS_NO_GPE bit will be set. But the EC
> >>> GPE won't be disabled again. Right?
> >> Right
> >>>     In such case when  EC is accessed, EC will work in polling mode. At
> >>> the same time EC interrupt still can be triggered. But the
> >>> EC_FLAGS_GPE_MODE can't be set again. Right?
> >> Almost. EC by itself (hardware device) still will be working in its 
> >> "optimized gpe mode" as before, but EC driver (software) will be working in poll mode.
> >> Regards,
> > If EC always works in such mode, it seems that we can make EC work more
> > simply. 
> If you _disable_ EC GPE or not enable it in first place, EC(hardware) will be working in
> poll mode. So, there is no spare code to clean up, sorry. 
Not understand what you said.
After your three patches hit the upstream kernel, the EC GPE is still
enabled when EC timeout happens. In such case when EC is accessed, EC
will work in polling mode. At the same time EC GPE interrupt still can
be triggered. 
If so, maybe it is also reasonable that EC always works in such mode
after the ACPI EC driver is loaded fully.(ACPI EC device is bound with
the ACPI EC driver). 
    a. EC GPE interrupt can be triggered 
    b. When EC internal register is accessed, EC driver works in polling
mode.

If EC always works in above mode, the working flowchart in EC driver can
be simplified.
   a. The mode switch from polling mode to interrupt mode is useless
   b. Some flags are also useless. (For example:
WAIT_GPE/RESCHEDULE_POLL/FLAGS_NO_GPE)
   c. polling timer is useless
   d. In EC GPE interrupt handler we can only care the EC notification
event.(The SCI_EVT bit of EC status register).

   



> > If so, a lot of source code in EC will be useless and we can do a
> > cleanup. After this, the EC driver will be easier to understand. When
> > new problems appears, we can easily identify the root cause.
> > 
> > Thanks.
> >    Yakui

