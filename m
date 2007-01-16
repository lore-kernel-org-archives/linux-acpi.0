From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: PROBLEM: CPU fan shuts down on load of fan.ko in kernel 2.6.18 and later
Date: Tue, 16 Jan 2007 09:54:25 -0700
Message-ID: <200701160954.26018.bjorn.helgaas@hp.com>
References: <E3C0BCA40296C347AF7142161DB9FC8298F74B@mssmsx411>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:57758 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582AbXAPQyf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jan 2007 11:54:35 -0500
In-Reply-To: <E3C0BCA40296C347AF7142161DB9FC8298F74B@mssmsx411>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Matthew Brett <matthew.brett@gmail.com>, Salatiel Filho <salatiel.filho@gmail.com>, linux-acpi@vger.kernel.org

On Monday 15 January 2007 06:33, Karasyov, Konstantin A wrote:
> The fan device FAN1 defines object FN01 as its power resource. _STA
> method of FN01 always return 0x01, i.e. resource is on. So the fan
> driver is unable to turn the fan on, because it thinks that it is
> already in that state.

The code looks like this:

    int acpi_bus_set_power(acpi_handle handle, int state)
    {
	...
	if (!device->flags.force_power_state) {
		if (device->power.state == ACPI_STATE_UNKNOWN)
			acpi_bus_get_power(device->handle, &device->power.state)
		if (state == device->power.state) {
			return 0;	/* already at desired state */
	}
	...
	acpi_power_transition(device, state);

Why do we bother with the "acpi_bus_get_power" at all?  The problem
Matthew is seeing wouldn't happen at all if we just deleted everything
in the force_power_state block.

Then we could execute _ON, _PS0, etc for a device that is already on.
Does that cause bad things to happen?  I assume the fan probably works
as desired under Windows, so they probably do something like this.

Bjorn

