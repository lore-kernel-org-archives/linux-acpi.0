From: Daniel Gryniewicz <dang-i4I+0k6VHanR7s880joybQ@public.gmane.org>
Subject: Re: [ACPI][2.6.10-rc3][SUSPEND] S3 mode - Cannot resume
	from PCI devices
Date: Tue, 14 Dec 2004 10:55:17 -0500
Message-ID: <1103039717.10857.53.camel@athena.fprintf.net>
References: <200412100315.21725.shawn.starr@rogers.com>
	 <20041214110648.GA2291@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041214110648.GA2291-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-12-14 at 12:06 +0100, Pavel Machek wrote:
> Hi!
> 
> > I have netconsole configured I can see kernel messages on a remote machine, but when I suspend the laptop it goes into S3.
> > I am unable to capture the (oops) the laptop when bringing it out of S3. It remains in a half suspended-unsuspended state.
> > (the crescent moon LED is solidly on, video is back on (can see the 'Back to C!' string), cannot use sysctl key combos, 
> > netconsole doesn't display the output since no PCI devices resume (the video is AGP onboard).
> > 
> > Is there any way I can capture this output somehow? I don't think even serial would work (it would be a USB to serial converter which would be PCI)
> > or even trying to get this to print to lp0 since the laptop is totally unresponsive in its state.
> > 
> > I booted into single and sh for init, mounted /proc /sys and with no kernel modules it would fail to resume after suspending.
> > 
> > This isn't a nice regression.
> 
> So what was the last kernel where it worked?
> 										Pavel
> 

For me, 2.6.9-rc4.  I've tried every -rc and -mm since, and it cannot
resume.  (I get no video on resume, even with 2.6.9-rc4, until X
resumes, so I get no information what-so-ever, just a dead box.  That's
why I haven't reported this before.)

I have a Dell Inspiron 8600 (Centrino) with the nvidia card.

2.6.9-rc4 suspends and resumes fine, both to memory and disk.  Since
then, nothing has resumed from suspend-to-ram, but occasional versions
(such as 10-rc3-mm1) resumes from suspend-to-disk.

I can give any information that people want.

Daniel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
