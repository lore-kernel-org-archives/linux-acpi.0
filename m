From: Diego SANTA CRUZ <dsanta-W/9V78bTXrinCNX9eg9BBA@public.gmane.org>
Subject: RE: Processor C states and USB problem
Date: Mon, 12 Jan 2004 11:50:06 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1073904606.6168.1.camel@ltspc67.epfl.ch>
References: <3ACA40606221794F80A5670F0AF15F8401720CB9@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720CB9-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
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

On Mon, 2004-01-12 at 09:31, Yu, Luming wrote:
> > I picked up this thread and I'm interested in knowing a bit more about
> > bus mastering and C3, as my laptop never goes into C3. I own a Dell
> > Inspiron 8500 (details at
> > http://ltswww.epfl.ch/~dsanta/resources/dell-i8500-linux).
> > 
> > This is what I get for the power states:
> > # cat /proc/acpi/processor/CPU0/power
> > active state:            C2
> > default state:           C1
> > bus master activity:     ffffffff
> > states:
> >     C1:                  promotion[C2] demotion[--] 
> > latency[000] usage[00039800]
> >    *C2:                  promotion[C3] demotion[C1] 
> > latency[050] usage[00573330]
> >     C3:                  promotion[--] demotion[C2] 
> > latency[050] usage[00000004]
> > 
> > I tried booting with init=/bin/sh and manually loading the processor
> > module, without any external hardware attached, so that no special
> > hardware is initialized, but still there is non-stopping bus mastering
> > activity. What could be causing it? Any ideas how could I find out?
> 
> I just filed a tracker http://bugme.osdl.org/show_bug.cgi?id=1839.
> 

I tested with a bare bones kernel config and the problem persists. I
entered all the data that I thought useful in the bugzilla entry above.
Let me know if anything else is needed to help debug the problem.

Best,

Diego
-- 
-------------------------------------------------------
Diego Santa Cruz - PhD
Publications available at http://ltswww.epfl.ch/~dsanta
Signal Processing Institute (LTS1 / ITS / STI)
Swiss Federal Institute of Technology (EPFL)
EPFL - STI - ITS, CH-1015 Lausanne, Switzerland
E-mail:     Diego.SantaCruz-p8DiymsW2f8@public.gmane.org
Phone:      +41 - 21 - 693 26 57
Fax:        +41 - 21 - 693 76 00
-------------------------------------------------------



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
