From: Paul Ionescu <paul-f7LjuT9/YZU@public.gmane.org>
Subject: Re: [RFC] filling in ACPI files in sysfs
Date: Sat, 10 Apr 2004 13:03:34 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1081591413.23299.13.camel@t40>
References: <1081373781.23176.30.camel@t40>
	 <1081376023.2748.15.camel@patsy.fc.hp.com>
	 <20040408172548.GH18329@parcelfarce.linux.theplanet.co.uk>
	 <1081445594.2747.8.camel@patsy.fc.hp.com>  <1081536801.26073.120.camel@t40>
	 <1081537175.2694.11.camel@patsy.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1081537175.2694.11.camel-Wmjt7DDUnIVxnVILBQAtiA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>, acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Alex,

You are right, I have:
/sys/bus/pci/slots/4294967295 # find .
.
./test
./cur_bus_speed
./max_bus_speed
./address
./adapter
./latch
./attention
./power

When I boot in dock, the value of power and adapter is 1, when I boot
normaly, I have 0 in those files.
Now, I booted in DOCK, and I did an echo 0 > power, and surprise, it did
an electromechanicaly eject of dock !!!.
Anyway, echo-ing 1 again, does nothing for me. I expected to power the
pci slot again and find the coresponding device in there.
So, thanks for the tips, now I get back to playing with apci.

Paul


On Fri, 2004-04-09 at 21:59, Alex Williamson wrote:
> On Fri, 2004-04-09 at 12:53, Paul Ionescu wrote:
> > I also have an ACPI hotplug PCI slot in the laptop, because when I
> > insert acpiphp.ko module, it sais that it found and registered a slot.
> > Now, where do I find some info about that slot, or how can I play with
> > it ? I suppose it is the PCI slot from my dock.
> > I could not find any info about it in /proc or /sys.
> > Is there a standard name I should look for ?
> 
> 
>    PCI hotplug slots registered via the ACPI hotplug driver show up
> under /sys/bus/pci/slots.  There are a few things you can do w/ it via
> that interface.
> 
> 	Alex



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
