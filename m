From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Re: S3 resume on Fujitsu-Siemens Amilo A7620 (CONTINUES)
Date: Thu, 28 Oct 2004 01:47:12 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041027234712.GG20716@elf.ucw.cz>
References: <20041018134238.4cf1b380.albeclemit@yahoo.it> <20041018124756.GA28463@elf.ucw.cz> <20041018225412.397dcd1f.albeclemit@yahoo.it> <20041018212208.GA10490@elf.ucw.cz> <20041019002115.2faa9436.albeclemit@yahoo.it> <20041018230008.GC10490@elf.ucw.cz> <20041028004424.1b0f95fb.albeclemit@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041028004424.1b0f95fb.albeclemit-whZMOeQn8C0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alberto Piai <albeclemit-whZMOeQn8C0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > > > So now it's going out of wakeup.S, right?
> 
> > > > > We should be in drivers/acpi/sleep/main.c at that point
> > > > 
> > > > Yes. I assume that video does not work for you? Do you see at least
> > > > blinking cursor?
> > > > 
> 
> > We can't call video bios from protected mode, sorry. If machine comes
> > up with all devices working (try capslock) but video, you should be
> > able to reinitialize video using emu from X11 or some other hack.
> 
> Update:
> 2.6.9, with pushl and popl lines commented out:
> the machine survives wakeup.S, then hangs with the hard disk light on. CapsLock is working, but Ctrl+Alt+Del doesn't reboot (if i keep it pressed for some seconds it generates a beep.)
> 
> I still didn't find a way to debug it, please help me! At which point should we be if harddisk was (kind of) turned on?

Remap capslock to, say, right shift, and try to see if right shift
toggles leds after resume.

If it does, try to find out if serial or network card is working after
resume.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
