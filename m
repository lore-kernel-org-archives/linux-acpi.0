From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v3 1/3] Mailbox: Add support for PCC mailbox and channels
Date: Wed, 27 Aug 2014 17:49:53 -0400
Message-ID: <CAJ5Y-eYk1zq+NvPRbZanO5yXVLqZ6_81rQMd+7iRtLu6HBQ5OA@mail.gmail.com>
References: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org>
	<1409081738-5602-2-git-send-email-ashwin.chaugule@linaro.org>
	<20140827102708.GW17528@sirena.org.uk>
	<CAJ5Y-eak9A14z3im_5sgvnqMQDRf5rNgcQNGwDV2aYh_POkLOA@mail.gmail.com>
	<20140827190902.GR17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:42900 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246AbaH0Vtz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Aug 2014 17:49:55 -0400
Received: by mail-wi0-f178.google.com with SMTP id r20so188118wiv.5
        for <linux-acpi@vger.kernel.org>; Wed, 27 Aug 2014 14:49:53 -0700 (PDT)
In-Reply-To: <20140827190902.GR17528@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux acpi <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi Mark,

On 27 August 2014 15:09, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Aug 27, 2014 at 09:07:15AM -0400, Ashwin Chaugule wrote:
>> On 27 August 2014 06:27, Mark Brown <broonie@kernel.org> wrote:
>> > On Tue, Aug 26, 2014 at 03:35:36PM -0400, Ashwin Chaugule wrote:
>> >>       /* Sanity check */
>> >> -     if (!mbox || !mbox->dev || !mbox->ops || !mbox->num_chans)
>> >> +
>> >> +     /*
>> >> +      * PCC clients and controllers are currently not backed by
>> >> +      * platform device structures.
>> >> +      */
>> >> +#ifndef CONFIG_PCC
>> >> +     if (!mbox->dev)
>> >> +             return -EINVAL;
>> >> +#endif
>
>> > It seems better to make this consistent - either enforce it all the time
>> > or don't enforce it.
>
>> So this is where it got really messy. We're trying to create a
>
> The messiness is orthogonal to my comment here - either it's legal to
> request a mailbox without a device or it isn't, it shouldn't depend on a
> random kernel configuration option for a particular mailbox driver which
> it is.
>

Fair enough. This was just to show that PCC is unfortunately not a
good candidate as a generic mailbox controller.

>> "device" out of something that isn't. The PCCT, which is used as a
>> mailbox controller here, is a table and not a peripheral device. To
>> treat this as a device (without faking it by manually putting together
>> a struct device), would require adding a DSDT entry which is really a
>> wrong place for it. Are there examples today where drivers manually
>> create a struct driver and struct device and match them internally?
>> (i.e. w/o using the generic driver subsystem)
>
> Arguably that's what things like cpufreq end up doing, though people
> tend to just shove a device into DT.  Are you sure there isn't any
> device at all in ACPI that you could hang this off, looking at my
> desktop I see rather a lot of apparently synthetic ACPI devices with
> names starting LNX including for example LNXSYSTM:00?

Those are special HIDs defined in the ACPI spec and none of those can
be used to back a device for the PCCT itself, since they're unrelated
to the PCC protocol. The PCCT is defined in the spec as a separate
table and if supported, should be visible in your system in the
PCCT.dsl file. Just for the sake of the Mailbox framework, trying to
represent the PCCT (which is a table) as a mailbox controller device,
would require registering a special HID. That in turn would make an
otherwise OS agnostic thing very Linux specific.

>
>> The main reason why I thought this Mailbox framework looked useful
>> (after you pointed me to it) for PCC was due to its async notification
>> features. But thats easy and small enough to add to the PCC driver
>> itself. We can also add a generic controller lookup mechanism in the
>> PCC driver for anyone who doesn't want to use ACPI. I think thats a
>> much cleaner way to handle PCC support. Adding PCC as a generic
>> mailbox controller is turning out to be more messier that we'd
>> originally imagined.
>
> If PCC is described by ACPI tables how would non-ACPI users be able to
> use it?

Whoever wants to do that, would need to come up with DT bindings that
describe something similar to the PCCT contents. They could possibly
ignore the ACPI specific bits like signature, asl compiler details
etc. (which are only used by ACPI table parsers) and provide the rest
of it. Its essentially an array of structures that point to various
shared memory regions, each of which is owned by a PCC client and
shared with the firmware. The intercommunication between client and
firmware is via a doorbell, which is also described in these entries
and can be implemented as an SGI or similar.

Thanks,
Ashwin
