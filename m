From: Karl Hegbloom <hegbloom-tbDHPZwbsQQ@public.gmane.org>
Subject: Re: Re: Synaptics and keyboard losing interrupts w/ACPI ?
Date: Sun, 04 Apr 2004 20:43:47 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1081136626.7470.58.camel@localhost.localdomain>
References: <1081044549.2179.281.camel@localhost.localdomain>
	 <200404040029.12359.dtor_core@ameritech.net>
	 <1081058079.2239.15.camel@localhost.localdomain>
	 <200404040106.15621.dtor_core@ameritech.net>
	 <20040405024043.GC5509@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040405024043.GC5509-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
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

On Sun, 2004-04-04 at 19:40, Stefan Seyfried wrote:
> > needed is to allow multiple applications read /proc/acpi/event simultaneously,
> > right now it only allows exclusive access.
> 
> Or a more general daemon than acpid, that also cares for (and caches) battery
> states, temperatures, etc....

If anyone implements this, please make it possible to disable the
battery checks as a workaround for machines where this causes the
problems I've described.

It seems that on some boards, the ACPI battery state calls (is it BIOS?
are those 32 bit, or what?) take too long and have interrupts locked out
during that time.  This is causing synaptics touch-pad pointer glitches,
keyboard bounce and lockout, and even network card lockup when under
heavy network load.

-- 
If you feel like the machines are conspiring against you,
then it's time to perspire against the machines.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
