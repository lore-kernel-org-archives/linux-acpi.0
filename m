From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Re: [patch 1/1] thinkpad fn+fx key driver
Date: Tue, 28 Sep 2004 12:06:18 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040928100617.GB916@elf.ucw.cz>
References: <F7DC2337C7631D4386A2DF6E8FB22B300179B935@hdsmsx401.amr.corp.intel.com> <20040923112457.GB1083@ucw.cz> <20040924134118.GA467@openzaurus.ucw.cz> <20040924142248.GA2593@ucw.cz> <87acvak912.wl%miura@da-cha.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87acvak912.wl%miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
Cc: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, akpm-3NddpPZAyC0@public.gmane.org, erik-aH8aFkyL5XJBDgjK7y7TUQ@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > > There are several ways to make both the keyboard and ACPI keys work as
> > > > intended:
> <snip>
> > > > 4) Change ACPI to use the Input API and have a daemon that handles
> > > >    all extra keys, including sound volume and application keys, possibly
> > > >    using D-bus to send the events to the desktop environment.
> > > 
> > > I like this one.
> > > 
> 
> I like this one, too. But we can modify only hotkey drivers to
> suport it.

I do not understand. Are there keys that can not be fit into input api? 

> > > Having vol+/vol- keys would be  very welcome. This daemon would
> > > have to understand scancodes for a lot of
> > > different keyboards, but perhaps
> > > that is easy enough to create incrementally.
> > 
> > The Volume+ and Volume- keys are actually pretty standardized and the
> > kernel recognizes them out of the box on 95% of machines.
> 
> My new panasonic acpi hotkey driver suports Input API.
> If you hit hotkey, then you can get both acpi event and hotkey event.
> 
> Acpid scirpt handle event like hibernation, video sw.
> hotkey utility eg) hotkeys handles vol+/-, mute, etc.
> 
> you can get driver and hotkeys confguration from http://www.da-cha.org/letsnote/

Where do I get "hotkeys"?
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
