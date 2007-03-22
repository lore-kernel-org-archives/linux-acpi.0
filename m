From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 3/8] [-mm] ACPI: add ACPI Fan sysfs interface
Date: Thu, 22 Mar 2007 09:04:57 -0300
Message-ID: <20070322120457.GB26451@khazad-dum.debian.net>
References: <1174382484.8833.82.camel@localhost.localdomain> <200703220047.51688.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:39017 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934004AbXCVMFC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Mar 2007 08:05:02 -0400
Content-Disposition: inline
In-Reply-To: <200703220047.51688.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>

On Thu, 22 Mar 2007, Len Brown wrote:
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
> Forced to propose an alternative, I'd say:
> 
> 0: off
> 1: on-lowest speed
> 2: on-next faster speed
> 3: on-next faster speed
> ...
> n: maximum speed

Shouldn't we use the hwmon interface for fans as much as possible?

ibm-acpi, for example, managed to map 100% of its fan and thermal interfaces
to hwmon, with no loss of functionality.  I know this is not straightforward
at all for generic ACPI, but it is better to do 90% than 0%...

> Note that for some systems, the different fan speeds are actually
> exported as multiple fan devices, each with a simple on/off.

Yuck.  IMHO, the right thing to do, if such systems can be identified, would
be to abstract this back to just one fan with multiple speeds.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
