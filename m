From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: "TSC cannot be used as a timesource" when on battery
Date: 11 Mar 2004 02:14:41 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1078989281.2549.99.camel@dhcppc4>
References: <C386328088ED7F4E9F81AFBABDDF60DA04A92548@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <C386328088ED7F4E9F81AFBABDDF60DA04A92548-Yw6hFe9C1vnHQcBQSaPqJq0fmWJ9l57d0E9HWUfgJXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ow Mun Heng <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Cc: "Acpi-List (E-mail)" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Does /proc/acpi/processor/CPU0/power show any usage in C3?

I believe there is a bugfix in the pipeline regarding local APIC timer
slowing down in C3.  The fix is to disable C3 -- the workaround is to
use another timer.

cheers,
-Len


On Thu, 2004-03-11 at 00:21, Ow Mun Heng wrote:
> > -----Original Message-----
> > From: Ow Mun Heng 
> > Sent: Monday, March 01, 2004 10:39 AM
> > To: Acpi-List (E-mail)
> > Subject: [ACPI] "TSC cannot be used as a timesource" when on battery
> > 
> > 
> > Hi All,
> > 
> > D600 + RH9 + kernel 2.6.3+acpi20040211
> > 
> > Was seeing these error messages when booting from battery. 
> > I've searched through google and the only thing It came up with 
> > was a reference that asks to use ACPI PM as the timesource.
> > 
> > I'm currently using RTC (real time clock)
> > 
> > I'm still trying to figure out what is the difference between ACPI 
> > PM timesource/RTC.
> > 
> > I've not investigated further to determine if my clock is indeed 
> > running slower. 
> > 
> > ====start kernel message=======
> > TSC cannot be used as a timesource.
> >  <4> Possible reasons for this are
> > You're running with speedstep
> > You don't have DMA enabled for your hard drive (See hdparm)
> > Incorrect TSC synchronization on an SMP system (dee dmesg)
> > Falling back to sane timesource now.
> > =======end kernel messages==========
> > 
> > HDparm shows all my hd and cdrom are on dma
> > This is uniprocessor laptop
> > 
> > Yes.. running on speedstep.
> > When on AC power, I don't see this error.
> 
> Sent this to the list a while back.. I've not
> seen any responses. So, asking again, just in case it
> was missed (busy schedules etc)
> 
> I don't really think it's an issue.. but still would like 
> to know what is triggering it.
> 
> Thanks,
> Ow
> 
>  
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id70&alloc_id638&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
