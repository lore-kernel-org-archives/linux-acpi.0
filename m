From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OLPC rtc-cmos support
Date: Sat, 7 Jul 2007 22:13:40 -0700
Message-ID: <200707072213.41028.david-b@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com> <20070402165511.GD5024@cosmic.amd.com> <20070708035504.GC19633@dmt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:37734 "HELO
	smtp110.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751339AbXGHF0y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Jul 2007 01:26:54 -0400
In-Reply-To: <20070708035504.GC19633@dmt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: Jordan Crouse <jordan.crouse@amd.com>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, devel@laptop.org

On Saturday 07 July 2007, Marcelo Tosatti wrote:
> 
> Hi,
> 
> The following patch implements the hooks necessary for OLPC to use the
> rtc-cmos driver. This is necessary since we do not want CONFIG_PNP.
> 
> This makes it possible to control rtc wakeup via
> /sys/devices/platform/rtc_cmos/power/wakeup.
> 
> Comments?

Looks almost right ... though I'd have expected the RTC to
support alarms more than just 24 hours into the future!

It's more complicated than necessary.  It'd be much simpler
to just declare a static platform_device with pre-initted
platform_data.  Then call device_init_wakeup() on that before
calling the usual platform_device_register() routine.

That way you wouldn't need to have two different init sections
just to set up one device, where one of them is spending most
of its time working around the possibility that the other one
failed.  And you'd also pretty much eliminate the possibility
that the (now) single init section fails.  :)

- Dave
