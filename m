From: Benedek Frank <linux-mmCHBaZtUya2oZ/6fjIToQ@public.gmane.org>
Subject: Suspend to RAM works, but no wake up. ATI Technologies Inc Rage
 Mobility P/M (rev 64) video card
Date: Sun, 26 Jun 2005 09:57:08 +0200
Message-ID: <20050626095708.3649fdff.linux@celifornia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Resent-To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Resent-Message-Id: <20050626101823.324a1ac4.linux-mmCHBaZtUya2oZ/6fjIToQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi

On my Sony Vaio laptop (PCG-C1VRX/K picturebook) I use kernel 2.6.11. I
am on Debian Sarge. When I suspend, the laptop suspends just fine,
unloads everything it can, what it cannot, I included in the script to
force to unload, and it sleeps very fine when I close the lid. First
issue, it wont wake up when I open the lid, only when I press a button.
Second issue is that it wont come back to live even after button
pressed, except if I give a boot pharameter to GRUB as follows

acpi_sleep=s3_bios

Now my Grub entry looks like this:

title           Debian GNU/Linux, kernel 2.6.11 
root            (hd0,1)
kernel          /boot/vmlinuz-2.6.11 root=/dev/hda2 ro
acpi_sleep=s3_bios initrd          /boot/initrd.img-2.6.11
savedefault
boot

When I use this option, it does wake up when I hit a key. However, while
asleep, the screen isnt completely off. I can hear a buzzing sound,
very soflty, but I can definetally hear it. Also, when I open the
lid, (it wont wake up yet, only on button press) I can see some text on
the screen if I tilt it in the right angle. THe LCD seems off, but it
does has some text on it, so it cannot be off, just dimmed to a maximum.
ANd the buzzing sound gives it also away. I left the machine suspended
at 33% battery yesterday at 2AM, and by 7AM when I woke up, the battery
was dead, and the laptop shut down. Usually 33% gives me 40 mintues of
work time, I think it should have lasted for a 5 hours suspension, no?

Thanks for any help

Benedek


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
