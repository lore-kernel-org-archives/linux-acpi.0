From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] [PATCH v10 1/1] Mailbox: Add support for Platform Communication Channel
Date: Mon, 10 Nov 2014 21:29:57 +0100
Message-ID: <6137834.nUiGJsT7Uj@wuerfel>
References: <CAJ5Y-eYbXT4rfkSXKV+jbAp=LHSZf-CHPyLuPjVdKULixO4PZA@mail.gmail.com> <CAJe_Zhen65HwdyBPcBCjX7uD9BGBesHbQJeHdRmz3Bw2DdB5sw@mail.gmail.com> <20141110201310.GQ3815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:62323 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbaKJUaF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Nov 2014 15:30:05 -0500
In-Reply-To: <20141110201310.GQ3815@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linaro-acpi@lists.linaro.org
Cc: Mark Brown <broonie@kernel.org>, Jassi Brar <jaswinder.singh@linaro.org>, Patch Tracking <patches@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux acpi <linux-acpi@vger.kernel.org>, "lv.zheng" <lv.zheng@intel.com>

On Monday 10 November 2014 20:13:10 Mark Brown wrote:
> On Mon, Nov 10, 2014 at 11:14:48PM +0530, Jassi Brar wrote:
> > On 10 November 2014 20:17, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> > > What is there to stop two users from coming up with the same signature
> > > (0xdeadbeef / "string") for their mbox controllers? Things can break
> > > at run time, because with your patch, the first mbox controller with
> > > the duplicate signature/name will return a channel. The client may be
> > > expecting a channel from the "other" mbox.
> 
> > Two channels with same signature are supposed to be _identical_ i.e,
> > either channel could serve any client asking for a channel with that
> > signature. So even if an "unexpected" instance of the channel is
> > assigned, the client should still be happy.
> 
> > If a client differentiates between 2 instances of a channel, that's
> > probably a sign of bad design. The knowledge behind client's
> > preference of instance should actually lie on the provider(controller)
> > side. I am open to some example on the contrary.
> 
> The problem here is that ACPI isn't defining the context in a way which
> maps well onto the way Linux looks things up.  We may not like that and
> think it's a bad design but the spec is a done deal here and we have to
> address reality.  From an ACPI point of view the context is the fact
> that this is a PCC channel (there's a globally unique namespace for PCC
> channels) but Linux wants a struct device for the client to represent
> the context with a mapping table of some kind behind that to do the
> lookup.

Right.

> There's nothing in the ACPI description of the channel or controller to
> tie it to the client device, and there's nothing preventing some other
> mailbox mechanism that gets added to an ACPI system from reusing similar
> names (bear in mind that idiomatic naming for ACPI appears to be three
> or four character strings).  If we have a PCC channel "FOO" and some new
> mailbox type which also defines "FOO" the controllers aren't really
> going to be able to tell them apart just on the string.
> 
> We could fit the maping into Linux a bit by having a struct device
> representing the PCC controller that you use to do the lookup but at
> that point you may as well have a PCC specific request function that
> knows that device and does the lookup which is approximately what we
> have in Ashwin's patch.  We could also require that the lookup be
> something like "PCC:FOO" and use a global_xlate() but it's not clear to
> me that this is making things clearer.

Agreed. Having a special interface here the way that Ashwin's patch
introduces seems the least invasive. I don't think we would risk running
into the problems that Jassi mentioned regarding API growth if we
get other cases. In particular, anything that boots with DT will be
able to use the standard method, and even with ACPI if we have additional
mailboxes we would most likely use the named properties extension in
the future.

On a side note, I think we will actually have to add a DT binding
to PCC as well, but that should probably provide both the standard
mailbox API as well as support the pcc specific interfaces in order
to allow client drivers that do not have multiple ways of doing the
same thing.

	Arnd
