From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI / PM: Make acpi_pm_device_sleep_state() follow the specification
Date: Sat, 26 May 2012 22:21:11 +0200
Message-ID: <201205262221.11742.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1205252148190.20180-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:38842 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981Ab2EZUQJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 May 2012 16:16:09 -0400
In-Reply-To: <Pine.LNX.4.44L0.1205252148190.20180-100000@netrider.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Len Brown <lenb@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Lin Ming <ming.m.lin@intel.com>

On Saturday, May 26, 2012, Alan Stern wrote:
> On Sat, 26 May 2012, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > The comparison between the system sleep state being entered
> > and the lowest system sleep state the given device may wake up
> > from in acpi_pm_device_sleep_state() is reversed, because the
> > specification (ACPI 5.0) says that for wakeup to work:
> > 
> > "The sleeping state being entered must be less than or equal to the
> >  power state declared in element 1 of the _PRW object."
> 
> What does "less than or equal to" mean here?  Is D0 <= D1 because 0 <= 1?

Precisely.  This is a simple numeric comparison.

> (Or because D1 is a "higher sleep state" than D0?)  Or is D1 <= D0
> because the amount of power used in D1 is <= the amount of power used
> in D0?
> 
> > Moreover, it also should check if the wakeup capability is supported
> > through ACPI, because in principle it may be done via native PCIe
> > PME, for example.
> 
> Can you outline the overall algorithm used to select a PCI device's
> sleep state?  It's obvious that the inputs are the system's target
> state and whether or not wakeup should be enabled.  Beyond that, I do
> not have a clear idea of how the selection is made.

OK

pci_target_state() should return the state to put the device into.

It first checks if the device is power managed by ACPI.  If that's
the case, it calls acpi_pm_device_sleep_wake() which uses _SxD and _SxW
(if present) to find the highest (lowest-power) state to put the device into.
The algorithm used by it should be the following (modulo error handling):

  If _SxD is not present, use D0 as min.  Otherwise, use the value returned by
  _SxD as min.

  If _SxW is present, use the value returned by it as max.
  Otherwise:
  (a) if _SxD is present, use the value returned by it as max.
  (b) otherwise, use D3 as max.

  Return max as the target state.  Write min to the location pointed to by
  d_min_p (if not NULL).

  Note: Evaluate _SxW only if wakeup from the given system sleep state is supported.

It is not exactly this at the moment, unfortunately.

The value returned by acpi_pm_device_sleep_wake() is then checked agaist PCI
quirks and returned to the caller (D3hot is returned if there's a quirk
preventing us from using the value returned by ACPI).

If the device is not power managed by ACPI and it doesn't have the PM capability
in the config space, D0 is the target state.

Otherwise, if the device is supposed to wake up the system from the sleep state
being entered, we look up the deepest state supporting wakeup in its PM
capability (pme_support) field and return this one as the target state.

Otherwise, we return D3hot.

Below is the $subject patch with a slightly modified changelog.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: ACPI / PM: Make acpi_pm_device_sleep_state() follow the specification

The comparison between the system sleep state being entered
and the lowest system sleep state the given device may wake up
from in acpi_pm_device_sleep_state() is reversed, because the
specification (ACPI 5.0) says that for wakeup to work:

"The sleeping state being entered must be less than or equal to the
 power state declared in element 1 of the _PRW object."

In other words, the state returned by _PRW is the deepest
(lowest-power) system sleep state the device is capable of waking up
the system from.

Moreover, acpi_pm_device_sleep_state() also should check if the
wakeup capability is supported through ACPI, because in principle it
may be done via native PCIe PME, for example, in which case _SxW
should not be evaluated.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/drivers/acpi/sleep.c
===================================================================
--- linux.orig/drivers/acpi/sleep.c
+++ linux/drivers/acpi/sleep.c
@@ -732,8 +732,8 @@ int acpi_pm_device_sleep_state(struct de
 	 * can wake the system.  _S0W may be valid, too.
 	 */
 	if (acpi_target_sleep_state == ACPI_STATE_S0 ||
-	    (device_may_wakeup(dev) &&
-	     adev->wakeup.sleep_state <= acpi_target_sleep_state)) {
+	    (device_may_wakeup(dev) && adev->wakeup.flags.valid &&
+	     adev->wakeup.sleep_state >= acpi_target_sleep_state)) {
 		acpi_status status;
 
 		acpi_method[3] = 'W';
