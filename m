From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH] report acpi video hot key event through input device
Date: Wed, 1 Aug 2007 09:52:47 -0400
Message-ID: <d120d5000708010652h61028821w7ba869deb9686578@mail.gmail.com>
References: <3877989d0707290940k3afa94d5x863599ac7c64662b@mail.gmail.com>
	 <20070730005050.GB27398@srcf.ucam.org>
	 <15e53e180707300447g77ed467dm7684184e2af46045@mail.gmail.com>
	 <d120d5000707300555g1e677815s6148d346f0d65e5e@mail.gmail.com>
	 <20070731125817.GD19965@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:28207 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760823AbXHANwt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Aug 2007 09:52:49 -0400
Received: by nf-out-0910.google.com with SMTP id g13so57075nfb
        for <linux-acpi@vger.kernel.org>; Wed, 01 Aug 2007 06:52:48 -0700 (PDT)
In-Reply-To: <20070731125817.GD19965@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Richard Hughes <hughsient@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Luming Yu <luming.yu@gmail.com>, linux-acpi@vger.kernel.org

On 7/31/07, Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> On Mon, 30 Jul 2007, Dmitry Torokhov wrote:
> > I have some concerns over this patch. Some of the events reported are
> > not the regular key presses that something needs to process and
> > perform an action. Consider ACPI_VIDEO_NOTIFY_SWITCH is "Used to
> > notify OSPM whenever the state of one of the output devices attached
> > to the VGA controller has been switched or toggled." As far as I
> > understand the event (whatever it was) was already processed by
> > firmware and we getting a notification event of system change. So I am
> > not sure that this event should be sent as a key event.
>
> This is the whole "passive and active input events" crap I went over with
> thinkpad-acpi not too long ago.
>
> Can we please get a formal documentation in input of how it should be done,
> and declare anything that doesn't follow it "buggy"?
>
> You know my position on it: a new event type, or not producing such events
> at all.  But I will follow whatever rule the input layer sets.
>

My position is that generic event reporting (such as something has
already switched video output from LCD to CRT, network link lost,
battery low, brightness has already been changed) are outside of input
layer domain (it would be silly to attach struct input_dev to network
cards, wouldn't it?).

-- 
Dmitry
