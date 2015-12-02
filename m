From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: ACPI device without physical node (pnpacpi oddity?)
Date: Tue, 1 Dec 2015 18:03:31 -0800
Message-ID: <CALCETrV6F=FcXaoDGeb=x+ebSzopR3ib5PsK2Ckupr6z+80+aQ@mail.gmail.com>
References: <CALCETrXcJN-nKLVzuWj_pbqwO+g0i1sfg2vCr=Y6_Gn_7XT=gw@mail.gmail.com>
 <2355752.R19tF0KgU6@vostro.rjw.lan> <CALCETrX24s2wzXs4bz4GH-XAi8COk2nKUkXYY2i81MV=r5H_PQ@mail.gmail.com>
 <2306632.Ddb0M2gLJC@vostro.rjw.lan> <1449021653.22321.6.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35212 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757441AbbLBCDv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Dec 2015 21:03:51 -0500
Received: by oige206 with SMTP id e206so16262828oig.2
        for <linux-acpi@vger.kernel.org>; Tue, 01 Dec 2015 18:03:51 -0800 (PST)
In-Reply-To: <1449021653.22321.6.camel@rzhang1-mobl4>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>

On Tue, Dec 1, 2015 at 6:00 PM, Zhang Rui <rui.zhang@intel.com> wrote:
> On Wed, 2015-12-02 at 01:48 +0100, Rafael J. Wysocki wrote:
>> For your use case we could make the PNP layer ignore the pnp0c02 device id if
>> (a) _CRS is missing and (b) pnp0c02 is in the _CID list (not a _HID).
>>
> Yes, this could work.
> But I'm concerning another case, say, a device with both _CRS and _CID
> "PNP0C02", we don't have a way to probe the device via _HID.

Doesn't .acpi_match_table do exactly this?

--Andy
