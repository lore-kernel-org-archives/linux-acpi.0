From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH v10 1/1] Mailbox: Add support for Platform
 Communication Channel
Date: Wed, 12 Nov 2014 00:38:42 +0530
Message-ID: <CAJe_ZhdEOWYzrB_nHwwJ51U0dHAZ7FkNvaVO1pYizfHN8KAg+g@mail.gmail.com>
References: <CAJ5Y-eYbXT4rfkSXKV+jbAp=LHSZf-CHPyLuPjVdKULixO4PZA@mail.gmail.com>
	<2214649.QGmZRRXly3@wuerfel>
	<CAJe_ZhfQ7_T3LRz-OgmDj1yopZ2Jc0s3op_yFAfT+8wQZ_yS4Q@mail.gmail.com>
	<1625601.1yb4h3sjoe@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:39857 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbaKKTIo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Nov 2014 14:08:44 -0500
Received: by mail-qa0-f49.google.com with SMTP id i13so7311918qae.8
        for <linux-acpi@vger.kernel.org>; Tue, 11 Nov 2014 11:08:43 -0800 (PST)
In-Reply-To: <1625601.1yb4h3sjoe@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Patch Tracking <patches@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux acpi <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "lv.zheng" <lv.zheng@intel.com>

On 11 November 2014 23:24, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 11 November 2014 23:09:16 Jassi Brar wrote:
>> On 11 November 2014 22:03, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Tuesday 11 November 2014 19:27:07 Jassi Brar wrote:
>> >> On 11 November 2014 18:32, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
>> >> > On 10 November 2014 23:04, Jassi Brar <jaswinder.singh@linaro.org> wrote:
>> >>
>> >> In even simpler terms.... I prefer controller specific
>> >> encoding(0x50434300) instead of controller specific api
>> >> (pcc_mbox_request_channel).  For a different class of controller, it
>> >> is much cleaner to define a new encoding as compared to another
>> >> xyz_mbox_request_channel() api.
>> >
>> > The problem with this approach is that it still leaves the interface
>> > as controller specific, because the client now has to know that it
>> > must pass the PCC identifier instead of an index.
>> >
>> Yup. I hope you are aware that the "index" argument of
>> pcc_mbox_request_channel() is just the same thing. The "index" there
>> is actually the 'Type' value defined in ACPI for the client.
>
> The problem is that it's not an index relative to the client, but
> into an array of the mailbox provide. I only today noticed that both
> are called 'index' in the source code, which is highly confusing,
> and the pcc driver should name it 'subspaceid' or similar instead,
> to minimize the confusion.
>
OK.

Ashwin, would you fix the name and resubmit. Or I do
s/index/subspace_id/ before committing?
Arnd, Could I please have your Reviewed/Acked-by?

Thanks
Jassi
