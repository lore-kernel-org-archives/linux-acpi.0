From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] sony-laptop - simplify keymap initialization
Date: Tue, 29 Dec 2009 20:12:27 -0800
Message-ID: <20091230041227.GB2186@core.coreip.homeip.net>
References: <20091224080135.11511.18604.stgit@localhost.localdomain>
 <20091224080222.11511.79737.stgit@localhost.localdomain>
 <20091224210146.GA2346@khazad-dum.debian.net>
 <20091225070138.GB19401@core.coreip.homeip.net>
 <20091225133812.GB5891@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:46111 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbZL3EMd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Dec 2009 23:12:33 -0500
Received: by pzk1 with SMTP id 1so3847330pzk.33
        for <linux-acpi@vger.kernel.org>; Tue, 29 Dec 2009 20:12:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091225133812.GB5891@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org

On Fri, Dec 25, 2009 at 11:38:12AM -0200, Henrique de Moraes Holschuh wrote:
> On Thu, 24 Dec 2009, Dmitry Torokhov wrote:
> > On Thu, Dec 24, 2009 at 07:01:46PM -0200, Henrique de Moraes Holschuh wrote:
> > > On Thu, 24 Dec 2009, Dmitry Torokhov wrote:
> > > > +	for (i = 0; i < ARRAY_SIZE(sony_laptop_input_keycode_map); i++)
> > > > +		__set_bit(sony_laptop_input_keycode_map[i], key_dev->keybit);
> > > > +	__clear_bit(KEY_RESERVED, key_dev->keybit);
> > > 
> > > Maybe:
> > > 
> > > for (i = 0; i < ARRAY_SIZE(sony_laptop_input_keycode_map); i++) {
> > > 	if (sony_laptop_input_keycode_map[i] != KEY_RESERVED) {
> > > 		input_set_capability(key_dev, EV_KEY,
> > > 				sony_laptop_input_keycode_map[i]);
> > > 	}
> > > }
> > > 
> > > would be better, as it means the driver doesn't poke into the inputdev
> > > struct innards directly?
> > 
> > Given that you have to still poke there to set up open, close, name,
> > phys, id and so on and so forth I think the original is fine and that is
> > what most of keyboard-like drivers do.
> 
> Never liked that much, either :-)
> 
> > The reason I came up with input_set_capability is because gpio-keys
> > wanted to set up siwtches and keys based on platform data so doing;
> > 
> > 	for(...)
> > 		input_set_capability(dev, pdata->type, pdata->code);
> > 
> > looked nice.
> 
> I see.  Well, it is a matter of differing tastes I think (none of them bad,
> just different).
> 
> That said, is KEY_RESERVED bit left set a common error?  If it is, maybe it
> make sense to __clear_bit it inside of input_register_device() just in case?
> 

Something like below?

-- 
Dmitry


Input: automatically reset KEY_RESERVED bit for all input devices

KEY_RESERVED is not supposed to be reported to userspace but rather to
mark unused entries in keymaps.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/input.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)


diff --git a/drivers/input/input.c b/drivers/input/input.c
index ab06071..910d7be 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -613,12 +613,12 @@ static int input_default_setkeycode(struct input_dev *dev,
 		}
 	}
 
-	clear_bit(old_keycode, dev->keybit);
-	set_bit(keycode, dev->keybit);
+	__clear_bit(old_keycode, dev->keybit);
+	__set_bit(keycode, dev->keybit);
 
 	for (i = 0; i < dev->keycodemax; i++) {
 		if (input_fetch_keycode(dev, i) == old_keycode) {
-			set_bit(old_keycode, dev->keybit);
+			__set_bit(old_keycode, dev->keybit);
 			break; /* Setting the bit twice is useless, so break */
 		}
 	}
@@ -676,6 +676,9 @@ int input_set_keycode(struct input_dev *dev, int scancode, int keycode)
 	if (retval)
 		goto out;
 
+	/* Make sure KEY_RESERVED did not get enabled. */
+	__clear_bit(KEY_RESERVED, dev->keybit);
+
 	/*
 	 * Simulate keyup event if keycode is not present
 	 * in the keymap anymore
@@ -1513,13 +1516,16 @@ int input_register_device(struct input_dev *dev)
 	const char *path;
 	int error;
 
+	/* Every input device generates EV_SYN/SYN_REPORT events. */
 	__set_bit(EV_SYN, dev->evbit);
 
+	/* KEY_RESERVED is not supposed to be transmitted to userspace. */
+	__clear_bit(KEY_RESERVED, dev->keybit);
+
 	/*
 	 * If delay and period are pre-set by the driver, then autorepeating
 	 * is handled by the driver itself and we don't do it in input.c.
 	 */
-
 	init_timer(&dev->timer);
 	if (!dev->rep[REP_DELAY] && !dev->rep[REP_PERIOD]) {
 		dev->timer.data = (long) dev;
