From: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Moving from /proc/acpi  to /sys
Date: Fri, 18 Jun 2004 14:56:38 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1087592198.14618.57.camel@tdi>
References: <44BDAFB888F59F408FAE3CC35AB470415FC28E@orsmsx409>
	 <20040618194336.GL20511@parcelfarce.linux.theplanet.co.uk>
	 <20040618125608.A14371@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040618125608.A14371-39QZ/XbsZ5/mO6KZMuUCQVaTQe2KTcn/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2004-06-18 at 13:56, Keshavamurthy Anil S wrote:
> On Fri, Jun 18, 2004 at 08:43:36PM +0100, Matthew Wilcox wrote:
> > On Fri, Jun 18, 2004 at 10:41:17AM -0700, Keshavamurthy, Anil S wrote:
> > > Hi,
> > > 	I am curious to know whether anybody is working or even planning
> > > to port 
> > > all the acpi related entries from /proc/acpi to the corresponding
> > > /sysfs entries. 
> > 
> > Alex Williamson had a patch to fill in the methods under /sys ...
> Hi Alex,
> 	I am working on to support ACPI based cpu hotplug where in I am
> in the process of modifying ACPI processor driver. Since with the hotplug
> support I see some of the entries for the processor under /sys/device/system/cpu
> and some under /proc/acpi/processor. I felt it would be good if we have everything
> under the /sys fs directory. I would be glad to contribute to your patch for the
> processor driver changes. Can you please let me know where you are on this patch and
> and what are the things you are considering to move and lastly what is the timeline 
> you are looking to push this patch.
> 
> thanks,
> Anil
> 

Anil,

   The patch I'm working on isn't meant as a replacement to the current
/proc/acpi entries.  It's meant more as a means for userspace to
directly interact w/ ACPI namespace.  Here's a link to the last thread
about the patch:

http://marc.theaimsgroup.com/?l=acpi4linux&m=108154985013230&w=2

It fills in files in /sys/firmware/acpi/namespace/ACPI such that methods
and objects can be evaluated using a simple read/write interface.  In
some cases, a set of libraries and daemon could achieve the same results
as the current /proc/acpi drivers, but I don't think this is necessarily
the way to go in all cases.

  Are there ACPI specific features under /proc/acpi/processor that you
need for cpu hotplug?  I would assume that you'd want to abstract the
implementation and have generic calls under /sys/device/system/cpu. 
Anyway, have a look at what my patch does and let me know if it's useful
to you.  I don't think it's the port of /proc/acpi that you're thinking
it might be, but I'm happy to take suggestions.  I plan to pick it up
again soon, but pushing the patch really depends on getting some
interest in it.  Thanks,

	Alex



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
