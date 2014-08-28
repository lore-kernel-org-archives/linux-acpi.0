From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v3 1/3] Mailbox: Add support for PCC mailbox and channels
Date: Thu, 28 Aug 2014 08:31:02 -0400
Message-ID: <CAJ5Y-eZbCe8hMDpUMiAAy92ibeuFNtCVGyUfBoMa91C7cE2hwA@mail.gmail.com>
References: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org>
	<1409081738-5602-2-git-send-email-ashwin.chaugule@linaro.org>
	<20140827102708.GW17528@sirena.org.uk>
	<CAJ5Y-eak9A14z3im_5sgvnqMQDRf5rNgcQNGwDV2aYh_POkLOA@mail.gmail.com>
	<20140827190902.GR17528@sirena.org.uk>
	<CAJ5Y-eYk1zq+NvPRbZanO5yXVLqZ6_81rQMd+7iRtLu6HBQ5OA@mail.gmail.com>
	<20140828101025.GL17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:57623 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbaH1MbG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Aug 2014 08:31:06 -0400
Received: by mail-we0-f169.google.com with SMTP id k48so684714wev.14
        for <linux-acpi@vger.kernel.org>; Thu, 28 Aug 2014 05:31:02 -0700 (PDT)
In-Reply-To: <20140828101025.GL17528@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux acpi <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi Mark,

On 28 August 2014 06:10, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Aug 27, 2014 at 05:49:53PM -0400, Ashwin Chaugule wrote:
>> On 27 August 2014 15:09, Mark Brown <broonie@kernel.org> wrote:
>> > On Wed, Aug 27, 2014 at 09:07:15AM -0400, Ashwin Chaugule wrote:
>> >> "device" out of something that isn't. The PCCT, which is used as a
>> >> mailbox controller here, is a table and not a peripheral device. To
>> >> treat this as a device (without faking it by manually putting together
>> >> a struct device), would require adding a DSDT entry which is really a
>> >> wrong place for it. Are there examples today where drivers manually
>> >> create a struct driver and struct device and match them internally?
>> >> (i.e. w/o using the generic driver subsystem)
>
>> > Arguably that's what things like cpufreq end up doing, though people
>> > tend to just shove a device into DT.  Are you sure there isn't any
>> > device at all in ACPI that you could hang this off, looking at my
>> > desktop I see rather a lot of apparently synthetic ACPI devices with
>> > names starting LNX including for example LNXSYSTM:00?
>
>> Those are special HIDs defined in the ACPI spec and none of those can
>> be used to back a device for the PCCT itself, since they're unrelated
>> to the PCC protocol. The PCCT is defined in the spec as a separate
>> table and if supported, should be visible in your system in the
>> PCCT.dsl file. Just for the sake of the Mailbox framework, trying to
>> represent the PCCT (which is a table) as a mailbox controller device,
>> would require registering a special HID. That in turn would make an
>> otherwise OS agnostic thing very Linux specific.
>
> OK, but then there's always the option of just having some code that
> runs on init and instantiates a device if it sees the appropriate thing
> in the ACPI tables in a similar manner to how HIDs are handled.  It's a
> small amount of work but it will generally make life easier if there is
> a struct device.

I need to give this a try. AFAICS, the HIDs get their device created
by the driver subsystem. This would require manually creating one and
I didn't see existing examples. Thinking of a table as a device
(virtual/real) seemed weird to me, especially since we're seemingly
only using it for ref counts here. But it sounds like this is an
acceptable thing.

>
>> > If PCC is described by ACPI tables how would non-ACPI users be able to
>> > use it?
>
>> Whoever wants to do that, would need to come up with DT bindings that
>> describe something similar to the PCCT contents. They could possibly
>> ignore the ACPI specific bits like signature, asl compiler details
>> etc. (which are only used by ACPI table parsers) and provide the rest
>> of it. Its essentially an array of structures that point to various
>> shared memory regions, each of which is owned by a PCC client and
>> shared with the firmware. The intercommunication between client and
>> firmware is via a doorbell, which is also described in these entries
>> and can be implemented as an SGI or similar.
>
> Of course most likely such a binding would involve creating a device
> that owns the mailboxes so this'd be fairly straightforward...

With DT, yes, it seems to be a bit more straightforward.


Thanks,
Ashwin
