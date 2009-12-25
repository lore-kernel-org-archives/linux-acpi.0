From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 2/3] sony-laptop - simplify keymap initialization
Date: Fri, 25 Dec 2009 11:38:12 -0200
Message-ID: <20091225133812.GB5891@khazad-dum.debian.net>
References: <20091224080135.11511.18604.stgit@localhost.localdomain>
 <20091224080222.11511.79737.stgit@localhost.localdomain>
 <20091224210146.GA2346@khazad-dum.debian.net>
 <20091225070138.GB19401@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57535 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752074AbZLYNiP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Dec 2009 08:38:15 -0500
Content-Disposition: inline
In-Reply-To: <20091225070138.GB19401@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org

On Thu, 24 Dec 2009, Dmitry Torokhov wrote:
> On Thu, Dec 24, 2009 at 07:01:46PM -0200, Henrique de Moraes Holschuh wrote:
> > On Thu, 24 Dec 2009, Dmitry Torokhov wrote:
> > > +	for (i = 0; i < ARRAY_SIZE(sony_laptop_input_keycode_map); i++)
> > > +		__set_bit(sony_laptop_input_keycode_map[i], key_dev->keybit);
> > > +	__clear_bit(KEY_RESERVED, key_dev->keybit);
> > 
> > Maybe:
> > 
> > for (i = 0; i < ARRAY_SIZE(sony_laptop_input_keycode_map); i++) {
> > 	if (sony_laptop_input_keycode_map[i] != KEY_RESERVED) {
> > 		input_set_capability(key_dev, EV_KEY,
> > 				sony_laptop_input_keycode_map[i]);
> > 	}
> > }
> > 
> > would be better, as it means the driver doesn't poke into the inputdev
> > struct innards directly?
> 
> Given that you have to still poke there to set up open, close, name,
> phys, id and so on and so forth I think the original is fine and that is
> what most of keyboard-like drivers do.

Never liked that much, either :-)

> The reason I came up with input_set_capability is because gpio-keys
> wanted to set up siwtches and keys based on platform data so doing;
> 
> 	for(...)
> 		input_set_capability(dev, pdata->type, pdata->code);
> 
> looked nice.

I see.  Well, it is a matter of differing tastes I think (none of them bad,
just different).

That said, is KEY_RESERVED bit left set a common error?  If it is, maybe it
make sense to __clear_bit it inside of input_register_device() just in case?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
