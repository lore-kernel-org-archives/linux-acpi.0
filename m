From: Thomas Renninger <trenn@suse.de>
Subject: Re: Kernel oops (2.6.24) while booting with battery inserted
Date: Thu, 27 Mar 2008 16:21:11 +0100
Message-ID: <1206631271.19236.86.camel@queen.suse.de>
References: <47EB37BA.3050707@gmail.com>
	 <1206630454.19236.79.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:59180 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753706AbYC0PVM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Mar 2008 11:21:12 -0400
In-Reply-To: <1206630454.19236.79.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sam Lin <itrs.lin@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Thu, 2008-03-27 at 16:07 +0100, Thomas Renninger wrote:
> On Thu, 2008-03-27 at 13:59 +0800, Sam Lin wrote:
> > Hi List,
> > 
> > I encountered kernel oops (Ubuntu 2.6.24-12) while booting with battery
> > inserted.
> > Some workaround are acpi=off, avoiding loading battery.ko or putting
> > battery away.
> > 
> > Any idea ?
> Why do you need:
> acpi_fake_ecdt
> parameter? This does not even exist (anymore? I searched 2.6.25).
> 
> > dmesg and dsdt as attachments.
> 
> I expect removing the line:
>         acpi_bus_generate_netlink_event(device->pnp.device_class,
>                                         device->dev.bus_id, event,
>                                         acpi_battery_present(battery));
> in battery.c makes the machine work or at least go a bit further?
> 
> Could it be that you compiled in ACPI modules and that:
> fs_initcall(acpi_event_init);
> in drivers/acpi/event.c
> has not been called and initialized the netlink acpi stuff, but battery
> has already tried to send an event?
acpi_event_init should have been called already...
I still think it has to do with the netlink event.
As it is rather early, maybe because of that.
Does it work for you if you load the battery module later?

Can you open a bugreport on bugzilla.kernel.org, add .config and
dmesg/acpidump you already sent and add me to CC.

Thanks,

   Thomas


