From: Michael Guntsche <mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org>
Subject: Re: Network failures with ACPI enabled (kernel 2.4, 2.6)
 PROBLEM FOUND!!!!!!
Date: Wed, 31 Dec 2003 00:46:48 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031231004648.531549af.mike@it-loops.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8954@hdsmsx402.hd.intel.com>
	<20031231001716.76cb2e8d.mike@it-loops.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031231001716.76cb2e8d.mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 31 Dec 2003 00:17:16 +0100
Michael Guntsche <mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org> wrote:

> Is there a way to see what the change in the CMOS does to ACPI?
> What puzzles me is that with the parport disabled outgoing traffic
> still works. It would make more sense if the network didn't work at all.
> 
One more piece of information.
The parport must be set to ECP, else you still get the same errors.


Michael


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
