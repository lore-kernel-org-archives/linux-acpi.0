From: Karl Hegbloom <hegbloom-tbDHPZwbsQQ@public.gmane.org>
Subject: Re: Synaptics and keyboard losing interrupts w/ACPI ?
Date: Sat, 03 Apr 2004 21:16:07 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1081055767.2239.7.camel@localhost.localdomain>
References: <1081044549.2179.281.camel@localhost.localdomain>
	 <1081048768.2179.293.camel@localhost.localdomain>
	 <1081050591.2239.1.camel@localhost.localdomain>
	 <200404032336.39468.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200404032336.39468.dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 2004-04-03 at 20:36, Dmitry Torokhov wrote:
> I think you can leave it on but you will have to increase the poll interval.
> Setting it to 30 sec or even 1 min will probably let you have your Synaptics
> working and still have an idea on battery level.

I will try this and see if it works, thank you.
 
> > So, something is the matter with the ACPI battery code!  I doubt I can
> > find it... but I'll look in there anyway just for some exposure. :-)
> 
> It is usually deep in the BIOS code, not something exposed in AML as far as
> I can understand. Polling battery often takes long time, especially polling
> full info as opposed to just state. :(

Is there any reason why the ACPI code cannot cache that info, rather
than looking it up each time the /proc file is accessed?  (which is what
I think it does now... am I right?)

-- 
If you feel like the machines are conspiring against you,
then it's time to perspire against the machines.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
