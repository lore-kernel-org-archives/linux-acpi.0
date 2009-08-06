From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: Illuminated keyboard on ASUS U50VG laptop, backlight or led ?
Date: Thu, 6 Aug 2009 12:07:12 +0200
Message-ID: <200908061207.12450.corentin.chary@gmail.com>
References: <71cd59b00907240034m5781fc4ciea2391d5fa17f85e@mail.gmail.com>
	<9b2b86520908011243r47f39f14t3ef991180927274a@mail.gmail.com>
	<71cd59b00908020020p1f672529mf3cd403526005ed5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <hal-bounces@lists.freedesktop.org>
In-Reply-To: <71cd59b00908020020p1f672529mf3cd403526005ed5@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/hal>,
	<mailto:hal-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/hal>
List-Post: <mailto:hal@lists.freedesktop.org>
List-Help: <mailto:hal-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/hal>,
	<mailto:hal-request@lists.freedesktop.org?subject=subscribe>
Sender: hal-bounces@lists.freedesktop.org
Errors-To: hal-bounces@lists.freedesktop.org
To: Danny Kukawka <danny.kukawka@web.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, acpi4asus-user@lists.sourceforge.net, Alan Jenkins <sourcejedi.lkml@googlemail.com>, hal@lists.freedesktop.org, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sunday 02 August 2009 09:20:00 Corentin Chary wrote:
> >> see:
> >> http://cgit.freedesktop.org/~dkukawka/hal/commit/?id=c900d0e5012b1dd0e0f
> >>a6e20fd0d92a59b3de093
>
> It's not my hardware either, but I can try to create a fake
> kbd_keyboard led to test that.
>
> > Don't you also need to set "keyboard_backlight.num_levels"?  According
> > to Documentation/leds-class.txt, valid led values are 0-255, so I
> > expect num_levels should be set to 256.
>
> Valid led values are between 0 and max_brightness (like for backlight I
> think). I think the led addon should set keyboard_backlight.num_levels to
> max_brightness (+1 ?).
>
> > Yuck... I think the backlight interface is better in that it exports
> > the available granularity.  But I guess all one really wants is "on"
> > and "off", with finer adjustment being either automatic (light sensor)
> > or buried as a config option.
>
> On the Asus U50 there is 3 levels (+ off), and keys to change the
> brightness. And the user want to use all the backlight levels with the
> Fn+F3/F4 keys.

Hi Danny,
I was trying to add keyboard_backlight.num_levels support for your modified 
led-addon. But there is something I don't understand :- 
keyboard_backlight.num_levels is used in:
- examples/light_sensors_and_keyboard_backlight.py
- fdi/policy/10osvendor/10-macbookpro-utils.fdi
- kde/solid/hal/halpower.cpp
But it is not defined in doc/spec/hal-spec-properties.xml.

Should I make another patch to fix hal-spec-properties ?

Thanks,

-- 
Corentin Chary
http://xf.iksaif.net - http://uffs.org
