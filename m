From: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>
Subject: Re: Re: [patch 1/1] thinkpad fn+fx key driver
Date: Mon, 27 Sep 2004 06:40:13 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040927064013.4ded0453.rddunlap@osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B300179B935@hdsmsx401.amr.corp.intel.com>
	<20040923112457.GB1083@ucw.cz>
	<20040924134118.GA467@openzaurus.ucw.cz>
	<20040924142248.GA2593@ucw.cz>
	<20040925112219.GC4039@elf.ucw.cz>
	<20040925175500.GA1798@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040925175500.GA1798-+ZI9xUNit7I@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
Cc: pavel-AlSwsSmVLrQ@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, erik-aH8aFkyL5XJBDgjK7y7TUQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 25 Sep 2004 19:55:02 +0200 Vojtech Pavlik wrote:

| On Sat, Sep 25, 2004 at 01:22:20PM +0200, Pavel Machek wrote:
| 
| > > > Having vol+/vol- keys would be  very welcome. This daemon would
| > > > have to understand scancodes for a lot of
| > > > different keyboards, but perhaps
| > > > that is easy enough to create incrementally.
| > > 
| > > The Volume+ and Volume- keys are actually pretty standardized and the
| > > kernel recognizes them out of the box on 95% of machines.
| > 
| > Hmm, yes, on my machines vol- generates ^[[26~, mute ^[[25~ and vol+ nothing.
| 
| Have you tried evtest? It might be just a keymap issue.
| 
| > > The daemon could but wouldn't have to take care of uploading the correct
| > > scancode->keycode tables to the kernel.
| > 
| > Hmm, okay. 
| > 
| > Is it possible to have somehow get both keycodes and translated keys?
| > I guess I might want to define ctrl-alt-= as vol+ and ctrl-alt-- as
| > vol- for machines that do not have hardware keys.
| 
| That's something to be handled in userspace.
| 
| > Do you have example code using event interface, somewhere?
|  
| Yes, the evtest source is a good example. It's in the inpututils RPM or
| in the linuxconsole.sf.net CVS.

And a HID events tutorial and sample code from Brad Hards:

http://www.frogmouth.net/hid-doco/linux-hid.html

http://www.frogmouth.net/hid-doco/examples/hiddev-misc/dump-events.c
http://www.frogmouth.net/hid-doco/examples/hiddev-misc/write-events.c


--
~Randy
MOTD:  Always include version info.
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
