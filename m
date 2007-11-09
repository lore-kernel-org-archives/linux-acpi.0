From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.24-rc1: OOPS at  acpi_battery_update
Date: Thu, 8 Nov 2007 20:34:51 -0800
Message-ID: <20071108203451.1b7f28c0.akpm@linux-foundation.org>
References: <1193652664.22149.4.camel@localhost>
	<200711050118.34610.rjw@sisk.pl>
	<20071108155344.GA12231@cataract>
	<200711081717.00421.rjw@sisk.pl>
	<47333ACB.6070408@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47349 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753190AbXKIEfg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Nov 2007 23:35:36 -0500
In-Reply-To: <47333ACB.6070408@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: rjw@sisk.pl, hannes-kernel@saeurebad.de, listen@selfservix.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

A> On Thu, 08 Nov 2007 19:35:23 +0300 Alexey Starikovskiy <astarikovskiy@suse.de> wrote:
> [remove_cycle_at_battery_removal.patch  text/x-patch (1.7KB)]
> ACPI: Battery: remove cycle from battery removal.
> 
> From: Alexey Starikovskiy <astarikovskiy@suse.de>
> 
> get_property() should not call battery_update() on absent battery to
> avoid cycle and oops.
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> Tested-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

A patch similar to this one but with an identical changelog was merged into
Len's tree on November 2.

If it had been promptly merged into mainline then quite a lot of people's
time would not have been wasted.

