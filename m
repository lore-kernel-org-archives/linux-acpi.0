From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [patch] ACPI battery driver emits POWER_SUPPLY_STATUS_FULL
	when power lead plugged in (resend)
Date: Fri, 30 Jan 2009 12:07:02 -0200
Message-ID: <20090130140702.GA14714@khazad-dum.debian.net>
References: <1232729843.3504.6.camel@hughsie-work.lan> <497A13C0.5020604@suse.de> <20090123220243.GB26701@khazad-dum.debian.net> <1232753981.3504.10.camel@hughsie-work.lan> <497A5D49.6070706@suse.de> <20090124124158.GC5325@khazad-dum.debian.net> <497B43D3.80703@suse.de> <1232879297.3518.26.camel@hughsie-work.lan> <20090125134203.GA12776@khazad-dum.debian.net> <1233148811.4231.0.camel@hughsie-work.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:40528 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752969AbZA3OHG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Jan 2009 09:07:06 -0500
Content-Disposition: inline
In-Reply-To: <1233148811.4231.0.camel@hughsie-work.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi <linux-acpi@vger.kernel.org>, mjg <mjg@redhat.com>, Matthias Clasen <mclasen@redhat.com>, Len Brown <lenb@kernel.org>

On Wed, 28 Jan 2009, Richard Hughes wrote:
> The attached patch checks the last full and design charge, as this seems
> to work in all cases I have here. In the case of broken batteries or
> broken hardware, we just return UNKNOWN in this "settling" state, which
> is much better for userspace than falling back to full.
> 
> With the attached patch userspace gets the right states. In the future,
> maybe we can do some sort of metric over time (watching to see if the
> present charge changes) but for the most part the patch fixes things up
> for userspace.

I am ok with this patch, but it does have *one* corner case.

Brand new good batteries will be reported as full while still charging, when
they're near 100% (they will be above the design capacity).

That isn't enough for me to complain about the patch, and the patch makes it
MUCH better than the current broken behaviour.

So you can have my Acked-by if you want it, for whatever little it is worth.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
