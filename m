From: Karl Hegbloom <hegbloom-tbDHPZwbsQQ@public.gmane.org>
Subject: Re: Synaptics and keyboard losing interrupts w/ACPI ?
Date: Sat, 03 Apr 2004 19:19:29 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1081048768.2179.293.camel@localhost.localdomain>
References: <1081044549.2179.281.camel@localhost.localdomain>
	 <20040403184520.196ff775.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040403184520.196ff775.rddunlap-3NddpPZAyC0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 2004-04-03 at 18:45, Randy.Dunlap wrote:
> On Sat, 03 Apr 2004 18:09:09 -0800 Karl Hegbloom <hegbloom-tbDHPZwbsQQ@public.gmane.org> wrote:
> | I've got a laptop that has a synaptics touchpad.  Every so often, with
> | every kernel I've tried up through 2.6.4, the pointer will suddenly leap
> | across the screen, and sometimes it will even push a GUI button there. 
> | Also, on occasion, a key will "stick down",,,,,,,,,,,, like that, until
> | I push another key.  Every now and then the keyboard quits working
> | entirely, and I must reboot to regain control.
>
> Have you tried any hints from the "2.6 input drivers FAQ"?
> See http://lwn.net/Articles/69107/ or google for the string above.

I've been booting with "acpi=off", but I'd rather have it enabled and
not causing this problem.  The kernel is compiled WITH the ACPI-PM timer
support.  Perhaps I should try building one without that?  HPET is very
new, am I correct?  This laptop does not seem to have one.  Would the
"unsynced tsc support" option (2.4) affect this?  IO-APIC?  I really
need to find out what class I need to take where they'll teach me what
all that stuff means!  It's embarrassing to have been around Linux this
long and not know what that stuff is.  Anyone know a good book where I
can read about it?  {Please.}

First I will try to turn off the battery monitor in the gkrellm that I
always have running.

cpufreq is enabled even without ACPI, and it's working fine; Centrino
enhanced.  That does not seem to be the cause of the problem.

-- 
If you feel like the machines are conspiring against you,
then it's time to perspire against the machines.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
