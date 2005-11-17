From: Yasunori Goto <y-goto-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [Lhms-devel] [PATCH 1/1]  patch to fix acpi_memhotplug.c
Date: Thu, 17 Nov 2005 16:01:08 +0900
Message-ID: <20051117154954.8723.Y-GOTO@jp.fujitsu.com>
References: <20051115171221.7E99.Y-GOTO@jp.fujitsu.com> <1132201107.3798.81.camel@knk>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1132201107.3798.81.camel@knk>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, external hotplug mem list <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Tolentino, Matthew E" <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


On Wed, 16 Nov 2005 20:18:27 -0800
keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org> wrote:

> On Tue, 2005-11-15 at 19:20 +0900, Yasunori Goto wrote:
> > Hello, Keith-san.
> > 
> > >   I am submitting this patch for inclusion in the acpi development tree.
> > > I have not received any feedback of my beta patch or emails over the
> > > past week.  I cleaned my previous patch up and made the error handling
> > > match the rest of the driver.  I need this patch to support my hardware
> > > (IBM x460/x366/x445) acpi hot-add memory events.   
> > > 
> > >   In general acpi_bus_get_device fails for my event. 
> > > acpi_bus-0072 [04] bus_get_device        : No context for object [ffff81007ff397f0] 
> > >   The current driver relies on acpi_bus_get_device to create the acpi
> > > memory_device but these call fails for my hardware.  
> > >   
> > >   My event is a single notify with a memory range passed along as data.
> > > The current driver is expecting some other event or series of events (As
> > > I have posted before I am a little confused on how the current driver
> > > works at all).  My code provides a way for the data that is passed along
> > > during the event to be converted directly to the memory_device without
> > > reliance on acpi_bus_get_device.  My code in no way breaks the current
> > > implementation and seems a reasonable addition for increased
> > > flexibility. 
> > 
> > Hmm.
> > I have a bit similar (but contrastive) problem on our making box.
> > In my case, physical hotplug unit is a node. So, notification of event
> > will reach "container driver". And container driver just call 
> > struct acpi_driver ops.add via acpi_bus_scan(). And it will also call
> > ops.start if start method is exist.
> > 
> > Howerver, there is no ops.start method in acpi_memhotplug.c.
> > So, when bus is scaned by container driver add event,
> > add_memory is not called.
> > Following patch is to add start method for it.
> 
> My add event is called with my patch.  The notify event is triggering
> and falling into the right path. 
> 
> I tried your patch but my device is not making and add event.  I really
> looks to just be a notify with the memory range attached.  I really
> think my patch is the right way to go for my hardware. 

Oops. I didn't say clearly. Sorry.
Just I meant each patches were necessary for each case.

Anyway, I also have a concern about Kame-san's following question.

> Maybe driver->ops.add is not called for some reason.
> What happens in acpi_add_single_object() in your environment ?
> acpi_bus_find_driver() is called ?

Thanks.

-- 
Yasunori Goto 




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
