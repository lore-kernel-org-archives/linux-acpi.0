From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: Illuminated keyboard on ASUS U50VG laptop, backlight or led ?
Date: Sun, 2 Aug 2009 09:20:00 +0200
Message-ID: <71cd59b00908020020p1f672529mf3cd403526005ed5@mail.gmail.com>
References: <71cd59b00907240034m5781fc4ciea2391d5fa17f85e@mail.gmail.com>
	<71cd59b00908010850w1e9b4d6p733481a4fba892e7@mail.gmail.com>
	<9b2b86520908010930n4b47c6c2uc5608ae7d81b0b6b@mail.gmail.com>
	<200908011921.23990.danny.kukawka@web.de>
	<9b2b86520908011243r47f39f14t3ef991180927274a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <hal-bounces@lists.freedesktop.org>
In-Reply-To: <9b2b86520908011243r47f39f14t3ef991180927274a@mail.gmail.com>
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

>> see:
>> http://cgit.freedesktop.org/~dkukawka/hal/commit/?id=3Dc900d0e5012b1dd0e=
0fa6e20fd0d92a59b3de093

It's not my hardware either, but I can try to create a fake
kbd_keyboard led to test that.

> Don't you also need to set "keyboard_backlight.num_levels"? =A0According
> to Documentation/leds-class.txt, valid led values are 0-255, so I
> expect num_levels should be set to 256.

Valid led values are between 0 and max_brightness (like for backlight I thi=
nk).
I think the led addon should set keyboard_backlight.num_levels to
max_brightness (+1 ?).

> Yuck... I think the backlight interface is better in that it exports
> the available granularity. =A0But I guess all one really wants is "on"
> and "off", with finer adjustment being either automatic (light sensor)
> or buried as a config option.

On the Asus U50 there is 3 levels (+ off), and keys to change the brightnes=
s.
And the user want to use all the backlight levels with the Fn+F3/F4 keys.



-- =

Corentin Chary
http://xf.iksaif.net - http://uffs.org
