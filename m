From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Crash with fs corruption on 2.4.23-rc1 + CONFIG_ACPI_PROCESSOR
Date: Mon, 17 Nov 2003 14:18:00 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031117131800.GQ32464@poupinou.org>
References: <20031113161857.GM26911@roosevelt.alcove-fr> <20031114124713.GK32464@poupinou.org> <20031114152403.GK29316@roosevelt.alcove-fr> <20031115065020.GO32464@poupinou.org> <20031115134811.GA2630@hottah.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031115134811.GA2630-Snhs3Gxj9njPHUqn3ntIkQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stelian Pop <stelian.pop-A5NNTvo2L0pl57MIdRCFDg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Nov 15, 2003 at 02:48:11PM +0100, Stelian Pop wrote:
> On Sat, Nov 15, 2003 at 07:50:20AM +0100, Ducrot Bruno wrote:
> 
> > I think the trouble come from C3, just need to check some values.  If you
> > can, it may be usefull that you disable C3, with something like that:
> > 
> > +		acpi_fadt.plvl3_lat = 1234;
> 
> And the patch works, your assumption was correct. 
> 
> Now, C3 seem to be reported as supported, 2.6 (correctly) doesn't
> promote to it, but 2.4 does. I can't find an obvious reason by reading
> the processor.c code (almost identical between 2.4/2.6...)

No, 2.6 have some trouble, I guess, because C3 should be promoted.  I guess
you are using a USB bridge driver, which need to be rewrotten somehow, because
it does a lot of DMA transfers just to check if a device is plugged..
That affect all USB driver, but not EHCI IIRC.

> The only 'strange' thing I see in /proc/acpi/processor/CPU0/power
> (different wrt the 2.6 data I posted earlier) is the 'bus mastering 
> activity' field:
> 	active state:            C2
> 	default state:           C1
> 	bus master activity:     00000000
> 	states:
> 	    C1:                  promotion[C2] demotion[--] latency[000] usage[00000340]
> 	   *C2:                  promotion[--] demotion[C1] latency[003] usage[00034161]
> 	    C3:                  <not supported>

Well, by putting the line, the system think that C3 is no more supported,
which then imply this output.  So that is 'normal'.


Now, I have to look if the integrated northbridge is correctly configured, with
your previous output.  Thanks.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
