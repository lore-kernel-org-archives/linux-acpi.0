From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [patch 2.6.25-rc6 3/7] pci_choose_state() cleanup and fixes
Date: Fri, 21 Mar 2008 01:15:03 -0700
Message-ID: <200803210115.04210.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0803202053270.11234-100000@netrider.rowland.org> <200803210247.18686.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:20792 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752090AbYCUIP3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Mar 2008 04:15:29 -0400
In-Reply-To: <200803210247.18686.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org

On Thursday 20 March 2008, Rafael J. Wysocki wrote:
> Is there any reason why pci_choose_state() should try to figure out w=
hat kind
> of operation is being performed by the driver and tailor its output t=
o that?

It's always been specified to do that ... but it's always done
that in a buggy way.  (Which is why USB never used it.)


> I don't think so. =A0Rather, the driver should know what it's doing a=
nd either
> call pci_choose_state() or not. =A0If the state of the device is not =
to be
> changed, there's no reason to call pci_choose_state() at all.

You seem to object to letting drivers offload this particular
bit of work to infrastructure.  What's the dividing line between
being OK to offload vs not eing OK?  Why not let the drivers make
that choice?


> 	[Note that with the new suspend/hibernation callbacks there
> won't be the pm_message_t argument to pass to pci_choose_state().]

The pm_message_t will necessarily linger until all drivers have
been converted and re-tested.  Which can't be an overnight thing.


> Now, we need to settle _what_ exactly pci_choose_state() is supposed
> to return, because it's not clear right now.

Kerneldoc says:

 * Returns PCI power state suitable for given device and given system
 * power state transition.

Some comments added by $SUBJECT also clarify:

                /* NOTE:  platform_pci_choose_state() should only retur=
n
                 * states where wakeup won't work if
                 *   - !device_may_wakeup(&dev->dev), or
                 *   - dev can't wake from the target system state
                 */

That happens to be what acpi_pm_device_sleep_state() computes;
there may not be other implementations of that call, yet.  I can
imagine a default that would look at PCI PM capabilities, to be
used on non-ACPI platforms.


>	 Should that be the lowest power=20
> state in which the device can be in given system state (that's what
> platform_pci_choose_state() will return)?

Actually the comment above is the *entirety* of the docs for
that call:  it chooses a state.  You're asking a question of
policy (how/why it chooses); that's outside the scope of PCI.


> Or should that be the highest power=20
> state in which the device can be in given system state?
> Or anything else?=20

It happens that the current Linux ACPI glue chooses the
lowest power PCI state that's compatible with the target
system state ... optimizing for power savings rather than
for quick resumes.

It might make sense to support a policy that optimizes for
fast resumes from some states.  But I can't see that'd be
worth much effort at this point, with bigger fish to fry!

- Dave


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
