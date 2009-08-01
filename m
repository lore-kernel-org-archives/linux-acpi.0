From: Danny Kukawka <danny.kukawka@web.de>
Subject: Re: Illuminated keyboard on ASUS U50VG laptop, backlight or led ?
Date: Sat, 1 Aug 2009 19:21:22 +0200
Message-ID: <200908011921.23990.danny.kukawka@web.de>
References: <71cd59b00907240034m5781fc4ciea2391d5fa17f85e@mail.gmail.com>
	<71cd59b00908010850w1e9b4d6p733481a4fba892e7@mail.gmail.com>
	<9b2b86520908010930n4b47c6c2uc5608ae7d81b0b6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <hal-bounces@lists.freedesktop.org>
In-Reply-To: <9b2b86520908010930n4b47c6c2uc5608ae7d81b0b6b@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/hal>,
	<mailto:hal-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/hal>
List-Post: <mailto:hal@lists.freedesktop.org>
List-Help: <mailto:hal-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/hal>,
	<mailto:hal-request@lists.freedesktop.org?subject=subscribe>
Sender: hal-bounces@lists.freedesktop.org
Errors-To: hal-bounces@lists.freedesktop.org
To: hal@lists.freedesktop.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, acpi4asus-user@lists.sourceforge.net, Alan Jenkins <sourcejedi.lkml@googlemail.com>, Corentin Chary <corentin.chary@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Samstag, 1. August 2009, Alan Jenkins wrote:
> On 8/1/09, Corentin Chary <corentin.chary@gmail.com> wrote:
[...]
> >
> > It seems there is also a KeyboardBacklight interface which is what we
> > want, but I didn't find how to use it
> > without an addon (like addon-macbookpro-backlight).
>
> But if you look at the methods, they are exactly the same, right? 

Yes, they are.

> I 
> think the idea is to use an FDI file to match our LED device (or
> possibly create it as a hal device... I'm still really fuzzy on hal),
> and then mark it as having the "keyboard_backlight" capability.

No, it wouldn't work this way. At least not with the current key.

I changed the led addon in my repo to check if a led has 
leds.function=kbd_backlight and provide then the 
org.freedesktop.Hal.Device.KeyboardBacklight interface instead of
org.freedesktop.Hal.Device.Leds. Please check if this helps.

see: 
http://cgit.freedesktop.org/~dkukawka/hal/commit/?id=c900d0e5012b1dd0e0fa6e20fd0d92a59b3de093

[...]
> > I believe that we need a keyboard backlight addon that respond to
> > KEY_KBDILLUM*
> > and update the corresponding /sys/class/vendor:color:kbd_backlight.
>
> Oops, thats not the addons job.  It's for something like the gnome
> power manager.  It looks like g-p-m already picks up the device with a
> "keyboard_backlight" capability, and react to keyboard brightness key
> events.

Correct. It's not the job of the addon to react on keyevents. This is up to a 
desktop application which listen to the events and call then the interface. 
The same way it work for e.g. the brightness of your laptop panel.

Danny
