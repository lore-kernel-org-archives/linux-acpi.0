From: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Subject: Re: Centrino question
Date: Fri, 21 May 2004 12:05:14 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1085166313.9856.36.camel@Neuromancer.home.net>
References: <7F740D512C7C1046AB53446D372001730177CE7A@scsmsx402.amr.corp.intel.com>
	 <1085163473.9856.23.camel@Neuromancer.home.net>
	 <20040521183113.GQ29214@poupinou.org>
	 <1085164585.9856.31.camel@Neuromancer.home.net>
	 <20040521184703.GR29214@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040521184703.GR29214-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
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

On Fri, 2004-05-21 at 11:47, Bruno Ducrot wrote:
> On Fri, May 21, 2004 at 11:36:25AM -0700, Ow Mun Heng wrote:
> > > That's strange.  Are you sure you are not running a kind of throttling
> > > control stuff instead?
> > 
> > What do you mean? When I'm on battery, I also run the laptop_mode patch.
> > (though now, I have trouble with XFS not understanding the commit=600 or
> > something like that)
> 
> There are people (even OEM btw) that sometimes think that throttling a
> CPU is the same as for P-state.

Oh.. OK..

> 
> > I don't have the P-states anymore since upgrading to 2.6 kernel on RH9
> > (2.6.3)
> 
> And?  You are using the cpufreq infrastructure with the enhanced
> speedstep driver, which is the same thing anyway.

Cool.. So... nothing to worry about there.

> Well, if really you last only 2 hours and a half on battery, even if
> running at 600MHz via cpufreq, and C3 is also enabled, with laptop mode
> enabled and so on, either you are using the cdrom continously (which I doubt)
> or your battery is failing imho.
hehe.. It has already failed once. Called up DELL for a replacement.
Still Sucks.

Nope.. When I try to detemine the max of my batter life, I don't use the
CDROM at all, I disable Wifi, 600Mhz, laptop_mode, no usb, no sound,
(not using the speakers, but drivers still on) screen to dimmest(14.1
SXGA screen 1400x1050) etc..

2:30 hours.

so... I've stopped hoping / looking for ways to get my battery life
better. It just plainly _sucks_.

Where are you Art Fuel_cell?

(Unless of course I go get a N-Charge battery which will cause this D600
to feel like lugging around a piece of brick!)

-- 


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
