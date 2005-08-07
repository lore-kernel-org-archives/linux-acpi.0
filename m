From: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Subject: Problem suspending ASUS A7V8X based desktop
Date: Sun, 7 Aug 2005 08:25:25 +0200
Message-ID: <20050807062525.GA17750@tangens.sinus.cz>
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
  I have a desktop machine based on ASUS A7V8X motherboard. This one exhibits
strange behaviour when trying to suspend either to RAM or to DISK: Immediately
after writing an activation entry to /proc/acpi/sleep, the system seems to 
perform a kind of "periphery reset" - the screen goes blank (stops generating
video, the monitor shuts itself down), hard disks stop etc. After a short while,
hard disk starts (probably the one necessary for writting the swap in the case
of STD), but the video card remains dead. The system then enters the required
suspend state.
  The problems start after resuming: For example, when resuming from STD, all
goes well, I can see how the swap image is loaded, interrupts restored etc., 
but immediately before the end of resume, screen blanks again and remains dead.
There is no way to restore it (including switching between X and text console).
I think that it somewhat remembers its incorrect state into which it's put
at the beginning of the suspend and returns to it.
  With STR, there is even a BIOS feature to run VGA BIOS on resume, so
no s3_bios is necessary in Linux, but after a very short period of display
activity it is lost too.
  Video card used:
01:00.0 VGA compatible controller: nVidia Corporation NV31 [GeForce FX 5600] (rev a1)
operated with Nvidia driver (build 7667). This drivers seems to be PM-aware.
Happens identically on all the recent kernels including 2.6.13-rc5.
  Any ideas ?
                       With regards, Pavel Troller


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
