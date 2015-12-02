From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI device without physical node (pnpacpi oddity?)
Date: Wed, 02 Dec 2015 16:47:50 +0800
Message-ID: <1449046070.23098.5.camel@rzhang1-mobl4>
References: <CALCETrXcJN-nKLVzuWj_pbqwO+g0i1sfg2vCr=Y6_Gn_7XT=gw@mail.gmail.com>
	 <2355752.R19tF0KgU6@vostro.rjw.lan>
	 <CALCETrX24s2wzXs4bz4GH-XAi8COk2nKUkXYY2i81MV=r5H_PQ@mail.gmail.com>
	 <2306632.Ddb0M2gLJC@vostro.rjw.lan>
	 <1449021653.22321.6.camel@rzhang1-mobl4>
	 <CALCETrV6F=FcXaoDGeb=x+ebSzopR3ib5PsK2Ckupr6z+80+aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32565 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756878AbbLBIr7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Dec 2015 03:47:59 -0500
In-Reply-To: <CALCETrV6F=FcXaoDGeb=x+ebSzopR3ib5PsK2Ckupr6z+80+aQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>

On Tue, 2015-12-01 at 18:03 -0800, Andy Lutomirski wrote:
> On Tue, Dec 1, 2015 at 6:00 PM, Zhang Rui <rui.zhang@intel.com> wrote:
> > On Wed, 2015-12-02 at 01:48 +0100, Rafael J. Wysocki wrote:
> >> For your use case we could make the PNP layer ignore the pnp0c02 device id if
> >> (a) _CRS is missing and (b) pnp0c02 is in the _CID list (not a _HID).
> >>
> > Yes, this could work.
> > But I'm concerning another case, say, a device with both _CRS and _CID
> > "PNP0C02", we don't have a way to probe the device via _HID.
> 
> Doesn't .acpi_match_table do exactly this?
> 
I mean, even if _CRS is available, the device will be bound to the PNP
system driver (drivers/pnp/system.c) forever, thus you still cannot
write a new driver to probe INT33D5.

thanks,
rui


