From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: FYI: ACPI 'sleep 1' resets atkbd keycodes
Date: Tue, 3 Feb 2004 14:27:01 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401CBB669@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
content-class: urn:content-classes:message
To: Dmitry Torokhov <dtor_core@ameritech.net>, Vojtech Pavlik <vojtech@suse.cz>, "P. Christeas" <p_christ@hol.gr>
Cc: acpi-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

> > > This may be just a minor issue:
> > > I had to use the setkeycodes utility to enable some extra 
> keys (that
> > > weren't mapped by kernel's atkbd tables).
> > > After waking from sleep 1, those keys were reset. That 
> is, I had to
> > > use 'setkeycodes' again to customize the tables again.
> > >
> > > IMHO the way kernel works now is correct. It should *not* 
> have extra
> > > code just to handle that. Just make sure anybody that 
> alters his kbd
> > > tables puts some extra script to recover the tables after an ACPI
> > > wake.
> > > This should be more like a note to Linux distributors.
> > >
> > > Have a nice day.

Do you need a event through /proc/acpi/event that can notify userland of
resuming happend,
And let userland app have chance to invoke setkeycode, and other similar
things.

> -	/*
> -	 * Here we probably should check if the keyboard has 
> the same set that
> -         * it had before and bail out if it's different. But 
> this will most likely
> -         * cause new keyboard device be created... and for 
> the user it will look
> -         * like keyboard is lost
> -	 */
> +	if (atkbd->set != old_set) {
> +		/*
> +		 * ok, we woke up with a different keyboard 
> attached. Alhtough we could just
> +		 * signal failure it's not very nice as it will 
> most likely cause new keyboard
> +		 * device be created... and for the user it 
> will look like keyboard is lost.
> +		 */
> +		atkbd_set_name(atkbd);

Is it correct to think if the keyboard has the different set that it
had before , then keyboard has been replaced, without considering
it could be changed by setkeycode.

--Luming
