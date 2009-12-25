From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] sony-laptop - simplify keymap initialization
Date: Thu, 24 Dec 2009 23:01:38 -0800
Message-ID: <20091225070138.GB19401@core.coreip.homeip.net>
References: <20091224080135.11511.18604.stgit@localhost.localdomain> <20091224080222.11511.79737.stgit@localhost.localdomain> <20091224210146.GA2346@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:34866 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbZLYHBo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Dec 2009 02:01:44 -0500
Received: by pxi27 with SMTP id 27so4308386pxi.4
        for <linux-acpi@vger.kernel.org>; Thu, 24 Dec 2009 23:01:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091224210146.GA2346@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org

On Thu, Dec 24, 2009 at 07:01:46PM -0200, Henrique de Moraes Holschuh wrote:
> On Thu, 24 Dec 2009, Dmitry Torokhov wrote:
> > +	for (i = 0; i < ARRAY_SIZE(sony_laptop_input_keycode_map); i++)
> > +		__set_bit(sony_laptop_input_keycode_map[i], key_dev->keybit);
> > +	__clear_bit(KEY_RESERVED, key_dev->keybit);
> 
> Maybe:
> 
> for (i = 0; i < ARRAY_SIZE(sony_laptop_input_keycode_map); i++) {
> 	if (sony_laptop_input_keycode_map[i] != KEY_RESERVED) {
> 		input_set_capability(key_dev, EV_KEY,
> 				sony_laptop_input_keycode_map[i]);
> 	}
> }
> 
> would be better, as it means the driver doesn't poke into the inputdev
> struct innards directly?
> 

Given that you have to still poke there to set up open, close, name,
phys, id and so on and so forth I think the original is fine and that is
what most of keyboard-like drivers do.

The reason I came up with input_set_capability is because gpio-keys
wanted to set up siwtches and keys based on platform data so doing;

	for(...)
		input_set_capability(dev, pdata->type, pdata->code);

looked nice.

-- 
Dmitry
