From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Machines self-power-up with 2.6.9-rc3 (evo N620c, ASUS, ...)
Date: Thu, 21 Oct 2004 00:59:10 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041020225910.GE29863@elf.ucw.cz>
References: <20041020191531.GC21315@elf.ucw.cz> <OF014FB65F.1C41FFC8-ON49256F33.007639BA-49256F33.0079C800@jp.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <OF014FB65F.1C41FFC8-ON49256F33.007639BA-49256F33.0079C800-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hiroshi 2 Itoh <HIROIT-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> Thanks for your report. I have some suggestions to identify your
> problem and help ACPI developers to work more effectively.
> 
> The developers are working both fixing ACPI related bugs and applying
> work around for bad BIOS behaviors. At this time I think fixing
> bugs is more important than applying work around.
> 
> So if your problem on some machine is so serious, could you please
> give us the BIOS version and whether the machine suspend/resume is
> OK in ACPI mode of Windows 2000/XP too? Of course DSDT table check
> is highly helpful. http://bugzilla.kernel.org/ is prepared for such
> purpose.

I was not talking about suspend/resume here, it wakes up even after
plain /sbin/shutdown -h now. I do not have Windows here to try, but it
works well in 2.6.7... 

								Pavel

> > I'm seeing bad problem with N620c notebook (and have reports of more
> > machines behaving like this, for example ASUS L8400C.) If I shutdown
> > machine with lid closed, opening lid will power the machine up. Ouch.
> > 2.6.7 behaves okay.
> >
> > Ouch, acpi=off makes it even worse [2.6.9-rc3, N620c]. I get some very
> > strange show on the leds (battery charge led blinks fast?!), then
> > machine powers up itself. This happens even with lid initially
> > open. 2.6.7 works as expected.
> >
> > Any ideas?


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
