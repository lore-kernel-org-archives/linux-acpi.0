From: Joshua Legbandt <jtlegbandt-ihVZJaRskl1bRRN4PJnoQQ@public.gmane.org>
Subject: Re: Help with my Friggin compag 2701us
Date: Mon, 24 Nov 2003 00:30:13 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1069662612.2977.5.camel@suburbia>
References: <1069612236.3685.21.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1069612236.3685.21.camel-G3aYVrF1d50@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 2003-11-23 at 10:30, Bill Chmura wrote:
> Hello,
> 
> I am having issues getting my battery power from Linux.  Here are the
> stats:
> 
> Compaq 2701US : RedHat9 base, Kernel 2.4.22 (from kernel.org), Kde 3.1.4
> (from KDE.org)
> 
> Shutdown works which is fantastic.  I cannot however get any readings
> from my batteries.  I have KLaptop running, which does tell when I am on
> AC power versus batteries, but when I am on batteries it thinks I am out
> of power.
> 
> If I go into /proc and poke around:
> 
> /proc/acpi/battery/BAT1 or BAT2/info - says no battery is present under
> AC or Battery
> 
> /proc/acpi/ac_adapter/ACAD/state - shows off-line or on-line depending
> on if I am plugged in (which is where I guess the applet can tell if I
> am plugged in or not)
> 
I've seen that behavior with my Compaq Presario 2715us. I can get around
it by waiting to the ac into the laptop until _after_ my ACPI modules
have loaded. I haven't played with custom dsdts, but it looks like there
are a couple Presario 27xx dsdts in the wiki at
http://acpi.sourceforge.net that have the ACAD problem fixed.

I've also had a lot of success recently with the 2.6test kernels being
tested for Fedora, they can be found at
http://people.redhat.com/arjanv/2.5/    Since you are running Red Hat 9,
you'll want to make sure to update all the supporting packages that are
there, as well as install the appropriate kernel.

-josh

> I noticed there were some patches for my kernel, but all of the kernel
> how-tos have been taken down on the internet (strange) and that was
> pretty much my guide to rebuilding...
> 
> If that patch will help, I will give it a try - but I am not sure I
> remember how to do it...
> 
> Thanks
> 
> Bill


-- 
Joshua Legbandt <jtlegbandt-ihVZJaRskl1bRRN4PJnoQQ@public.gmane.org>



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
