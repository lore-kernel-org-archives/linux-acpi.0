From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Centrino question
Date: Fri, 21 May 2004 20:47:03 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040521184703.GR29214@poupinou.org>
References: <7F740D512C7C1046AB53446D372001730177CE7A@scsmsx402.amr.corp.intel.com> <1085163473.9856.23.camel@Neuromancer.home.net> <20040521183113.GQ29214@poupinou.org> <1085164585.9856.31.camel@Neuromancer.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1085164585.9856.31.camel-C9mHTC703ZUb5wn6fCfWY+TW4wlIGRCZ@public.gmane.org>
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

On Fri, May 21, 2004 at 11:36:25AM -0700, Ow Mun Heng wrote:
> > That's strange.  Are you sure you are not running a kind of throttling
> > control stuff instead?
> 
> What do you mean? When I'm on battery, I also run the laptop_mode patch.
> (though now, I have trouble with XFS not understanding the commit=600 or
> something like that)

There are people (even OEM btw) that sometimes think that throttling a
CPU is the same as for P-state.

> I don't have the P-states anymore since upgrading to 2.6 kernel on RH9
> (2.6.3)

And?  You are using the cpufreq infrastructure with the enhanced
speedstep driver, which is the same thing anyway.

Well, if really you last only 2 hours and a half on battery, even if
running at 600MHz via cpufreq, and C3 is also enabled, with laptop mode
enabled and so on, either you are using the cdrom continously (which I doubt)
or your battery is failing imho.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
