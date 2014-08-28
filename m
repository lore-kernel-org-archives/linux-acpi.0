From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v3 1/3] Mailbox: Add support for PCC mailbox and channels
Date: Thu, 28 Aug 2014 08:21:52 -0400
Message-ID: <CAJ5Y-ea0Sg4E=Jv3Z--32RbHqUwHAp7yxxfA7EgmGxwvNLM48A@mail.gmail.com>
References: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org>
	<CAJ5Y-eak9A14z3im_5sgvnqMQDRf5rNgcQNGwDV2aYh_POkLOA@mail.gmail.com>
	<20140827190902.GR17528@sirena.org.uk>
	<2961329.Rr1sZlGzgn@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:62358 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbaH1MVy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Aug 2014 08:21:54 -0400
Received: by mail-wi0-f175.google.com with SMTP id ho1so7345151wib.2
        for <linux-acpi@vger.kernel.org>; Thu, 28 Aug 2014 05:21:52 -0700 (PDT)
In-Reply-To: <2961329.Rr1sZlGzgn@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi Arnd,

On 28 August 2014 04:39, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 27 August 2014 20:09:02 Mark Brown wrote:
>> On Wed, Aug 27, 2014 at 09:07:15AM -0400, Ashwin Chaugule wrote:
>> > On 27 August 2014 06:27, Mark Brown <broonie@kernel.org> wrote:
>> > > On Tue, Aug 26, 2014 at 03:35:36PM -0400, Ashwin Chaugule wrote:
>>
>> > >> +static struct mbox_controller *
>> > >> +mbox_find_pcc_controller(char *name)
>> > >> +{
>> > >> +     struct mbox_controller *mbox;
>> > >> +     list_for_each_entry(mbox, &mbox_cons, node) {
>> > >> +             if (mbox->name)
>> > >> +                     if (!strcmp(mbox->name, name))
>> > >> +                             return mbox;
>> > >> +     }
>> > >> +
>> > >> +     return NULL;
>> > >> +}
>>
>> > > This doesn't look particularly PCC specific?
>>
>> > Call this mbox_find_controller_by_name() instead?
>>
>> That certainly looks like what it's doing.  Probably also make the name
>> that gets passed in const while you're at it.
>
> The mailbox API intentionally does not have an interface for
> that: you are supposed to get a reference to an mbox controller
> from a phandle or similar, not by knowing the name of the controller.

This snippet is based off of your suggestions. [1] [2] :)

>
> Unfortunately, the three patches that Ashwin posted don't have a
> caller for this function,

mbox_find_pcc_controller() is called from pcc_mbox_request_channel()
which is in this patch.

> so I don't know what it's actually used for.
> Why do we need this function for pcc, and what are the names that
> can be passed here?
>
>         Arnd

[1] - http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/265395.html
[2] - http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/266528.html
