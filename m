From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [ANNOUNCE] [PATCH] Node Hotplug Support
Date: Thu, 13 May 2004 13:51:22 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040513135122.11f13e42.tokunaga.keiich@jp.fujitsu.com>
References: <1TfLX-4M4-9@gated-at.bofh.it>
 <m34qqshx31.fsf@averell.firstfloor.org>
 <20040510111722.29524459.tokunaga.keiich@jp.fujitsu.com>
 <20040510195439.GA99051@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20040510195439.GA99051-S3Tp50WAuvHQ0RYIrOleWQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andi Kleen <ak-h9bWGtP8wOw@public.gmane.org>
Cc: tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org, lhns-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 10 May 2004 21:54:39 +0200
Andi Kleen <ak-h9bWGtP8wOw@public.gmane.org> wrote:

> On Mon, May 10, 2004 at 11:17:22AM +0900, Keiichiro Tokunaga wrote:
> > As you mentioned, there can be many more things.  However,
> > the examples you showed should be handled by individual hotplug.
> > For instance, the processes bound to a certain CPU should be
> > handled by CPU hotplug when node hotplug invokes CPU hotplug.
> > Also, the device drivers bound to slots should be detached by
> > IO hotplug.  Node hotplug is supposed to take care of a container
> > device and just invoke individual hotplugs for other devices.
> > Node hotplug doesn't break any policy of each hotplug (CPU,
> > memory, IO, etc).
> 
> To coordinate all them you need user space infrastructure anyways
> that knows about all the elements of a node.  I don't see why you want a 
> kernel level container too; userspace can do this job already
> and would be much more flexible.

Are you saying that LHNS should handle only container device,
and CPU, memory, IO devices on the container device should be
handled by each hotplug?  Also, each hotplug and LHNS should
be invoked from user space individually? For instance:

To hot-remove a container device, an operator:
  1. Invokes memory hotplug (memory will be gone)
  2. Invokes CPU hotplug (CPUs will be gone)
  3. Invokes IO hotplug (IO devices will be gone)
  4. Invokes node(container) hotplug (Conainer devices will be gone)

Is that what you're saying here?
 
> > > This has the advantage that if there is some reason to 
> > > add CPUs without memory (or memory without CPUs or PCI slots 
> > > without anything) it will just work too. It is not clear
> > > that your "lump everything mechanism into one" can handle all
> > > that. Most likely you would need to add lots of special
> > > cases to it to handle all this. Separate mechanisms can
> > > do this cleaner.
> > 
> > Yes. The cases (combination of hardware) would increase.
> > However, I don't think there would be that many today.
> 
> I am mainly thinking about virtualization here for which hotplug
> of everything makes definitely sense. But the requirements could
> be very different from what a big iron machine wants.

I'm afraid but I don't get the point here.  Could you explain that
again?
 
> > Are you saying here that platform-independent and dependent
> > codes should be separated so that the independent part could
> > be implemented by any other platform (firmware) in their own
> > style?  If so, I agree and some discussion are necessary :)
> 
> Yep.
> 
> -Andi

Rajesh Shah coordinated me to more apropreate place to discuss
this topic since LHNS is focusing on extenting ACPI based hotplug.
So I'm moving this discussion to acpi-devel list and away from LKML.

Thanks,
Kei


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
