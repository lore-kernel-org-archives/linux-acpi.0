From: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Subject: Re: Centrino question
Date: Fri, 21 May 2004 11:36:25 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1085164585.9856.31.camel@Neuromancer.home.net>
References: <7F740D512C7C1046AB53446D372001730177CE7A@scsmsx402.amr.corp.intel.com>
	 <1085163473.9856.23.camel@Neuromancer.home.net>
	 <20040521183113.GQ29214@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040521183113.GQ29214-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: "Nakajima, Jun" <jun.nakajima-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2004-05-21 at 11:31, Bruno Ducrot wrote:
> > 
> > Which means we have to use the drivers provided by Intel??
> 
> Those are deprecated.

Ah..

> > Or do you just mean the speedstep functions?
> 
> I guess Jun means the cpufreq centrino speedstep driver.

That's what I'm using

> > I have cpuspeedfreq installed and when I'm quoting the number
> > of hours, I actually am quoting it with cpufreq turned on and running 
> > at 600Mhz only with nothing plugged into the USB, backlight at it's dimmest
> > and all that. (Even the fan is turned off!


> That's strange.  Are you sure you are not running a kind of throttling
> control stuff instead?

What do you mean? When I'm on battery, I also run the laptop_mode patch.
(though now, I have trouble with XFS not understanding the commit=600 or
something like that)

I don't have the P-states anymore since upgrading to 2.6 kernel on RH9
(2.6.3)

cat /proc/acpi/info                
version:                 20040211


 cat /proc/acpi/processor/CPU0/throttling
state count:             8
active state:            T0
states:
   *T0:                  00%
    T1:                  12%
    T2:                  25%
    T3:                  37%
    T4:                  50%
    T5:                  62%
    T6:                  75%
    T7:                  87%

cat /proc/acpi/processor/CPU0/info
processor id:            0
acpi id:                 0
bus mastering control:   yes
power management:        yes
throttling control:      yes
limit interface:         yes

cat /proc/acpi/processor/CPU0/limit
active limit:            P0:T0
user limit:              P0:T0
thermal limit:           P0:T0


-- 


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
