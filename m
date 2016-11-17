From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] ACPI / LPSS: enable hard LLP for DMA
Date: Thu, 17 Nov 2016 14:39:05 +0100
Message-ID: <CAJZ5v0gbqaKS0ruz=Hv9DKq1HszXK6G+V5zHdxvb9h0qJcw2Nw@mail.gmail.com>
References: <20161108134638.90267-1-andriy.shevchenko@linux.intel.com>
 <20161108135742.GY1447@lahna.fi.intel.com> <1479379161.22212.2.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33636 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932233AbcKQObb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Nov 2016 09:31:31 -0500
Received: by mail-qk0-f181.google.com with SMTP id x190so221533515qkb.0
        for <linux-acpi@vger.kernel.org>; Thu, 17 Nov 2016 06:31:30 -0800 (PST)
In-Reply-To: <1479379161.22212.2.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Thu, Nov 17, 2016 at 11:39 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, 2016-11-08 at 15:57 +0200, Mika Westerberg wrote:
>> On Tue, Nov 08, 2016 at 03:46:38PM +0200, Andy Shevchenko wrote:
>> > Right now the DMA support of hard LLP is fused. Enable it via
>> > specific message
>> > sent to SoC at run time.
>>
>> It would help the reviewer if you explain what hard LLP actually means
>> ;-)
>
> Rafael, shall I fix commit message and resend?

Not strictly necessary, but if you can do that, it would be nice. :-)

Thanks,
Rafael
