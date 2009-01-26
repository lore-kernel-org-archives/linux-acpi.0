From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [patch] ACPI battery driver emits POWER_SUPPLY_STATUS_FULL
 when power lead plugged in
Date: Mon, 26 Jan 2009 08:43:19 +0000
Message-ID: <1232959399.4081.3.camel@hughsie-work.lan>
References: <1232729843.3504.6.camel@hughsie-work.lan>
	 <497A13C0.5020604@suse.de> <20090123220243.GB26701@khazad-dum.debian.net>
	 <1232753981.3504.10.camel@hughsie-work.lan> <497A5D49.6070706@suse.de>
	 <20090124124158.GC5325@khazad-dum.debian.net> <497B43D3.80703@suse.de>
	 <1232879297.3518.26.camel@hughsie-work.lan>
	 <20090125134203.GA12776@khazad-dum.debian.net>
	 <1232896408.3990.5.camel@hughsie-work.lan>  <497CC272.8050607@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:45036 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbZAZIoA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Jan 2009 03:44:00 -0500
Received: by ug-out-1314.google.com with SMTP id 39so113280ugf.37
        for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2009 00:43:58 -0800 (PST)
In-Reply-To: <497CC272.8050607@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi <linux-acpi@vger.kernel.org>, mjg <mjg@redhat.com>, Matthias Clasen <mclasen@redhat.com>

On Sun, 2009-01-25 at 22:50 +0300, Alexey Starikovskiy wrote:
>  >                       val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
> This last else should return STATUS_NOT_CHARGING, IMHO. We know this
> little bit about it.

I don't think so; I mean it just as well means STATUS_NOT_DISCHARGING.
We don't actually know what the battery is doing internally, hence the
UNKNOWN.

Richard.


