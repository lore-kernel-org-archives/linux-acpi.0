From: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Subject: Re: Synaptics and keyboard losing interrupts w/ACPI ?
Date: Sat, 3 Apr 2004 23:36:37 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200404032336.39468.dtor_core@ameritech.net>
References: <1081044549.2179.281.camel@localhost.localdomain> <1081048768.2179.293.camel@localhost.localdomain> <1081050591.2239.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1081050591.2239.1.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Karl Hegbloom <hegbloom-tbDHPZwbsQQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Saturday 03 April 2004 10:49 pm, Karl Hegbloom wrote:
> On Sat, 2004-04-03 at 19:19, Karl Hegbloom wrote:
> > On Sat, 2004-04-03 at 18:45, Randy.Dunlap wrote:
> > > Have you tried any hints from the "2.6 input drivers FAQ"?
> > > See http://lwn.net/Articles/69107/ or google for the string above.
> >
> > First I will try to turn off the battery monitor in the gkrellm that I
> > always have running.
> 
> That cures it!  I can run with ACPI enabled as long as the gkrellm
> battery monitor is not on.  The keyboard and synaptics losing sync thing
> occurs only when I turn on the battery monitor.

I think you can leave it on but you will have to increase the poll interval.
Setting it to 30 sec or even 1 min will probably let you have your Synaptics
working and still have an idea on battery level.
 
> So, something is the matter with the ACPI battery code!  I doubt I can
> find it... but I'll look in there anyway just for some exposure. :-)
> 

It is usually deep in the BIOS code, not something exposed in AML as far as
I can understand. Polling battery often takes long time, especially polling
full info as opposed to just state. :(

-- 
Dmitry


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
