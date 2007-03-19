From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] CONFIG_IBM_BAY
Date: Mon, 19 Mar 2007 20:11:19 -0300
Message-ID: <20070319231119.GB5932@khazad-dum.debian.net>
References: <20070315110156.09e80b99.kristen.c.accardi@intel.com> <20070315193123.GB14394@khazad-dum.debian.net> <20070315125037.3e82e0c4.kristen.c.accardi@intel.com> <45FCD062.3050001@gmail.com> <20070318082751.GA28591@homac2> <20070319132243.GA2869@srcf.ucam.org> <20070319134822.GA4885@homac2.suse.de> <20070319140403.GA3697@srcf.ucam.org> <20070319143746.GC4885@homac2.suse.de> <20070319111109.1a62740b.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:39266 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965417AbXCSXL1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Mar 2007 19:11:27 -0400
Content-Disposition: inline
In-Reply-To: <20070319111109.1a62740b.kristen.c.accardi@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Holger Macht <hmacht@suse.de>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Len Brown <lenb@kernel.org>

On Mon, 19 Mar 2007, Kristen Carlson Accardi wrote:
> On Mon, 19 Mar 2007 15:37:46 +0100
> Holger Macht <hmacht@suse.de> wrote:
> > Sure. What actually bothers me is that in its current state, the dock
> > station driver signals 'green' on the dock station as soon as the user
> > presses the hardware undock button, but regardlessly of anything else. I
> > think it would be ok to let the ACPI undock event up to userspace because
> > in many situations it knows best when it is save to undock.
> 
> I disagree - as I mentioned, not all laptops actually let you (userspace)
> control the undock process because they don't lock.  The dock driver
> does notify user space of an undock, before it actually undocks:
> 
>         /*
>          * here we need to generate the undock
>          * event prior to actually doing the undock
>          * so that the device struct still exists.
>          */
>         dock_event(ds, event, UNDOCK_EVENT);
>         hotplug_dock_devices(ds, ACPI_NOTIFY_EJECT_REQUEST);
>         undock(ds);
>         eject_dock(ds);
>  
> 
> We even notify other subsystems of our intent to undock prior to actually
> doing it.

The above does not support two-stage-capable (i.e. non-braindamaged)
hardware docks properly.  While a two-stage (notify always, but undock only
if userspace (or another kernel module) tells you to) can support both
two-stage and broken-as-designed single-stage docks.

You can either let a machine-specific module (e.g. ibm-acpi) generate the
"undock immediately" functionality if the machine has a single-stage dock,
or let userspace do it, or even use black/whitelists on the dock module if
you want... but please give us the two-stage undock support.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
