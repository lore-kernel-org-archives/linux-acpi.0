From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] ACPI: thinkpad-acpi: make the input event
	mode the default
Date: Sun, 15 Jul 2007 17:09:48 -0300
Message-ID: <20070715200948.GC19066@khazad-dum.debian.net>
References: <11844223322928-git-send-email-hmh@hmh.eng.br> <11844223341511-git-send-email-hmh@hmh.eng.br> <20070714223315.GB25782@srcf.ucam.org> <20070715180529.GF14134@khazad-dum.debian.net> <20070715183823.GC3235@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:37328 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751284AbXGOUJw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Jul 2007 16:09:52 -0400
Content-Disposition: inline
In-Reply-To: <20070715183823.GC3235@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, dmitry.torokhov@gmail.com, linux-acpi@vger.kernel.org, lenb@kernel.org

On Sun, 15 Jul 2007, Matthew Garrett wrote:
> On Sun, Jul 15, 2007 at 03:05:29PM -0300, Henrique de Moraes Holschuh wrote:
> > On Sat, 14 Jul 2007, Matthew Garrett wrote:
> > > Again, we have keycodes for most of these and we have the ability to 
> > > make the driver choose the correct one by default. Why make things more 
> > > difficult?
> > 
> > Because I only map keys that are marked (silk-screened) on the keys on at
> > least 90% of the current models.
> 
> But we're able to differentiate between the models.

Yes. And I was told to not do it in the kernel when possible, so I will map
by default only what is marked and working on a vast majority.  Otherwise,
I'd need a big quirk db, based on what is silk-screened on the keyboards.

HAL is welcome to remap the keys to whatever it wants, based on
model-specific fdi files.

> > And I could not find the proper keycode for "switch output video port", yet.
> 
> Yes, that's a good point. Dmitry? As vendors move towards adopting the 
> ACPI video extension and getting the OS to look after this, we could 
> really do with a standardised code.

Well, that one I will add as soon as I get it :-)  All thinkpads I know the
keyboard layout have FN+F7 mapped to "switch output video port".  But I have
seen a lot of non-thinkpad notebooks with "set output port to LCD" and "set
output port to vga out" keys as well.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
