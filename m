From: Sebastian Seifert <lathander-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: mutexes and preemption
Date: Thu, 4 Mar 2004 11:22:12 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040304102212.GA2303@ergo.gotdns.org>
References: <CFF522B18982EA4481D3A3E23B83141C01C988CE@orsmsx407.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CFF522B18982EA4481D3A3E23B83141C01C988CE-sBd4vmA9Se6SsB6bSF6DdVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Therien, Guy" <guy.therien-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Mar 03, 2004 at 05:08:53PM -0800, Moore, Robert wrote:
> 
> Looking at the timestamps in the debug output, I suspect that the real
> issue here is this line:
> 
> Mar  2 23:03:10 tenshi kernel:      osl-0909 [2049] os_wait_semaphore
> : Failed to acquire semaphore[dffd8680|1|36863], AE_TIME
> 
> Because this wait should have been for 37 seconds (36863 milliseconds),
> yet not one second has gone by on the wall clock.
> 
> A close look at the Linux implementation of os_wait_semaphore may again
> be in order.

You are right, thank you. I believe there is a  bug in
os_wait_semaphore: the return value of down_trylock isn't checked
correctly, leading to the immediate failure of an Acquire with timeout
in the case the semaphore cannot be acquired immediately . I've sent a
patch to this list. I hope someone applies it.

Sebastian

-- 
A bad analogy is like leaky screwdriver.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
