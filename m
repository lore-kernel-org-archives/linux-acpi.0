From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH] GDT table patch for resume only reboots problem
Date: Mon, 18 Oct 2004 12:15:23 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041018101522.GA2816@elf.ucw.cz>
References: <OFC0526CFC.7FFB98D1-ON49256F30.0068372D-49256F30.006EF530@jp.ibm.com> <20041017230205.2e50de4c.albeclemit@yahoo.it> <20041017233819.GA13680@elf.ucw.cz> <20041018115839.6c67f6a9.albeclemit@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041018115839.6c67f6a9.albeclemit-whZMOeQn8C0@public.gmane.org>
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

> > > If I uncomment pushl and popfl it hangs(but not reboot, like going in an infinite loop) later, on
> > > 	wakeup_pmode_return:
> > > 		movw	$__KERNEL_DS, %ax
> > > 		movw	%ax, %ss           #HANGS HERE
> > > 		movw	%ax, %ds
> > 
> > Are you sure it hangs there? Your pushl $0 method to force reboot is
> > unlikely to be effective after %ss is set up properly... Which is this
> > point. [That beeping code might be handy here.]
> 
> I'm trying to use the beeping code but i get strange behavior..
> if use just a BEEP it hangs beeping forever
> if i use a  beeping loop like
> 	die:
> 		BEEP
> 		jmp die
> i don't get any sound, but it just hangs.

Hmm, I should probably not reprogram beep timer over and over and
over.

	die:
		BEEP
	die2:
		jmp die2

should do the trick.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
