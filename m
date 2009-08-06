From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: Illuminated keyboard on ASUS U50VG laptop, backlight or led ?
Date: Thu, 6 Aug 2009 19:00:32 +0200
Message-ID: <71cd59b00908061000t4a4aefd7na0bdb081f14e5594@mail.gmail.com>
References: <71cd59b00907240034m5781fc4ciea2391d5fa17f85e@mail.gmail.com>
	<200908061248.40340.danny.kukawka@web.de>
	<71cd59b00908060459y56448912od7f8914f3b44de0e@mail.gmail.com>
	<200908061820.23412.danny.kukawka@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <hal-bounces@lists.freedesktop.org>
In-Reply-To: <200908061820.23412.danny.kukawka@web.de>
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

On Thu, Aug 6, 2009 at 6:20 PM, Danny Kukawka<danny.kukawka@web.de> wrote:
> On Donnerstag, 6. August 2009, Corentin Chary wrote:
>> On Thu, Aug 6, 2009 at 12:48 PM, Danny Kukawka<danny.kukawka@web.de> wrote:
> [...]
>> > Can you please provide a "grep . */*" from /sys/class/leds/ with the
>> > affected device? If I read the kernel doc for leds (which this device
>> > is), we don't need a num_levels for it:
>> >
>> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f
>> >=Documentation/leds-class.txt;h=6399557cdab3d6542a0feea0c0cd2c6b2af5ffad;h
>> >b=HEAD
>> >
>> > "... The brightness file will set the brightness of the LED (taking a
>> > value 0-255). Most LEDs don't have hardware brightness support so will
>> > just be turned on for non-zero brightness settings. ..."
>>
>> The documentation is probably out of date, the led class provide
>> a max_brightness file. 255 is the default value, but it can be overridden.
>>
>> See:
>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=d
>>rivers/leds/led-class.c;h=f2cc13d76810f457c752d6f92f53759980f465ea;hb=HEAD#l
>>76
>>
>> leds-dac124s085.c define it to 0xFFF for example.
>> And asus-laptop will soon use 3 as max_brightness for asus::kbd_backlight.
>>
>> But still, it seems that examples/light_sensors_and_keyboard_backlight.py
>> and others are using something that is not defined in hal-spec-properties.
>
> Thanks for the information. Please check out my latest commits:
> http://cgit.freedesktop.org/~dkukawka/hal/log/
>
> I hope this finally solve the problem.

It seems ok, I'll try it ASAP and report any problem.

I'll also write Documentation/ABI/testing/sysfs-class-{led-backlight-lcd} and
update Documentation/led-class.txt to avoid any confusion.

Thanks,
-- 
Corentin Chary
http://xf.iksaif.net - http://uffs.org
