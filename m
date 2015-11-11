From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/4] nvdimm: Add wrapper for IOCTL pass thru.
Date: Tue, 10 Nov 2015 16:49:17 -0800
Message-ID: <CAPcyv4h=u7hDWqQ2E92tnMuX=_-SwnWkCSAdJ7vJkDuw1+i1rQ@mail.gmail.com>
References: <cover.1446684001.git.jerry.hoemann@hpe.com>
	<5411049831df211c8280e3239aaf344af033fa25.1446684001.git.jerry.hoemann@hpe.com>
	<x49d1vhlp34.fsf@segfault.boston.devel.redhat.com>
	<20151110194938.GA47666@tevye.fc.hp.com>
	<x49oaf1k3cx.fsf@segfault.boston.devel.redhat.com>
	<20151111004425.GG47666@tevye.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36000 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbbKKAtS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2015 19:49:18 -0500
Received: by wmww144 with SMTP id w144so140634490wmw.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2015 16:49:17 -0800 (PST)
In-Reply-To: <20151111004425.GG47666@tevye.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jerry Hoemann <Jerry.Hoemann@hpe.com>
Cc: Jeff Moyer <jmoyer@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@ml01.01.org>

On Tue, Nov 10, 2015 at 4:44 PM, Jerry Hoemann <jerry.hoemann@hpe.com> wrote:
> On Tue, Nov 10, 2015 at 03:26:38PM -0500, Jeff Moyer wrote:
[..]
>> I see.  I misread that, because you didn't actually make buf a zero
>> length array (see the structure definition quoted above).  I guess you
>> meant to write this:
>>
>>     unsigned char buf[0];
>>
>
> The ndn_pkg.buf struct uses a flexible array definition.  This is in C99.
> An explicit zero length array is a gcc extension that has been around much
> longer.  They behave in a similar fashion, but aren't identical.   In my
> limited use they behave the same.

"buf[0]" is more idiomatic for Linux.  I know I expressed concern
about compiler compatibility for ACPICA, but this path does not have
ACPICA interactions.
