From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v3 1/3] Mailbox: Add support for PCC mailbox and channels
Date: Wed, 27 Aug 2014 09:07:15 -0400
Message-ID: <CAJ5Y-eak9A14z3im_5sgvnqMQDRf5rNgcQNGwDV2aYh_POkLOA@mail.gmail.com>
References: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org>
	<1409081738-5602-2-git-send-email-ashwin.chaugule@linaro.org>
	<20140827102708.GW17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:51224 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933257AbaH0NHQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Aug 2014 09:07:16 -0400
Received: by mail-wg0-f52.google.com with SMTP id a1so192298wgh.11
        for <linux-acpi@vger.kernel.org>; Wed, 27 Aug 2014 06:07:15 -0700 (PDT)
In-Reply-To: <20140827102708.GW17528@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux acpi <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi Mark,

On 27 August 2014 06:27, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Aug 26, 2014 at 03:35:36PM -0400, Ashwin Chaugule wrote:
>
>> The PCC (Platform Communication Channel) is a generic
>> mailbox to be used by PCC clients such as CPPC, RAS
>> and MPST as defined in the ACPI 5.0+ spec. This patch
>> modifies the Mailbox framework to lookup PCC mailbox
>> controllers and channels such that PCC drivers can work
>> with or without ACPI support in the kernel.
>>
>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> ---
>>  drivers/mailbox/mailbox.c          | 118 ++++++++++++++++++++++++++++++++++---
>>  include/linux/mailbox_client.h     |   6 ++
>>  include/linux/mailbox_controller.h |   1 +
>>  3 files changed, 118 insertions(+), 7 deletions(-)
>
> Based on the patch description (adding support for a particular kind of
> mailbox) I'd expect to see a new driver or helper library being added to
> drivers/mailbox rather than changes in the mailbox core.  If changes in
> the core are needed to support this I'd expect to see them broken out as
> separate patches.

[..]

>
>> +static struct mbox_controller *
>> +mbox_find_pcc_controller(char *name)
>> +{
>> +     struct mbox_controller *mbox;
>> +     list_for_each_entry(mbox, &mbox_cons, node) {
>> +             if (mbox->name)
>> +                     if (!strcmp(mbox->name, name))
>> +                             return mbox;
>> +     }
>> +
>> +     return NULL;
>> +}
>
> This doesn't look particularly PCC specific?

Call this mbox_find_controller_by_name() instead?

>
>>       /* Sanity check */
>> -     if (!mbox || !mbox->dev || !mbox->ops || !mbox->num_chans)
>> +
>> +     /*
>> +      * PCC clients and controllers are currently not backed by
>> +      * platform device structures.
>> +      */
>> +#ifndef CONFIG_PCC
>> +     if (!mbox->dev)
>> +             return -EINVAL;
>> +#endif
>
> It seems better to make this consistent - either enforce it all the time
> or don't enforce it.

So this is where it got really messy. We're trying to create a
"device" out of something that isn't. The PCCT, which is used as a
mailbox controller here, is a table and not a peripheral device. To
treat this as a device (without faking it by manually putting together
a struct device), would require adding a DSDT entry which is really a
wrong place for it. Are there examples today where drivers manually
create a struct driver and struct device and match them internally?
(i.e. w/o using the generic driver subsystem)

The main reason why I thought this Mailbox framework looked useful
(after you pointed me to it) for PCC was due to its async notification
features. But thats easy and small enough to add to the PCC driver
itself. We can also add a generic controller lookup mechanism in the
PCC driver for anyone who doesn't want to use ACPI. I think thats a
much cleaner way to handle PCC support. Adding PCC as a generic
mailbox controller is turning out to be more messier that we'd
originally imagined.

Cheers,
Ashwin
