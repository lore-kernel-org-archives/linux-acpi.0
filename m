From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: DSDT table for an Evo N150 ?
Date: Fri, 2 Apr 2004 15:44:07 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040402134407.GO19001@poupinou.org>
References: <3ACA40606221794F80A5670F0AF15F8401720E4E@PDSMSX403.ccr.corp.intel.com> <20040329184812.GA9041@gaspode.nextlink.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040329184812.GA9041-beYWCVBHuyQmjp9Ioln+9+7fARiR49SZ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Andrews <tandrews-Dza9YrynN5pWaveUIWBRJg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 29, 2004 at 08:48:12PM +0200, Thomas Andrews wrote:
> On Mon, Mar 29, 2004 at 09:29:07AM +0800, Yu, Luming wrote:
> 
> > What's wrong with your laptop?  Is there still battery status issue?
> 
> o /proc/acpi/ac_adapter/ACAD/state reports "on-line" after turning on the
>   laptop even though the adapter is disconnected. Once the ac adapter is
>   connected the state is reported correctly
> 
> o /proc/acpi/battery/BAT1/info reports last full capacity: 18188 mAh
>   but the actual capacity is 3600 mAh
> 
> o /proc/acpi/battery/BAT1/state reports:
>   present rate: 18176 mA (18 Amps!)
>   remaining capacity: 1291 mAh (but it is almost fully charged)
>   present voltage: 36555 mV (should be 14800 mV)
> 

Could you please send me the original dsdt, and the modified one,
please ?

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
