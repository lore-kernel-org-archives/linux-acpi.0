From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Machines self-power-up with 2.6.9-rc3 (evo N620c, ASUS, ...)
Date: Thu, 21 Oct 2004 12:19:37 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041021101937.GD21373@elf.ucw.cz>
References: <20041020191531.GC21315@elf.ucw.cz> <1098311478.4989.100.camel@desktop.cunninghams> <20041020225639.GD29863@elf.ucw.cz> <4176FCB8.3060103@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4176FCB8.3060103-Y6VGUYTwhu0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> >>>I'm seeing bad problem with N620c notebook (and have reports of more
> >>>machines behaving like this, for example ASUS L8400C.) If I shutdown
> >>>machine with lid closed, opening lid will power the machine up. Ouch.
> >>>2.6.7 behaves okay.
> >>
> >>:> Some people would love to have the machine power up when they open
> >>the lid! Wish my XE3 would do that!
> 
> This problem sounds like a wake GPE is enabled for the lid switch and 
> that it has a _PRW that indicates it can wake the system from S5.  If 
> this is the case, just disabled the GPE.

I tried disabling all events in /proc/acpi/wakeup, and that did not
change anything.

> >:-). Well for some other people it powers up when they unplug AC
> >power, and *that* is nasty. I'd like my machine to stay powered down
> >when I tell it so.
> 
> This is likely a similar GPE problem.  The GPE for the EC fires even in 
> S5.  I think the EC GPE should be disabled in the suspend method.

How did this hangling changed between 2.6.7 and 2.6.9?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
