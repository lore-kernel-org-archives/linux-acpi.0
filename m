From: ben lamothe <blamothe-DPNOqEs/LNQ@public.gmane.org>
Subject: Re: Thinkpad T40 Fan
Date: Thu, 5 Feb 2004 03:04:27 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040205030427.24025108.blamothe@mit.edu>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8AB5@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0CC8AB5-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thanks for the reply.  I tried to find a utility that monitored
temperature in windows, but I was completely unsuccessful.  Do you know
of any?  I was able to notice that after running windows for about three
hours without the fan ever coming on, immediately after booting linux,
the temperature was 107F, and the temperature is usually in the mid 80's
from a cold boot.  The fan came on after about 30 seconds, alot faster
than normal (usually takes 10-15 minutes).

I haven't noticed a consistent starting temperature for the fan, but
generally it starts when it gets around 95F. I havn't noticed a stopping
temperature either.  As I said, I've noticed the fan running at temps as
low as 80-85F.  If I leave my room window open, then the fan shuts off
after about 30 mins, but the THMO driver tells me that the temp is
around 90F, which is really weird because I have definitely heard it
loud and kicking at temps well below that.

I vaguely remember the fan staying on after installing windows from
scratch, but i am not completely sure as that was a long time ago and I
didn't know about this fan problem, so I wasn't looking out for it.  The
vast majority of my other hardware didn't work either, I had to call and
get restore cd's to get things working.  

I don't think that it's an I^2C device, because I think the
documentation given to me by IBM would list such a thing, but I may be
wrong.

Out of your list of choices, it seems like #2 is most likely, because I
can't imagine why a fan needs to run for a processor at a temp of 90F,
so I don't think it's totally hardware.  The fact that the fan is on so
much may be a failsafe that IBM put in place just in case the OS doesn't
know how to control the fan effectively, but that's just a guess.

On Wed, 4 Feb 2004 21:44:14 -0500
"Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> >> This behavior is not exibited in Windows,
> >> on the contrary, the fan is almost never on.
> 
> > ACPI can't control fan in many IBM systems,
> > including T40. DSDT of T40 has no fan device defined.
> 
> Hmm, how can Windows keep the fan off but Linux can't?
> 
> As there is no ACPI fan device, there must be a different method to
> control the fan on this box.
> 
> 1. It may be some i2c device that Windows knows about but Linux does
> not?
>    Maybe IBM ships some platform specific software with windows?
>    Would be interesting to know if a from-scratch install of the
>    generic non-IBM windows was still able to keep the fan off.
> 
> 2. It may be some BIOS code using SMM that Linux somehow breaks?
> 
> 3. It may be done entirely in hardware without the knowledge of the
> OS?
> 
> I'm hopeful that it is #3, and that Windows is simply doing better
> passive cooling than Linux -- and perhaps we can perhaps improve our
> passive cooling...
> 
> Can you run some experiments?  Maybe you can monitor the temperature
> in windows to see if it really is cooler.  Perhaps you can experiment
> with the power management policy settings such that it is in
> high-power mode instead of maximum battery mode and observe the
> temperature rises, and at what temperature the fan starts running?
> 
> Thanks,
> -Len




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
