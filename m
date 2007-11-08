From: Johannes Weiner <hannes-kernel@saeurebad.de>
Subject: Re: 2.6.24-rc1: OOPS at  acpi_battery_update
Date: Thu, 8 Nov 2007 17:58:59 +0100
Message-ID: <20071108165859.GC12231@cataract>
References: <1193652664.22149.4.camel@localhost> <200711050118.34610.rjw@sisk.pl> <20071108155344.GA12231@cataract> <200711081717.00421.rjw@sisk.pl> <47333ACB.6070408@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from saeurebad.de ([85.214.36.134]:38693 "EHLO saeurebad.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755186AbXKHRAW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Nov 2007 12:00:22 -0500
Content-Disposition: inline
In-Reply-To: <47333ACB.6070408@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Michael (rabenkind) Brandstetter" <listen@selfservix.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hi Alex,

On Thu, Nov 08, 2007 at 07:35:23PM +0300, Alexey Starikovskiy wrote:
> Rafael J. Wysocki wrote:
> >On Thursday, 8 of November 2007, Johannes Weiner wrote:
> >>Hi,
> >>
> >>is there any reason, why acpi_battery_get_property() should call
> >>acpi_battery_update() at all?
> >
> >Alex?
> Do you mean "why should it call _whole_ battery update?" ?
> get_state should be sufficient in order to not get stale data.

Okay, than I understood it correct.

Acked-by: Johannes Weiner <hannes@saeurebad.de>

Thanks!

	Hannes
