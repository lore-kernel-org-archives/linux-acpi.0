From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: S3 broken on a Samsung P30
Date: Thu, 11 Nov 2004 00:18:03 +0100
Message-ID: <20041110231802.GA1099@elf.ucw.cz>
References: <1099605010.5191.20.camel@mhcln03>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1099605010.5191.20.camel@mhcln03>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I've been trying for some time now to get S3 working on my laptop.
> It suspends just fine with 
> 
> echo 3 > /proc/acpi/sleep
> and
> echo -n mem > /sys/power/state
> 
> but it never wakes up. The screen stays dark and the keyboard
> (CAPSLOCK/NUMLOCK) doesn't work. Trying to blindly execute programs in
> the console also fails.
> The only thing which seems to wake up is the DVD drive, which spins up
> after a resume, but that's about it.
> 
> Since the display stays dark, (no back-light, totally dead) I've
> connected and configured a serial console. Sadly, it appears that the
> serial port doesn't wake up either....
> 
> On a resume i get 2 to 10 chars of random garbage on the serial console,
> nothing else (it works perfectly when the latop is running)

See recent threads of adding beeping to begining of wakeup.S. Does it
beep for you?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
