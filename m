From: Karl Hegbloom <hegbloom-tbDHPZwbsQQ@public.gmane.org>
Subject: Re: Synaptics and keyboard losing interrupts w/ACPI ?
Date: Sat, 03 Apr 2004 19:49:52 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1081050591.2239.1.camel@localhost.localdomain>
References: <1081044549.2179.281.camel@localhost.localdomain>
	 <20040403184520.196ff775.rddunlap@osdl.org>
	 <1081048768.2179.293.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1081048768.2179.293.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 2004-04-03 at 19:19, Karl Hegbloom wrote:
> On Sat, 2004-04-03 at 18:45, Randy.Dunlap wrote:
> > Have you tried any hints from the "2.6 input drivers FAQ"?
> > See http://lwn.net/Articles/69107/ or google for the string above.
>
> First I will try to turn off the battery monitor in the gkrellm that I
> always have running.

That cures it!  I can run with ACPI enabled as long as the gkrellm
battery monitor is not on.  The keyboard and synaptics losing sync thing
occurs only when I turn on the battery monitor.

So, something is the matter with the ACPI battery code!  I doubt I can
find it... but I'll look in there anyway just for some exposure. :-)

-- 
If you feel like the machines are conspiring against you,
then it's time to perspire against the machines.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
