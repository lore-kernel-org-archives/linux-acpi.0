From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Machines self-power-up with 2.6.9-rc3 (evo N620c, ASUS,
	...)
Date: Thu, 21 Oct 2004 09:53:23 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1098323602.6132.51.camel@sli10-desk.sh.intel.com>
References: <4176FCB8.3060103@root.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-10-21 at 08:03, Nate Lawson wrote:
> Pavel Machek wrote:
> >>>I'm seeing bad problem with N620c notebook (and have reports of
> more
> >>>machines behaving like this, for example ASUS L8400C.) If I
> shutdown
> >>>machine with lid closed, opening lid will power the machine up.
> Ouch.
> >>>2.6.7 behaves okay.
> >>
> >>:> Some people would love to have the machine power up when they
> open
> >>the lid! Wish my XE3 would do that!
> 
> This problem sounds like a wake GPE is enabled for the lid switch and 
> that it has a _PRW that indicates it can wake the system from S5.  If 
> this is the case, just disabled the GPE.
> 
> > :-). Well for some other people it powers up when they unplug AC
> > power, and *that* is nasty. I'd like my machine to stay powered down
> > when I tell it so.
> 
> This is likely a similar GPE problem.  The GPE for the EC fires even
> in 
> S5.  I think the EC GPE should be disabled in the suspend method.
It could be the wakeup GPE issue, but must note Pavel's system suffer
the problem even with acpi=off. Could you please try boot your system
with acpi=off, and then reboot with acpi=off, what's the result? I
expected the wakeup GPE is disabled by the BIOS in this case.
Anyway, the DSDT can tell us the wakeup GPE info.

Thanks,
Shaohua



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
