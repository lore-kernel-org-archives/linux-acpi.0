From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: Automatic S1 sleep
Date: Tue, 11 May 2010 16:19:05 -0400
Message-ID: <4BE9BBB9.6030008@cfl.rr.com>
References: <4BE97FC9.4040302@cfl.rr.com> <20100511171900.GA17704@srcf.ucam.org> <4BE99F59.1010100@cfl.rr.com> <20100511182129.GA19264@srcf.ucam.org> <4BE9A54D.2060500@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from exhub016-2.exch016.msoutlookonline.net ([207.5.72.164]:43275
	"EHLO EXHUB016-2.exch016.msoutlookonline.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753115Ab0EKUTK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 May 2010 16:19:10 -0400
In-Reply-To: <4BE9A54D.2060500@cfl.rr.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

On 5/11/2010 2:43 PM, Phillip Susi wrote:
> How does the PCI core get called when changing state?  I would think it
> would be when suspend_devices_and_enter() calls
> dpm_suspend_start(PMESG_SUSPEND) but that does not differentiate between
> S1 and S3, so I would think that currently it would result in placing
> the device in D3, and that if I remove the PMESG_SUSPEND for
> PM_SUSPEND_STANDBY that it would result in leaving devices in D0.

The more I have looked at it the more I think that D1 is NOT used the
way Documentation/power/states.txt says.  It looks to me that the way it
works now is that the PM_EVENT_SUSPEND message is sent to the drivers by
dpm_suspend_start(), and it is up to each individual driver to call
pci_set_power_state() passing it the value returned by
pci_choose_state().  This ends up calling acpi_pci_choose_state() which
calls acpi_pm_device_sleep_state() which consults the ACPI tables to
find out the highest D state the device can wake the system in, if the
device is set to wake up the system.  Otherwise it just returns D3.

In the case of the video card, it is not and can not be set to wakeup
the system, so it should end up using D3.

If suspend_devices_and_enter() is modified NOT to call
dpm_suspend_start(PMESG_SUSPEND) for PM_SUSPEND_STANDBY, then the
drivers would never call into the pci core to set the power state of the
device, so they would remain in D0.

So it seems that what is needed is a PMESG_SUSPEND_STANDBY to cause the
drivers to call pci_set_power_state() and acpi_choose_state() needs
modified to either use D1 if the device supports it, or D0 otherwise
when switching to S1.

Either that or have suspend_devices_and_enter() skip the PMESG_SUSPEND
and instead call into the pci core to walk all devices on the bus and
set them to D1 if they support it without the knowledge of the
controlling driver.
