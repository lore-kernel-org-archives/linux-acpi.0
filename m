From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: acpi_processor.c - kernel 2.6.1
Date: Mon, 19 Jan 2004 15:10:59 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040119141059.GG25416@poupinou.org>
References: <1074382993.674.24.camel@dragon> <1074424728.1914.24.camel@firefly>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1074424728.1914.24.camel-YqzrDssuZYw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yury V. Umanets" <umka-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org>
Cc: christian graf <chr.graf-Mmb7MZpHnFY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Jan 18, 2004 at 02:18:48PM +0300, Yury V. Umanets wrote:
> On Sun, 2004-01-18 at 02:43, christian graf wrote:
> > Hi,
> Hello,
> > 
> > reading the /usr/src/linux-2.6.1/drivers/acpi/processor.c
> > i thought the kernel should set the state dynamically, based on the
> > load. Maybe it is possible to set the processor-state of my centrino
> > manually. Can please anybody tell me how to get it right?
> > 
> 
> There is an user-space daemon, which adjusts CPU speed basing on current
> loading. And it is able to change CPU frequency if userspace cpufreq
> governor is turned on. I would like to see this functionality in kernel
> though.
> 
> > The reason I'm asking is, that once I do load the processor.ko module,
> > my Centrino switches immediately into C2-state. It never switches back
> > to C1 state, even under heavy load like compiling the kernel.
> > 
> I guess, that there is no code in kernel, which does watch current
> loading and adjust CPU speed. Also this is job for a cpufreq governor,
> not for CPU driver. 
> 
> For now, there are three governors:
> (1) powersave -- setting CPU frequency statically to lowest available
> frequency.
> (2) performance -- setting to highest available frequency.
> (3) userspace -- used for setting CPU frequency manually.
> 
> Probably there also should be number (4), which will set it basing on
> current loading.
> > I think the kernel should switch back from C2 to C1 state from alone????
> > 
> > Please ask me whatever you need to help me swtiching back into C1 state.
> > 
> > christian

ACPI Cx states are not the same as ACPI Px states and Cx have nothing to
do with cpufreq.  C-states are the sleeping states for a processor.

ACPI P-state will lower the voltage of the CPU and the frequency, but
the processor is supposed to run, whereas ACPI C-state is a kind of
replacement of the asm 'hlt' (for a 386 compatible), mostly used in
the idle loop.

C1 is actually this asm 'hlt', whereas C2 require a read to a IO register,
and C3 require a read to a IO register plus a kind of control of the bus 
(on UP system).  More the x in Cx is high, more you get power saving,
but this have a price for the latency in order to wakeup the processor
when it have to serve an interrupt.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
