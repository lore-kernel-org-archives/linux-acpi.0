From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Centrino question
Date: Fri, 21 May 2004 20:31:13 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040521183113.GQ29214@poupinou.org>
References: <7F740D512C7C1046AB53446D372001730177CE7A@scsmsx402.amr.corp.intel.com> <1085163473.9856.23.camel@Neuromancer.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1085163473.9856.23.camel-C9mHTC703ZUb5wn6fCfWY+TW4wlIGRCZ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Cc: "Nakajima, Jun" <jun.nakajima-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, May 21, 2004 at 11:17:54AM -0700, Ow Mun Heng wrote:
> On Fri, 2004-05-21 at 11:08, Nakajima, Jun wrote:
> > To get longer battery life, you need to use P-state transitions via
> > Enhanced SpeedStep as well.
> 
> Which means we have to use the drivers provided by Intel??

Those are deprecated.

> Or do you just mean the speedstep functions?

I guess Jun means the cpufreq centrino speedstep driver.

> I have cpuspeedfreq installed and when I'm quoting the number
> of hours, I actually am quoting it with cpufreq turned on and running 
> at 600Mhz only with nothing plugged into the USB, backlight at it's dimmest
> and all that. (Even the fan is turned off!)
> 
> No JOY!
> 
> So.. Centrino gives a better/longer Batt life?? MY foot! It actually depends
> on the batt capacity the OEM gives you! The extra 1MB cache in Pentium-M 
> is nice though. :)

That's strange.  Are you sure you are not running a kind of throttling
control stuff instead?

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
