From: Pavel Machek <pavel@suse.cz>
Subject: Re: [ACPI] Re: [PATCH, new ACPI driver] new sony_acpi driver
Date: Thu, 17 Feb 2005 00:18:12 +0100
Message-ID: <20050216231812.GA3865@elf.ucw.cz>
References: <20050210161809.GK3493@crusoe.alcove-fr> <E1D0dqo-00041G-00@chiark.greenend.org.uk> <20050214105837.GE3233@crusoe.alcove-fr> <20050214203211.GA8007@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214203211.GA8007@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Stelian Pop <stelian@popies.net>, Matthew Garrett <mgarrett@chiark.greenend.org.uk>, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > Related to that, I have a nastyish hack which lets the sonypi driver
> > > generate ACPI events whenever a hotkey is pressed. Despite not strictly
> > > being ACPI events, this makes it much easier to integrate sonypi stuff
> > > with general ACPI support. I'll send it if you're interested.
> > 
> > Wouldn't be more useful to make the ACPI hotkeys generate an
> > input event (like sonypi does) and integrate all this at the input
> > level ?
>  
> Yes, I'd like to see that. The other possible way is have the input
> layer generate ACPI events for power-related keys.

No; ACPI events are ugly hack. They should die, die, die....

We should probably switch even stuff like acpi power button to input
layer, etc.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
