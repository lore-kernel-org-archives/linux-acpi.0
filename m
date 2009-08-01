From: Danny Kukawka <danny.kukawka@web.de>
Subject: Re: Illuminated keyboard on ASUS U50VG laptop, backlight or led ?
Date: Sat, 1 Aug 2009 15:21:16 +0200
Message-ID: <200908011521.19672.danny.kukawka@web.de>
References: <71cd59b00907240034m5781fc4ciea2391d5fa17f85e@mail.gmail.com>
	<4A7424A6.5080703@tuffmail.co.uk>
	<71cd59b00908010540q2758ebc0xdae2a64dacad3fec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <hal-bounces@lists.freedesktop.org>
In-Reply-To: <71cd59b00908010540q2758ebc0xdae2a64dacad3fec@mail.gmail.com>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, acpi4asus-user@lists.sourceforge.net, linux acpi <linux-acpi@vger.kernel.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Corentin Chary <corentin.chary@gmail.com>, Henrik Rydberg <rydberg@euromail.se>
List-Id: linux-acpi@vger.kernel.org

On Samstag, 1. August 2009, Corentin Chary wrote:
> Maybe just *:kbd_backlight . The naming scheme is vendor:color:name
> The problem is that hald-addon-generic-kbd-backlight is not merged
> upstream.
>
> So, hal mailing list is now CC'ed
> Is there any plan to merge hald-addon-generic-kbd-backlight ?
> Patch can be found here:
> http://lists.freedesktop.org/archives/hal/2008-October/012361.html

This patch is not needed. There is a generic addon for the leds subsystem in 
HAL.

Check out: 
http://people.freedesktop.org/~dkukawka/hal-spec-git/hal-spec.html#interface-device-leds

If there is any problem with this addon, let me know.

Danny
