From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: sleep states - maybe a dumb question...
Date: Sun, 28 Mar 2004 15:31:51 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040328133150.GC1453@openzaurus.ucw.cz>
References: <40642CDA.6070007@lorenz.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <40642CDA.6070007-2WKW0nu+7nMiq3RsQ1AnAw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Martin Lorenz <martin-2WKW0nu+7nMiq3RsQ1AnAw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> maybe this is a very dumb question, but I did not find an answer in 
> the docs. (or I was not looking at the right place)
> 
> I see two different sleep-state capabilities on my laptop (run by a 
> transmeta cursoe CPU) running 2.6.4 vanilla kernel and a debian 
> unstable system.
> 
> # cat /proc/acpi/sleep
> S0 S3 S4 S5
> 
> # cat /sys/power/state
> standby mem disk
> 
> as I understand 'standby' is synonymous to 'S1', which is not showing 
> up in the /proc version...
> 
> when issuing echo -n standby > /sys/power/state the system acts as if 
> it would go to standby (switch to console, some output saying so, 
> etc.) but resumes immediately.
> 
> what does that mean?
> does my laptop lack S1/standby capability?

Bug in Patricks code. It should not announce standby when
no S1 is available. Oh and it indeed is very igly to have
2 interfaces for same thing; hopefully that will get fixed, too.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
