From: Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>
Subject: Re: Is it possibile that ACPi messes my battery ...
Date: Wed, 2 Oct 2002 21:30:47 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021002193047.GA6377@schiggy.intern.quelltext.com>
References: <20021001001656.GC9965@geolandia.home> <200210021557.22805.fdc10056@students.fct.unl.pt> <1033593841.360.35.camel@bacchus.gpphy.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1033593841.360.35.camel-s1IKGncK6J2OERECOqmV57dB6IYNvbhm87tLKu7D3g4@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 02, 2002 at 11:24:01PM +0200, Knut Neumann wrote:
> Am Mit, 2002-10-02 um 16.57 schrieb Francisco Castanheiro:
> > Does anyone else with a presario (or not) notice this?
> 
> Hmm...in the last few weeks my vaios battery seems to have lost
> capacity. Tough it shows a value around designed cap for the last full
> cap it looses all power after about 20 minutes...

I am seeing exactly this with the battery on my Gericom 1st Supersonic
M6-T: The battery is fully charged (/proc/acpi/battery/BAT0/state says
"design capacity: 54720 mWh, last full capacity: 57000 mWh") and I remove
AC power so the system runs on battery. After 20 mins of operation during
which the "remaining capacity" value decreases normally, the battery
suddenly jumps down to a remaining capacity value of 285 mWh. However,
the system will keep running on battery for another 50 minutes if I just
ignore the low capacity value. So I assume the battery electronics are
at fault here. I already discharged and recharged the battery a couple
of times, but the described behaviour is reproducible and still the same.

I have been running Linux 2.4.18 with many versions of the ACPI patch
since I got this laptop in March (because without the ACPI patch, the
IRQs of some builtin hardware devices are not correctly initialized).
However, I can't imagine ACPI has anything to do with the battery issue.
How could this be at all possible?

Arndt


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
