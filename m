From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Latest ACPI + cpufreq on a Dell Inspiron 2650
Date: Thu, 5 Dec 2002 11:35:10 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021205103509.GA127@elf.ucw.cz>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19B95D@orsmsx107.jf.intel.com> <200212030136.30159.chris@chrishowells.co.uk> <002401c29acd$e1316880$3746028e@bio.dfo.ca> <200212031601.20634.chris@chrishowells.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200212031601.20634.chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Chris Howells <chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > * Entering S1 halts the system clock so the time when leaving S1 is the
> > > same as when it entered S1
> >
> > As it should.  You have to reset the clock.
> 
> Oh really? Hrm.... so presumably the correct solution would be to do a 
> "hwclock --hctosys" on leaving S1? *Wonders how to make it do this 
> automatically*

echo 'echo 1 > /proc/acpi/sleep; hwclock --hctosys' > do_sleep?
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
