From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC PATCH] report acpi video hot key event through input device
Date: Wed, 1 Aug 2007 18:12:27 +0100
Message-ID: <20070801171227.GA14874@srcf.ucam.org>
References: <3877989d0707290940k3afa94d5x863599ac7c64662b@mail.gmail.com> <20070730005050.GB27398@srcf.ucam.org> <15e53e180707300447g77ed467dm7684184e2af46045@mail.gmail.com> <d120d5000707300555g1e677815s6148d346f0d65e5e@mail.gmail.com> <20070731125817.GD19965@khazad-dum.debian.net> <d120d5000708010652h61028821w7ba869deb9686578@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 78-32-9-130.no-dns-yet.enta.net ([78.32.9.130]:41709 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1758407AbXHARMn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Aug 2007 13:12:43 -0400
Content-Disposition: inline
In-Reply-To: <d120d5000708010652h61028821w7ba869deb9686578@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Richard Hughes <hughsient@gmail.com>, Luming Yu <luming.yu@gmail.com>, linux-acpi@vger.kernel.org

On Wed, Aug 01, 2007 at 09:52:47AM -0400, Dmitry Torokhov wrote:

> My position is that generic event reporting (such as something has
> already switched video output from LCD to CRT, network link lost,
> battery low, brightness has already been changed) are outside of input
> layer domain (it would be silly to attach struct input_dev to network
> cards, wouldn't it?).

I think that's an understandable position, but it's not one which 
matches reality in some cases (sadly). Most Dells generate an i8042 
scancode when you hit the brightness keys, even though they'll also 
change the brightness. They'll do the same for the wireless killswitch.

Personally, I think it's logical for physical keys to generate events 
though the input layer.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
