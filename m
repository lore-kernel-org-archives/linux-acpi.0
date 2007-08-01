From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC PATCH] report acpi video hot key event through input
	device
Date: Wed, 1 Aug 2007 11:59:20 -0300
Message-ID: <20070801145920.GG23111@khazad-dum.debian.net>
References: <3877989d0707290940k3afa94d5x863599ac7c64662b@mail.gmail.com> <20070730005050.GB27398@srcf.ucam.org> <15e53e180707300447g77ed467dm7684184e2af46045@mail.gmail.com> <d120d5000707300555g1e677815s6148d346f0d65e5e@mail.gmail.com> <20070731125817.GD19965@khazad-dum.debian.net> <d120d5000708010652h61028821w7ba869deb9686578@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:54952 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759929AbXHAO70 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Aug 2007 10:59:26 -0400
Content-Disposition: inline
In-Reply-To: <d120d5000708010652h61028821w7ba869deb9686578@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Richard Hughes <hughsient@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Luming Yu <luming.yu@gmail.com>, linux-acpi@vger.kernel.org

On Wed, 01 Aug 2007, Dmitry Torokhov wrote:
> On 7/31/07, Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> > On Mon, 30 Jul 2007, Dmitry Torokhov wrote:
> > > I have some concerns over this patch. Some of the events reported are
> > > not the regular key presses that something needs to process and
> > > perform an action. Consider ACPI_VIDEO_NOTIFY_SWITCH is "Used to
> > > notify OSPM whenever the state of one of the output devices attached
> > > to the VGA controller has been switched or toggled." As far as I
> > > understand the event (whatever it was) was already processed by
> > > firmware and we getting a notification event of system change. So I am
> > > not sure that this event should be sent as a key event.
> >
> > This is the whole "passive and active input events" crap I went over with
> > thinkpad-acpi not too long ago.
> >
> > Can we please get a formal documentation in input of how it should be done,
> > and declare anything that doesn't follow it "buggy"?
> >
> > You know my position on it: a new event type, or not producing such events
> > at all.  But I will follow whatever rule the input layer sets.
> 
> My position is that generic event reporting (such as something has
> already switched video output from LCD to CRT, network link lost,
> battery low, brightness has already been changed) are outside of input
> layer domain (it would be silly to attach struct input_dev to network
> cards, wouldn't it?).

Can we get that documented *in-tree*? It is an issue that will keep coming
back.

Now, for the people who want these notifications (to implement status
tracking, OSDs, etc), we can setup another way to send them.  Which one?  I
know thinkpad-acpi has a ton of such notifications that it can issue, and
that userspace would like to get them for OSDs, and also to tell the user to
not go around undocking without pressing the undock lever AND waiting for
the all-clear signal, etc.

Matthew, Richard: would generic netlink sockets work for HAL ?  Is that a
way to make at least part of the messages "generic" (maybe reusing the input
layer defines?) instead of driver-specific?  Or should we continue using the
ACPI event mechanism?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
