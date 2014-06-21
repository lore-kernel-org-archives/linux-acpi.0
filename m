From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] [RFC v2 1/3] Mailbox: Add support for ACPI
Date: Sat, 21 Jun 2014 11:34:05 +0200
Message-ID: <4678828.UygJelrJo5@wuerfel>
References: <1402591692-7736-1-git-send-email-ashwin.chaugule@linaro.org> <4600246.SKVsl5kA9F@wuerfel> <CAJ5Y-eYN6NfFdKAkv5yrHTdeRNWJfvgPVL61EjZdgN0DYP8zpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:53370 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754748AbaFUJeq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Jun 2014 05:34:46 -0400
In-Reply-To: <CAJ5Y-eYN6NfFdKAkv5yrHTdeRNWJfvgPVL61EjZdgN0DYP8zpA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Jassi Brar <jassisinghbrar@gmail.com>, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Patch Tracking <patches@linaro.org>

On Friday 20 June 2014 17:43:05 Ashwin Chaugule wrote:
> >
> > Note that "device" here doesn't have to mean a platform device that
> > is instantiated from DSDT, it can be any mailbox provider that is
> > registered in an arbitrary way, as long as you have a method to map
> > back from the (consumer-device, name-string) tuple back to the
> > (provider, channel) tuple. I have read your patch again now and noticed
> > that you actually tried to do this, but unfortunately you got it
> > wrong by requiring the consumer to fill out the name of the provider
> > in the request. You can't do that, because it's not generic enough
> > to support devices that can be reused, and it means that drivers
> > using the API are never portable between DT and ACPI. You have to
> > get rid of the "ctrl_name" field in the mbox_client structure and
> > change the lookup to be based only on cd->dev and cl->chan_name,
> > using whatever tables you have available in ACPI.
> 
> I think you looked at the previous version of the patch. I'm attaching
> the latest version here again FWIW. In this version, I removed the
> "ctrl_name" field and rely on the cl->chan_name to provide the info as
> described in Jassi' original patch.
> 
> 
> linux/mailbox_client.h
> 
>  18  * struct mbox_client - User of a mailbox
>  19  * @dev:        The client device
>  20  * @chan_name:      The "controller:channel" this client wants
> 
> Instead of dev, I added a name string to the mbox controller
> structure. So now the client gets its channel by requesting
> "controller:channel" where controller should match with mbox->name and
> channel becomes an index into mbox->chans[].
> 

Right, I looked at the wrong version, sorry about that.

However, it seems you still make the same mistake here: The name that
gets passed as chan_name in the mailbox API is a local identifier
that is supposed to be interpreted for the client device and used
to look up a pointer to the mailbox device and channel. If you require
drivers to put global data (e.g. the mbox->name, or the channel
number) in there, it's impossible to write a driver that works on
both DT and ACPI. If you want to use the mbox_request_channel()
interface from a driver, you need some form of lookup table in 
the ACPI data to do the conversion.

The alternative would be not to use mbox_request_channel() at all
for now, but to add a new interface that can only be used PCC and
that matches by ID but is independent of the use of ACPI or DT,
something like:

struct mbox_chan *pcc_mbox_get_channel(struct mbox_client *cl, 
			char *name, unsigned chan_id,
			struct mbox_chan **chan)
{
	struct mbox_controller *mbox;
	mbox = mbox_find_pcc_controller(name, ...);

	*chan = &mbox->chans[chan_id];
	return init_channel(*chan, cl);
}

This would mean that we'd have to special-case "pcc" users, which is
not very nice, but at least it would work on both DT and ACPI,
and a future ACPI version could still add support for the mailbox
API later.

	Arnd
