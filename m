From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: [PATCH] 2.6.0-test4 Don't change BIOS allocated IRQs
Date: Wed, 17 Sep 2003 09:08:33 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200309170908.33295.adq_dvb__26576.9138969064$1063788518@lidskialf.net>
References: <200309170011.03630.adq_dvb@lidskialf.net> <20030917010254.GA1640@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030917010254.GA1640-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Chris Wright <chrisw-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 17 September 2003 02:02, Greg KH wrote:
> On Wed, Sep 17, 2003 at 12:11:03AM +0100, Andrew de Quincey wrote:
> > With the help of Chris Wright testing several failed patches, I've
> > tracked down another ACPI IRQ problem. On many systems, the BIOS
> > pre-allocates IRQs for certain PCI devices, providing a list of alternate
> > possibilities as well.
> >
> > On some systems, changing the IRQ to one of those alternate possibilities
> > works fine. On others however, it really isn't a good idea. As theres no
> > way to tell which systems are good and bad in advance, this patch simply
> > ensures that ACPI does not change an IRQ if the BIOS has pre-allocated
> > it.
>
> Nice, the patch below, which Chris told me is from you, fixed my
> problems too.  It is against 2.6.0-test5-bk3 and fixes bug number 1186
> in the bugzilla.kernel.org database.
>
> Many thanks for this work, I really appreciate it.

Great! thanks for letting me know.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
