From: Sebastian Seifert <lathander-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: mutexes and preemption
Date: Wed, 3 Mar 2004 08:24:24 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040303072424.GA14439@ergo.gotdns.org>
References: <3ACA40606221794F80A5670F0AF15F8401CBB713@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401CBB713-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
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

On Wed, Mar 03, 2004 at 03:05:11PM +0800, Yu, Luming wrote:
> > 
> > some vital information first: I'm using kernel 2.6.3-mm4 with 
> > DSDT in ramdisk
> > patch applied, preemption is enabled, SMP disabled. 
> >
> 
> What about disable preemption?
> 

If I disable kernel preemption,
the second release of MUT1 by the running thread happens before the acquire by
thread 3 and no error happens.

That is to say, the sequence looks as follows without preemption:
ACQUIRE ... RELEASE
ACQUIRE ... RELEASE
ACQUIRE by thread 3 ... RELEASE by thread 3

instead of
ACQUIRE ... RELEASE
ACQUIRE ... ACQUIRE by thread 3 *ERROR* ... RELEASE by thread 3 ... RELEASE

So, it seems the kernel thread that holds the mutex becomes scheduled
away because of preemption. Should it?

Sebastian

-- 
This sentence is false.



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
