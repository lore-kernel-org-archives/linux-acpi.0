From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] [PATCH v10 1/1] Mailbox: Add support for Platform Communication Channel
Date: Tue, 11 Nov 2014 18:54:34 +0100
Message-ID: <1625601.1yb4h3sjoe@wuerfel>
References: <CAJ5Y-eYbXT4rfkSXKV+jbAp=LHSZf-CHPyLuPjVdKULixO4PZA@mail.gmail.com> <2214649.QGmZRRXly3@wuerfel> <CAJe_ZhfQ7_T3LRz-OgmDj1yopZ2Jc0s3op_yFAfT+8wQZ_yS4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:62428 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbaKKRyj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Nov 2014 12:54:39 -0500
In-Reply-To: <CAJe_ZhfQ7_T3LRz-OgmDj1yopZ2Jc0s3op_yFAfT+8wQZ_yS4Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Patch Tracking <patches@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux acpi <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "lv.zheng" <lv.zheng@intel.com>

On Tuesday 11 November 2014 23:09:16 Jassi Brar wrote:
> On 11 November 2014 22:03, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 11 November 2014 19:27:07 Jassi Brar wrote:
> >> On 11 November 2014 18:32, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> >> > On 10 November 2014 23:04, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> >>
> >> In even simpler terms.... I prefer controller specific
> >> encoding(0x50434300) instead of controller specific api
> >> (pcc_mbox_request_channel).  For a different class of controller, it
> >> is much cleaner to define a new encoding as compared to another
> >> xyz_mbox_request_channel() api.
> >
> > The problem with this approach is that it still leaves the interface
> > as controller specific, because the client now has to know that it
> > must pass the PCC identifier instead of an index.
> >
> Yup. I hope you are aware that the "index" argument of
> pcc_mbox_request_channel() is just the same thing. The "index" there
> is actually the 'Type' value defined in ACPI for the client.

The problem is that it's not an index relative to the client, but
into an array of the mailbox provide. I only today noticed that both
are called 'index' in the source code, which is highly confusing,
and the pcc driver should name it 'subspaceid' or similar instead,
to minimize the confusion.

> > A client driver using DT would just specify to use the first channel
> > that is defined locally in the "mboxes" properties, so it can ask for
> >
> >         chan = mbox_request_channel(client, 0);
> >
> > to get the first channel defined for this client while a driver using
> > ACPI has to look up the identifier in its own local tables:
> >
> >         u32 channel_id = this_driver_parse_acpi_and_find_pccid(dev);
> >         chan = mbox_request_channel(client, channel_id);
> >
> > which is not the same interface as the first, even if you assume the
> > channel_id to be globally unique in the system.
> >
> Yes. As I said, same for pcc_mbox_request_channel(). But since PCC
> clients are limited and specified by ACPI (Type value won't change
> across platforms, I understand), the client drivers could have that
> value hardcoded.

Not really:

> > Since we will need clients to have a consistent interface across
> > DT and ACPI, I think the difference in firmware interfaces is better
> > abstracted in a PCC specific interface.
> >
> > The client driver would still need to parse two different firmware
> > structures, but it would at least have a consistent interface:
> >
> >         u32 channel_id = of_property_read_u32(dev->of_node, "pccid");
> >         if (!channel_id)
> >                 channel_id = this_driver_parse_acpi_and_find_pccid(dev);
> >         chan = mbox_request_channel(client, channel_id);
> >
> > Alternatively, the driver could use the regular API on DT:
> >
> >         chan = mbox_request_channel(cl, 0);
> >         if (!chan) {
> >                 u32 chan_id = this_driver_parse_acpi_and_find_pccid(dev);
> >                 chan =  mbox_request_channel(client, channel_id);
> >         }
> >
> OK, but if the 'Type' value, that a client passes to
> (pcc_)mbox_req_chan(), does not change across platforms, would we need
> that?

As I understand the ACPI specification, we have multiple clients to the
PCC, and each of them has its own client-specific hardcoded interface
to /find/ the subspace ID from the ACPI tables, but the subspace ID itself
has to be read from the table and is not constant.

	Arnd
