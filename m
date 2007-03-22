From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 3/8] [-mm] ACPI: add ACPI Fan sysfs interface
Date: Thu, 22 Mar 2007 14:02:15 +0800
Message-ID: <1174543335.8833.147.camel@localhost.localdomain>
References: <1174382484.8833.82.camel@localhost.localdomain>
	 <200703220047.51688.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6836 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965817AbXCVGCz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Mar 2007 02:02:55 -0400
In-Reply-To: <200703220047.51688.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>

On Thu, 2007-03-22 at 00:47 -0400, Len Brown wrote:
> On Tuesday 20 March 2007 05:21, Zhang Rui wrote:
> > From: Zhang Rui <rui.zhang@intel.com>
> > 
> > Add ACPI Fan device sysfs interface.
> > 
> > Attribute	Mode	Description
> > state		RW	Fan state.
> > 			0: Fan is in D0 state(on).
> > 			3: Fan is in D3 state(off).
> 
> I hate the current /proc/acpi/fan/*/interface,
> and don't think we should carry it forward into sysfs.
> 
As a ACPI control method fan, the value of "state" indicates which D
state the fan is currently in or we want to set it to.
As only D0 and D3 states are available for most of the devices, D0 is
recognised as "on" while D3 is "off".
> Forced to propose an alternative, I'd say:
> 
> 0: off
> 1: on-lowest speed
> 2: on-next faster speed
> 3: on-next faster speed
> ...
> n: maximum speed
> 
> Where n may be device dependent -- probably exported in an additional file.
> 
> So the state file would show the number, not the words on/off
> (because, echo "on" and "off" into the file has no effect,
>  which is the confusing mess we have today)
> 
> Note that for some systems, the different fan speeds are actually
> exported as multiple fan devices, each with a simple on/off.
> 
We don't have any ACPI methods to export this kind of information(exact
fan speed) for ACPI control method fan. All these different state/speed
are mapped into multiple ACPI fan devices with different D-state.

I agree that it would be better to use a more generic interface.
As you can see here:
http://marc.info/?l=linux-acpi&m=117267338700447&w=2

I'd say hwmon style sysfs interface for ACPI fan and thermal zone
devices is a good choice which we have discussed in the mail list about
two weeks ago. :)

Thanks,
Rui
