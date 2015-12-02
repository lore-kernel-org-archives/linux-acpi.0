From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: ACPI device without physical node (pnpacpi oddity?)
Date: Wed, 02 Dec 2015 13:25 +0100
Message-ID: <5754530.CdtynUQlbJ@vostro.rjw.lan>
References: <CALCETrXcJN-nKLVzuWj_pbqwO+g0i1sfg2vCr=Y6_Gn_7XT=gw@mail.gmail.com> <1449021653.22321.6.camel@rzhang1-mobl4> <CALCETrV6F=FcXaoDGeb=x+ebSzopR3ib5PsK2Ckupr6z+80+aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44954 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757229AbbLBLzK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2015 06:55:10 -0500
In-Reply-To: <CALCETrV6F=FcXaoDGeb=x+ebSzopR3ib5PsK2Ckupr6z+80+aQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>

On Tuesday, December 01, 2015 06:03:31 PM Andy Lutomirski wrote:
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

It does, but then we'll create a PNP device which isn't going to be handled
by a platform driver.

So (as I said before) we need to ensure that we'll consistently create the
same type of a device for the given device ID every time we see it.

Thanks,
Rafael

