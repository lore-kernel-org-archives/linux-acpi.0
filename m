From: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Subject: Soundcard malfunction after suspend/resume cycle
Date: Fri, 18 Nov 2005 08:44:56 +0100
Message-ID: <20051118074456.GA18225@tangens.sinus.cz>
Reply-To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi!
  My notebook (Clevo D610SU aka Mironet) exhibits the following problem: 
  When suspended and resumed, either to RAM or to disk, when a sound is played
during the suspension, it has problems to continue after resume. Direct access
to soundcard (either ALSA or OSS emulation) obviously causes the playing
program (mp3blaster, xmms) to either crash or not to continue playing until
at least the song is reselected. With artsd from KDE, the sound continues to
play, but artsd eats almost all CPU cycles, the sound is choppy, even a small
action like window moving causes drops and interruptions, and artsd finally
detects system overload and kills itself.
  Reopening the sound device (restarting artsd/playing program) restores
normal functionality.
  I'm not sure whethere it is an ACPI related thing or the soundcard driver
bug, so I'm asking here for some help, what to do next to debug the thing.
  It's on 2.6.13.
  The card is reported by lspci as
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Sound Controller (rev a0)
  It is using the intel 8x0 driver.
  dmesg says about it:
PCI: Enabling device 0000:00:02.7 (0000 -> 0001)
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:02.7[C] -> Link [LNKF] -> GSI 10 (level, low) -> IRQ 10
intel8x0_measure_ac97_clock: measured 50410 usecs
intel8x0: clocking to 48000
  By repeatedly reading /proc/interrupts it seems that the card generates much
more interrupts in its bad state than is normal, but I didn't make any exact
measurements.
  Any help would be appreciated.
                         With regards, Pavel Troller


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
