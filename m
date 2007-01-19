From: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>
Subject: RE: PROBLEM: CPU fan shuts down on load of fan.ko in kernel 2.6.18 and later
Date: Fri, 19 Jan 2007 15:37:19 +0300
Message-ID: <E3C0BCA40296C347AF7142161DB9FC829CA37A@mssmsx411>
References: <200701160954.26018.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:22941 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965098AbXASMhY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jan 2007 07:37:24 -0500
Content-class: urn:content-classes:message
In-Reply-To: <200701160954.26018.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Matthew Brett <matthew.brett@gmail.com>, Salatiel Filho <salatiel.filho@gmail.com>, linux-acpi@vger.kernel.org

>Why do we bother with the "acpi_bus_get_power" at all?  The problem
>Matthew is seeing wouldn't happen at all if we just deleted everything
>in the force_power_state block.
>
>Then we could execute _ON, _PS0, etc for a device that is already on.
>Does that cause bad things to happen?  I assume the fan probably works
>as desired under Windows, so they probably do something like this.

This would work for _PSx (if device power states are controlled via _PSx
methods, we should only execute method, defined for desired power
state), but if power states are controlled via power resources, we
should execute _ON method of power resource, assigned for desired state
AND _OFF method of power resource, assigned for the current power state,
so we cannot just ignore the current device power state.


Regards.
Konstantin.

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Bjorn Helgaas
>Sent: Tuesday, January 16, 2007 7:54 PM
>To: Karasyov, Konstantin A
>Cc: Alexey Starikovskiy; Matthew Brett; Salatiel Filho; linux-
>acpi@vger.kernel.org
>Subject: Re: PROBLEM: CPU fan shuts down on load of fan.ko in kernel
2.6.18
>and later
>
>On Monday 15 January 2007 06:33, Karasyov, Konstantin A wrote:
>> The fan device FAN1 defines object FN01 as its power resource. _STA
>> method of FN01 always return 0x01, i.e. resource is on. So the fan
>> driver is unable to turn the fan on, because it thinks that it is
>> already in that state.
>
>The code looks like this:
>
>    int acpi_bus_set_power(acpi_handle handle, int state)
>    {
>	...
>	if (!device->flags.force_power_state) {
>		if (device->power.state == ACPI_STATE_UNKNOWN)
>			acpi_bus_get_power(device->handle,
&device->power.state)
>		if (state == device->power.state) {
>			return 0;	/* already at desired state */
>	}
>	...
>	acpi_power_transition(device, state);
>
>Why do we bother with the "acpi_bus_get_power" at all?  The problem
>Matthew is seeing wouldn't happen at all if we just deleted everything
>in the force_power_state block.
>
>Then we could execute _ON, _PS0, etc for a device that is already on.
>Does that cause bad things to happen?  I assume the fan probably works
>as desired under Windows, so they probably do something like this.
>
>Bjorn
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
