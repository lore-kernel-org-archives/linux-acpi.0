From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Acer 1703 and DSDT fixing questions
Date: Thu, 12 Feb 2004 13:25:01 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040212122501.GT13262@poupinou.org>
References: <3ACA40606221794F80A5670F0AF15F8401CBB68B@PDSMSX403.ccr.corp.intel.com> <200402111650.55343.cirrus@the-penguin.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200402111650.55343.cirrus-m8NPtmh9OiN1HeySrBk8eLVCufUGDwFn@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: John <cirrus-m8NPtmh9OiN1HeySrBk8eLVCufUGDwFn@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 11, 2004 at 04:50:55PM +0000, John wrote:
> On Wednesday 11 February 2004 01:43, Yu, Luming wrote:
> > > $ cat /proc/acpi/battery/BAT1/state
> > > present:                 yes
> > > capacity state:          ok
> > > charging state:          unknown
> > > present rate:            unknown
> > > remaining capacity:      5579 mAh
> > > present voltage:         16660 mV
> >
> > Presumably, this battery is full. And there is no charging/discharging
> > activity.
> >
> Yes in this instant the battery was full, but still:
> $ cat /proc/acpi/battery/BAT1/state
> present:                 yes
> capacity state:          ok
> charging state:          discharging
> present rate:            unknown
> remaining capacity:      5524 mAh
> present voltage:         16249 mV
> 
> The present rate is unknown. Also alarms are not working. 
> $ cat /proc/acpi/battery/BAT1/alarm
> alarm:                   unsupported
> 
> I presume that this is a DSDT problem isn't it?
> 

IIRC, there is no way (at least in the original DSDT) to retrieve the
present rate, (but it was possible to get the real present voltage,
remaining capacity and so on), so it was harcoded to return unknown.

I think it is possible to get the real info. via the smbus integrated
in the EC though, just that there is nothing in the AML part to tell you
there is one (there is one, trust me :), and anyway linux do not support
the SMBUS HC EC related methods.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
