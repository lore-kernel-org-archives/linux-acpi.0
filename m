From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Re: S3 resume on Fujitsu-Siemens Amilo A7620 (CONTINUES)
Date: Tue, 19 Oct 2004 01:00:08 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041018230008.GC10490@elf.ucw.cz>
References: <20041018134238.4cf1b380.albeclemit@yahoo.it> <20041018124756.GA28463@elf.ucw.cz> <20041018225412.397dcd1f.albeclemit@yahoo.it> <20041018212208.GA10490@elf.ucw.cz> <20041019002115.2faa9436.albeclemit@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041019002115.2faa9436.albeclemit-whZMOeQn8C0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alberto Piai <albeclemit-whZMOeQn8C0@public.gmane.org>
Cc: HIROIT-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > So now it's going out of wakeup.S, right?
> > 
> > Good.
> > 
> > > We should be in drivers/acpi/sleep/main.c at that point
> > 
> > Yes. I assume that video does not work for you? Do you see at least
> > blinking cursor?
> > 
> > ...hmm, problem is that normal video calls really require stack. Very
> > bad.
>  
> Hey. Some messages ago we got to the point were stack was properly initialized, so i couldn't use pushl anymore to debug. That was on
> [...]
> wakeup_pmode_return:
> 	movw	$__KERNEL_DS, %ax
> 	movw	%ax, %ss
> 	movw	%ax, %ds
> [...]
> 
> could we try to run video code after that?

We can't call video bios from protected mode, sorry. If machine comes
up with all devices working (try capslock) but video, you should be
able to reinitialize video using emu from X11 or some other hack.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
