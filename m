From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: a problem about the two patches in bug 10724 & 11428
Date: Tue, 02 Sep 2008 17:31:04 +0800
Message-ID: <1220347864.4039.189.camel@yakui_zhao.sh.intel.com>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com>
	 <48BB9E86.7070503@suse.de>
	 <1220320791.4039.128.camel@yakui_zhao.sh.intel.com>
	 <48BCFB18.60706@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39619 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274AbYIBJRL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Sep 2008 05:17:11 -0400
In-Reply-To: <48BCFB18.60706@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

On Tue, 2008-09-02 at 12:36 +0400, Alexey Starikovskiy wrote:
> Zhao Yakui wrote:
> > Maybe I don't understand what you said fully. The following is my
> > understanding about the patches of bug 11428 and bug 10724.
> > 
> > a. In the patch of bug 11428 the EC GPE won't be disabled when timeout
> > happens, which means that it is still possible to switch EC working mode
> > again from polling mode to interrupt mode. i.e. EC can still be switched
> > to interrupt mode again. In the current upstream kernel when timeout
> > happens, EC will be switched to polling mode and can't be switched to
> > interrupt mode again(EC GPE is disabled). Right?
> Wrong. EC GPE will stay enabled, driver will just not use it during wait for completion.
In current upstream kernel when EC timeout happens, EC will be switched
to polling mode by calling the function of ec_switch_to_poll, in which
EC GPE is disabled. Right?
   >ec_switch_to_poll_mode(struct acpi_ec *ec)
{
        set_bit(EC_FLAGS_NO_GPE, &ec->flags);
        clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
        acpi_disable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
        set_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags);
}

If the patch in bug 11428 hits the upstream kernel, EC will be switched
to polling mode when EC timeout happens. But EC GPE is still enabled and
it can be switched to EC GPE interrupt mode. 
   At the same time there is a little error in the patch of bug 10428.
   When EC timeout happens, the EC_FLAGS_NO_GPE bit of ec->flags is set
and the EC_FLAGS_GPE_MODE is clear. When EC GPE interrupt is triggered,
the EC_FLAGS_GPE_MODE bit can't be set again.
   
> 
> >     In fact when EC timeout happens in interrupt mode, it indicates that
> > EC controller can't return response in time.
> Wrong. Some EC controllers are "optimized" to not send interrupts for each confirmation.
> See history of EC patches for these optimization workarounds.
Maybe what you said is right. But in fact as is defined in ACPI spec, EC
controller should issue an interrupt according to the status of IBF and
OBF.  More detailed info about EC interrupt model can be found in the
section 12.6.2 of ACPI 3.0b spec.
If some EC controller are "optimized" to not send interrupts, is it
appropriate to reject such bugs?

In fact in the bug 11428 when EC real timeout happens in case of GPE
interrupt mode, the EC status is already what we expected. But no EC GPE
interrupt is triggered. 
More detailed info can be found in the log of bug 11428, comment
#16.    
> 
> >    In the above source code maybe there exists the following phenomenon:
> >      When the EC GPE interrupt is triggered, the waiting process will be
> >      waked up in the GPE interrupt service routine. But as the process
> >      can't be scheduled immediately, maybe the wait_event_timeout will
> >      also return 0, which means that timeout happens and EC will be
> >      switched from interrupt mode to polling mode.
> We are speaking about 500msec timeout here. it needs at least 50+ ready to run tasks of same
> kernel priority to not let queue thread run. Please tell me, how could this happen?
Please refer to the bug 11141.
In the bug 11141 the laptop works in polling mode. When timeout happens,
the EC status is already what OS expected. 
>[  762.152173] ACPI: EC: acpi_ec_wait timeout, status = 0x01, event =
"b0=1"
>[  762.152173] ACPI: EC: read timeout, command = 128
>[  766.444613] ACPI Exception (evregion-0419): AE_TIME, Returned by
Handler for [EmbeddedControl] [20080609]

In fact this is related with the mechanism of Linux schedule. When a
process is waked, it will be added to running queue but it can't be
scheduled immediately. Maybe before it has an opportunity to be
scheduled, the timeout already happens.
> 

