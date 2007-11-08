From: Johannes Weiner <hannes@saeurebad.de>
Subject: Re: 2.6.24-rc1: OOPS at  acpi_battery_update
Date: Thu, 8 Nov 2007 17:46:06 +0100
Message-ID: <20071108164606.GB12231@cataract>
References: <1193652664.22149.4.camel@localhost> <200711050118.34610.rjw@sisk.pl> <20071108155344.GA12231@cataract> <200711081717.00421.rjw@sisk.pl> <47333549.90505@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from saeurebad.de ([85.214.36.134]:38521 "EHLO saeurebad.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760289AbXKHQr3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Nov 2007 11:47:29 -0500
Content-Disposition: inline
In-Reply-To: <47333549.90505@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Johannes Weiner <hannes-kernel@saeurebad.de>, "Michael (rabenkind) Brandstetter" <listen@selfservix.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hi,

On Thu, Nov 08, 2007 at 07:11:53PM +0300, Alexey Starikovskiy wrote:
> Rafael J. Wysocki wrote:
> >On Thursday, 8 of November 2007, Johannes Weiner wrote:
> >>Hi,
> >>
> >>is there any reason, why acpi_battery_get_property() should call
> >>acpi_battery_update() at all?
> >
> >Alex?
> If someone wants to read stale values, he could comment out 
> acpi_battery_update.

Please help me to understand:

When the battery is plugged in, the acpi_battery_notify() is called,
which in turn calls acpi_battery_update(). The latter ensures that the
sysfs files are created if not yet present.

When the battery is removed, acpi_battery_notify is called, which in
turn calls acpi_battery_update(). The latter ensures that the sysfs
files are removed if present.

During runtime - as far as I understood - no sysfs files have to be
created/removed but the saved battery state info becomes stale.

So, would it be enough to call acpi_battery_get_state() in
acpi_battery_get_property() instead of acpi_battery_update()?

If acpi_battery_get_state() does what I think it does, this would
ensure that the battery state is reread and updated when
acpi_battery_get_property() is called.

Hit me.

	Hannes
