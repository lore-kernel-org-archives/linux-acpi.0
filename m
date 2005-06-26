From: Benedek Frank <linux-mmCHBaZtUya2oZ/6fjIToQ@public.gmane.org>
Subject: Re: Suspend to RAM works, but no wake up. ATI Technologies
 Inc Rage Mobility P/M (rev 64) video card
Date: Sun, 26 Jun 2005 22:18:17 +0200
Message-ID: <20050626221817.73a2d755.linux@celifornia.com>
References: <20050626095708.3649fdff.linux@celifornia.com>
	<1119775316.19781.13.camel@sponge.fungus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1119775316.19781.13.camel-7g89Hwo0MwsWlyYapE9R8Q@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 26 Jun 2005 10:41:56 +0200
Henrik Brix Andersen <brix-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org> wrote:

> On Sun, 2005-06-26 at 09:57 +0200, Benedek Frank wrote:
> > When I use this option, it does wake up when I hit a key. However,
> > while asleep, the screen isnt completely off. I can hear a buzzing
> > sound, very soflty, but I can definetally hear it. Also, when I open
> > the lid, (it wont wake up yet, only on button press) I can see some
> > text on the screen if I tilt it in the right angle. THe LCD seems
> > off, but it does has some text on it, so it cannot be off, just
> > dimmed to a maximum. ANd the buzzing sound gives it also away. I
> > left the machine suspended at 33% battery yesterday at 2AM, and by
> > 7AM when I woke up, the battery was dead, and the laptop shut down.
> > Usually 33% gives me 40 mintues of work time, I think it should have
> > lasted for a 5 hours suspension, no?
> 
> I have an IBM ThinkPad X31 (2672-XXH), also with a ATI Radeon (ATI
> Technologies Inc Radeon Mobility M6 LY).
> 
> While I do not get the high pitched noise, I do see the problem with
> the LCD backlight not powering off during S3. I have to use radeontool
> [1] to power off the LCD backlight before going into S3 and reverse
> this procedure when the laptop wakes up from S3.
> 
> Perhaps the in-kernel radeonfb driver could be modified to allow
> powering down the LCD backlight before entering S3?
> 
Hi

I am not sure that my card is a radeon. Mine should be a Rage P/M
Mobility, therefore not radeon? I am not an expert. I went ahead and
downloaded the radeon tool. WHen I just pass the command "radeontool" I
get this
vaio:/home/ben# radeontool 
usage: radeontool [options] [command]
         --debug            - show a little debug info
         --skip=1           - use the second radeon card
         dac [on|off]       - power down the external video outputs (on)
         light [on|off]     - power down the backlight (on)
         stretch [on|off|vert|horiz|auto|manual]   - stretching for
resolution mismatch          regs               - show a listing of some
random registers

This shows that light is on. So I pass this command "radeontool light
off" and then rerun "radeontool" as it is, and get this:
vaio:/home/ben# radeontool
usage: radeontool [options] [command]
         --debug            - show a little debug info
         --skip=1           - use the second radeon card
         dac [on|off]       - power down the external video outputs (on)
         light [on|off]     - power down the backlight (off)
         stretch [on|off|vert|horiz|auto|manual]   - stretching for
resolution mismatch          regs               - show a listing of some
random register

THis shows that light is off, but it isnt as I am typing now, and
nothing changed since I ran the radeontool.

When I run the same command with debug I get this "radeontool --debug
light off"

vaio:/home/ben# radeontool --debug light off
0000:00:0d.0 VGA compatible controller: ATI Technologies Inc Rage
Mobility P/M (rev 64) (prog-if 00 [VGA])        Subsystem: Sony
Corporation: Unknown device 80af        Flags: bus master, stepping,
medium devsel, latency 66, IRQ 9        Memory at fd000000 (32-bit,
non-prefetchable) [size=16M]        I/O ports at 1400 [size=256]
        Memory at fc105000 (32-bit, non-prefetchable) [size=4K]
Radeon found. Base control address is fc105000.
reading RADEON_LVDS_GEN_CNTL (2d0) is 00e8fd3c
writing RADEON_LVDS_GEN_CNTL (2d0) -> 00e8fd3c

It says that "Radeon found", but nothing changes with my backlight. Can
someone explain?

Thanks

Ben





> Sincerely,
> Brix
> [1]: http://fdd.com/software/radeon/
> -- 
> Henrik Brix Andersen <brix-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
> Gentoo Metadistribution | Mobile computing herd
> 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
