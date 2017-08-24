From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 2/3] platform/x86: Add support for Dollar Cove TI power button
Date: Thu, 24 Aug 2017 14:47:04 +0300
Message-ID: <CAHp75VdLSm4gtmD7kPLn4xxO_Gw2FwE3SzE-6UB3h0KpCLk39Q@mail.gmail.com>
References: <20170824081141.5018-1-tiwai@suse.de> <20170824081141.5018-3-tiwai@suse.de>
 <CAHp75Vfsn+7ZZCdis_iOHk36TnZp-354ncetE=R+h7piBMx9Qg@mail.gmail.com> <s5hh8wxl2nh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38856 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbdHXLrF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Aug 2017 07:47:05 -0400
In-Reply-To: <s5hh8wxl2nh.wl-tiwai@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Aug 24, 2017 at 12:45 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Thu, 24 Aug 2017 11:20:04 +0200,
> Andy Shevchenko wrote:
>>
>> On Thu, Aug 24, 2017 at 11:11 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > This provides a new input driver for supporting the power button on
>> > Dollar Cove TI PMIC, found on Cherrytrail-based devices.
>> > The patch is based on the original work by Intel, found at:
>> >   https://github.com/01org/ProductionKernelQuilts
>> >
>> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=193891
>> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>
>> Are you going to submit it via MFD?
>
> I really don't mind who takes what.  The driver codes are small, so it
> should be OK to go through a single tree, presumably MFD, if all
> people agree.
>
> OTOH, if Lee can prepare an immutable branch, other two can go via
> other trees, too.
>
> What do you guys think better?

As a co-maintainer of PDx86 I prefer to go with MFD or whatever first
patch is related to.

-- 
With Best Regards,
Andy Shevchenko
