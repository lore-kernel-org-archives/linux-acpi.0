From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC PATCH] report acpi video hot key event through input
	device
Date: Tue, 31 Jul 2007 09:58:17 -0300
Message-ID: <20070731125817.GD19965@khazad-dum.debian.net>
References: <3877989d0707290940k3afa94d5x863599ac7c64662b@mail.gmail.com> <20070730005050.GB27398@srcf.ucam.org> <15e53e180707300447g77ed467dm7684184e2af46045@mail.gmail.com> <d120d5000707300555g1e677815s6148d346f0d65e5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:33273 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751142AbXGaM6W (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 31 Jul 2007 08:58:22 -0400
Content-Disposition: inline
In-Reply-To: <d120d5000707300555g1e677815s6148d346f0d65e5e@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Richard Hughes <hughsient@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Luming Yu <luming.yu@gmail.com>, linux-acpi@vger.kernel.org

On Mon, 30 Jul 2007, Dmitry Torokhov wrote:
> I have some concerns over this patch. Some of the events reported are
> not the regular key presses that something needs to process and
> perform an action. Consider ACPI_VIDEO_NOTIFY_SWITCH is "Used to
> notify OSPM whenever the state of one of the output devices attached
> to the VGA controller has been switched or toggled." As far as I
> understand the event (whatever it was) was already processed by
> firmware and we getting a notification event of system change. So I am
> not sure that this event should be sent as a key event.

This is the whole "passive and active input events" crap I went over with
thinkpad-acpi not too long ago.

Can we please get a formal documentation in input of how it should be done,
and declare anything that doesn't follow it "buggy"?

You know my position on it: a new event type, or not producing such events
at all.  But I will follow whatever rule the input layer sets.

> The brightness events on the other hand seem to be perfectly suited
> for an input device (unless are are also already processed by the
> firmware and action has already been taken).

Agreed.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
