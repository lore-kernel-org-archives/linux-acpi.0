From: Diego SANTA CRUZ <dsanta-W/9V78bTXrinCNX9eg9BBA@public.gmane.org>
Subject: RE: Processor C states and USB problem
Date: Wed, 14 Jan 2004 08:55:35 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1074066934.9124.6.camel@ltspc67.epfl.ch>
References: <3ACA40606221794F80A5670F0AF15F8401720CC9@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720CC9-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2004-01-14 at 03:10, Yu, Luming wrote:
> > > > I picked up this thread and I'm interested in knowing a 
> > bit more about
> > > > bus mastering and C3, as my laptop never goes into C3. I 
> > own a Dell
> > > > Inspiron 8500 (details at
> > > > http://ltswww.epfl.ch/~dsanta/resources/dell-i8500-linux).
> > > > 
> 
> How did you know your processor never transition to C3 mode?
> 

The usage count is never above 5, even after a long period (an hour or
more of idle CPU). But yes, strictly speaking it's almost never ;-)

> > > > This is what I get for the power states:
> > > > # cat /proc/acpi/processor/CPU0/power
> > > > active state:            C2
> > > > default state:           C1
> > > > bus master activity:     ffffffff
> > > > states:
> > > >     C1:                  promotion[C2] demotion[--] 
> > > > latency[000] usage[00039800]
> > > >    *C2:                  promotion[C3] demotion[C1] 
> > > > latency[050] usage[00573330]
> > > >     C3:                  promotion[--] demotion[C2] 
> > > > latency[050] usage[00000004]
> > > > 
> 
> Usage of C3 is 4. 

Yes, but compared to the usage count of C2 that is extremely low, and
the CPU is idling all the time (CPU usage is below 1%). I don't know
much about C states but I guess it should go into C3 much more often,
and the bus mastering activity should show something else than ffffffff
when booting with a bare bones kernel and with no extra hw initialized
(USB, FireWire, etc.)

Best,

Diego

-- 
Diego SANTA CRUZ <dsanta-W/9V78bTXrinCNX9eg9BBA@public.gmane.org>
Ecole Polytechnique Fédérale de Lausanne - EPFL



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
