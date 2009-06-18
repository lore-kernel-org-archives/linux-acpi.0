From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 1/2] ACPICA: Clear power button status before enabling event
Date: Thu, 18 Jun 2009 12:05:34 -0600
Message-ID: <200906181205.35243.bjorn.helgaas@hp.com>
References: <20090615164907.10901.73210.stgit@bob.kio> <200906172138.04877.bjorn.helgaas@hp.com> <1245308421.7697.73.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:33193 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883AbZFRSGD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jun 2009 14:06:03 -0400
In-Reply-To: <1245308421.7697.73.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

On Thursday 18 June 2009 01:00:21 am yakui_zhao wrote:
> On Thu, 2009-06-18 at 11:38 +0800, Bjorn Helgaas wrote:
> > On Wednesday 17 June 2009 8:14:26 pm yakui_zhao wrote:
> > > Maybe the BIOS will set the power button event enable/status bit. And
> > > after the interrupt is enabled, the power button event will hit the
> > > userland. So it is appropriate to clear the power button event as early
> > > as possible.
> > 
> > OK, I think I see now.  I didn't think through the "should not reach
> > userspace" language.  I think we just want to clear the event so we
> > don't take another interrupt when we re-enable interrupts near the
> > end of acpi_suspend_enter().

> What you said is partially right.
>    The power button wakeup event had better not hit the userland. If the
> acpid receives the power button wakeup event, then the system will be
> shutdown. This is not what we wanted.
>    So it will be better that the power button event is cleared as early
> as possible(At least it is cleared before the interrupt is re-enabled).

I don't like to think about this in terms like "as early as
possible" because that doesn't help us figure out where the
clearing needs to happen for correct system behavior.  "Before
interrupts are re-enabled" does help us analyze correctness.

It's true that there is a window of time where button presses
will be ignored, and moving the clear earlier does reduce the
size of that window.  But the window is tiny compared to the
time it takes a human to press a button, so I don't think this
is very important.

> > And I still don't understand the ACPI_STATE_S3 test around the
> > power button event clear.  Do you think that's necessary?

> For the S3 test it is necessary to clear the power button event before
> the interrupt is re-enabled.

My question is, can we clear the power button event when resuming
from any kind of suspend?  If not, what is special about ACPI_STATE_S3
that means we should clear the event for S3, but not for other states?

Maybe I should have started by simply suggesting the removal of the
clear in acpi_leave_sleep_state().  Does that serve some purpose?
It looks useless to me.  Normally we would clear the event in the
interrupt path (in acpi_ev_fixed_event_dispatch()), and I would think
that would be enough.

Bjorn
