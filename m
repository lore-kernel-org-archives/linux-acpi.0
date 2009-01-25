From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [patch] ACPI battery driver emits POWER_SUPPLY_STATUS_FULL when
 power lead plugged in
Date: Sun, 25 Jan 2009 22:50:10 +0300
Message-ID: <497CC272.8050607@suse.de>
References: <1232729843.3504.6.camel@hughsie-work.lan>	 <497A13C0.5020604@suse.de> <20090123220243.GB26701@khazad-dum.debian.net>	 <1232753981.3504.10.camel@hughsie-work.lan> <497A5D49.6070706@suse.de>	 <20090124124158.GC5325@khazad-dum.debian.net> <497B43D3.80703@suse.de>	 <1232879297.3518.26.camel@hughsie-work.lan>	 <20090125134203.GA12776@khazad-dum.debian.net> <1232896408.3990.5.camel@hughsie-work.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:41096 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751104AbZAYTty (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Jan 2009 14:49:54 -0500
In-Reply-To: <1232896408.3990.5.camel@hughsie-work.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi <linux-acpi@vger.kernel.org>, mjg <mjg@redhat.com>, Matthias Clasen <mclasen@redhat.com>

Richard Hughes wrote:
> On Sun, 2009-01-25 at 11:42 -0200, Henrique de Moraes Holschuh wrote:
>>  So, the above test will still break on any proper battery subsystem with the
>> high watermark set below 100%, as those systems update full_charge_capacity
>> *only* when the cells really are full (and not because the EC decided to
>> stop the charging before they were full).
> 
> This is what I observed when testing my patch.
> 
> The attached patch checks the last full and design charge, as this seems
> to work in all cases I have here. In the case of broken batteries or
> broken hardware, we just return UNKNOWN in this "settling" state, which
> is much better for userspace than falling back to full.
> 
> With the attached patch userspace gets the right states. In the future,
> maybe we can do some sort of metric over time (watching to see if the
> present charge changes) but for the most part the patch fixes things up
> for userspace.
> 		else
> 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
This last else should return STATUS_NOT_CHARGING, IMHO. We know this little bit about it.
> 
> Please review,
> 
> Richard.
> 
> 

