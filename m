From: Benedek Frank <linux-mmCHBaZtUya2oZ/6fjIToQ@public.gmane.org>
Subject: ATI Rage Mobility P/M card wont post at resume, 2.6.11 kernel.
Date: Fri, 6 May 2005 18:32:17 +0900
Message-ID: <200505061832.18501.linux@celifornia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi

My Sony Vaio PCG-C1VRX can suspend and resume as well correctly, if some 
modules and PCMCIA is shut off, but when it resumes, the screen wont post 
anymore. That is funny, because even when suspended (To RAM) the screen is 
making a very slight funky noise like electric noise, and if I tilt the 
screen upward, I can see some text on the screen, so it isnt 100% shut off. 
So it uses energy more than it should even when suspended. Anyways, I can 
make it wake up by passing a boot argument to the kernel 
(/boot/grub/menu.1st) This is how the entry looks like

title           Debian GNU/Linux, kernel 2.6.11
root            (hd0,1)
kernel          /boot/vmlinuz-2.6.11 root=/dev/hda2 ro acpi_sleep=s3_bios
initrd          /boot/initrd.img-2.6.11
savedefault
boot

After doing this, the laptop wakes up about 90% of the time, and the remaining 
10% is when PCMCIA cannot be cleanly removed, so it hangs. (can be recovered 
though). Overall I am very very happy with ACPI and would like to thank to 
the developers for the great work. My only question is that is there a way to 
shut the screen completely off, so even when I am on battery and suspended, 
it would last for a long time? And, the least important is that is there a 
way to resume the screen without the kernel boot argument?

Thanks a lot

Benedek Frank


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
