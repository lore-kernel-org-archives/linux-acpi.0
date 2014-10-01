From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 10/15] leds: leds-gpio: Add ACPI probing support
Date: Wed, 01 Oct 2014 20:22:36 +0200
Message-ID: <15084898.uePkciO2J1@wuerfel>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com> <20141001163025.GE23115@dtor-glaptop> <D05191AB.AB380%dvhart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:58428 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbaJASWt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Oct 2014 14:22:49 -0400
In-Reply-To: <D05191AB.AB380%dvhart@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Grant Likely <grant.likely@linaro.org>, Aaron Lu <aaron.lu@intel.com>

On Wednesday 01 October 2014 11:11:46 Darren Hart wrote:
> >
> >No, I think in absence of drv->acpi_match_table ACPI core should just go
> >and
> >use drv->of_match_table to do the matching and be done with it.
> 
> But then you will match drivers that have of-only support that don't know
> anything about ACPI and haven't been updated to use the new API. Worse,
> some of those drivers will assume of node structs and such and potentially
> panic. Unless I'm sorry mistaken here....
> 

I don't think that is a huge danger: most drivers tend to check for
the presence of dev->of_node before calling any of the DT interfaces,
you'd only ever enter the probe function if the compatible string matches
(i.e. an old kernel with a new ACPI table), and most users of ACPI
systems will disable CONFIG_OF at compile time, so the accessors looking
at the of_node are not there.

In theory it's possible that something goes wrong here, but it's not
very likely to ever cause problems.

	Arnd
