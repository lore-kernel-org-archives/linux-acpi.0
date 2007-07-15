From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: ACPI: thinkpad-acpi: make the input event mode the default
Date: Sun, 15 Jul 2007 15:05:29 -0300
Message-ID: <20070715180529.GF14134@khazad-dum.debian.net>
References: <11844223322928-git-send-email-hmh@hmh.eng.br> <11844223341511-git-send-email-hmh@hmh.eng.br> <20070714223315.GB25782@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:51564 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754288AbXGOSFc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Jul 2007 14:05:32 -0400
Content-Disposition: inline
In-Reply-To: <20070714223315.GB25782@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: lenb@kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Richard Hughes <hughsient@gmail.com>

On Sat, 14 Jul 2007, Matthew Garrett wrote:
> On Sat, Jul 14, 2007 at 11:12:00AM -0300, Henrique de Moraes Holschuh wrote:
> > -	KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
> > -	KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
> > -	KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
> > +	KEY_FN_F1,	KEY_FN_F2,	KEY_FN_F3,	KEY_SLEEP,
> > +	KEY_FN_F5,	KEY_FN_F6,	KEY_FN_F7,	KEY_FN_F8,
> > +	KEY_FN_F9,	KEY_FN_F10,	KEY_FN_F11,	KEY_SUSPEND,
> 
> Again, we have keycodes for most of these and we have the ability to 
> make the driver choose the correct one by default. Why make things more 
> difficult?

Because I only map keys that are marked (silk-screened) on the keys on at
least 90% of the current models.

And I could not find the proper keycode for "switch output video port", yet.

And I could not find the proper keycode for "mess with
mouse/ultranav/pointing device config", either.  Not that this one is marked
in most thinkpads, even if it *does* have this function in almost all of
them.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
