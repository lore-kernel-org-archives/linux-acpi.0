From: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Re: [patch 1/1] thinkpad fn+fx key driver
Date: Fri, 24 Sep 2004 16:22:48 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040924142248.GA2593@ucw.cz>
References: <F7DC2337C7631D4386A2DF6E8FB22B300179B935@hdsmsx401.amr.corp.intel.com> <20040923112457.GB1083@ucw.cz> <20040924134118.GA467@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040924134118.GA467-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, akpm-3NddpPZAyC0@public.gmane.org, erik-aH8aFkyL5XJBDgjK7y7TUQ@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Sep 24, 2004 at 03:41:18PM +0200, Pavel Machek wrote:
> Hi!
> 
> > There are several ways to make both the keyboard and ACPI keys work as
> > intended:
> > 
> > 1) Extend acpid to listen on all /dev/input/event keyboard devices and
> >    call scripts when the keys are pressed. No change to the kernel.
> > 
> > 2) Change ACPI to use the Input API, and add possibility to map ACPI
> >    events in the keymap. Then have acpid listen to those.
> > 
> > 3) Change ACPI to use the Input API and use the power.ko module for
> >    mapping the keys to system state change actions.
> > 
> > 4) Change ACPI to use the Input API and have a daemon that handles
> >    all extra keys, including sound volume and application keys, possibly
> >    using D-bus to send the events to the desktop environment.
> 
> I like this one.
> 
> Having vol+/vol- keys would be  very welcome. This daemon would
> have to understand scancodes for a lot of
> different keyboards, but perhaps
> that is easy enough to create incrementally.

The Volume+ and Volume- keys are actually pretty standardized and the
kernel recognizes them out of the box on 95% of machines.

The daemon could but wouldn't have to take care of uploading the correct
scancode->keycode tables to the kernel.

> Hmm, the same daemon might know enough about machine's sound system
> (on notebooks for example; to be able to setup initial mixer levels.

I think it's pretty simple to leave that to the user. 'alsactl restore'
on each boot then does the job pretty well. (Namely, if you _don't_ do
'alsactl store' on each shutdown.)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
