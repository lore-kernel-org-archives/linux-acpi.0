From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: ACPI device without physical node (pnpacpi oddity?)
Date: Tue, 1 Dec 2015 17:04:33 -0800
Message-ID: <CALCETrVMDHbazy8YqbdDkDLoVvgQOmJ2f57Wc5LZZKrF3X2Q0A@mail.gmail.com>
References: <CALCETrXcJN-nKLVzuWj_pbqwO+g0i1sfg2vCr=Y6_Gn_7XT=gw@mail.gmail.com>
 <CALCETrX24s2wzXs4bz4GH-XAi8COk2nKUkXYY2i81MV=r5H_PQ@mail.gmail.com>
 <744357E9AAD1214791ACBA4B0B9092633A91E855@SHSMSX101.ccr.corp.intel.com> <2125838.NE6T2gi0bX@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:36068 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbbLBBEx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Dec 2015 20:04:53 -0500
Received: by obcse5 with SMTP id se5so16838343obc.3
        for <linux-acpi@vger.kernel.org>; Tue, 01 Dec 2015 17:04:53 -0800 (PST)
In-Reply-To: <2125838.NE6T2gi0bX@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>

On Tue, Dec 1, 2015 at 5:18 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, December 01, 2015 03:25:41 AM Zhang, Rui wrote:
>> Hi, all,
>>
>> The problem here is that the ACPI device node has
>>             Name (_HID, "INT33D5")  // _HID: Hardware ID
>>             Name (_CID, "PNP0C02" /* PNP Motherboard Resources */)  //
>> _CID: Compatible ID
>>
>> Andy wants to write a driver for INT33D5 device, but unfortunately
>> 1. _CID "PNP0C02" makes it impossible to bind via platform bus
>> 2. Lacking of _CRS makes it impossible to bind via PNP bus.
>>
>> I've seen similar problem before, and the solution is to ask BIOS people to remove the _CID "PNP0C02".
>
> What if they refuse?
>
>> IMO, such AML code does not make sense at all (even if _CRS is provided), because in this case, the _CID and the _HID of the same ACPI device node actually represent two totally different devices.
>
> That's correct.  I guess this is a hack for Windows to prevent it from
> displaying "yellow bangs" for devices without "real" drivers.
>
>> OR, a clean way to fix this in Linux is to make the motherboard resource reservation stuff a function call instead of a driver, and invoke the function call in either PNP or ACPI bus code by checking "PNP0C02". In this case, only the device id that represents the physical device (INT33D5 in this case) can be used for device enumeration and driver probing.
>
> OK, but we need to keep the current ordering or there will be regressions in
> some odball configurations.
>
> What about walking (a) creating a list of things that have "PNP0C02" in their
> list of PNP IDs and (b) walking that list after we've completed the initial
> scan and reserving the resources for the ones that still have no drivers?
>

I'm not really sure how this can work.  The driver might be
demand-loaded (maybe even after we're done with initramfs) as a result
of a modalias.

Could we just change acpi_pnp_attach to return 0 for devices that have
HID != "PNP0C02" and don't have _CRS?

We could also consider something crazy like allowing ACPI platform
drivers (platform drivers with .acpi_match_table set) to bind pnp
devices.  I find it a bit odd that we have two different busses that
have non-natively-enumerable things that come from ACPI.

Or we could have a more general kind of driver interface that can bind
both platform and pnp devices.  (It should presumably bind any other
similar busses.)  It would match solely based on ACPI/OF data.

--Andy
