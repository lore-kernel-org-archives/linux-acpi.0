From: David Goodenough <david.goodenough-6b45v/Ft3lbby3iVrkZq2A@public.gmane.org>
Subject: Re: DSDT loading patch
Date: Mon, 6 Dec 2004 14:35:23 +0000
Message-ID: <200412061435.23333.david.goodenough@btconnect.com>
References: <200412060907.53079.david.goodenough@btconnect.com> <200412060740.25524.barr.156@osu.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200412060740.25524.barr.156-ZbGKxL/pcrQ@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 06 December 2004 12:40, Andrew Barr wrote:
> On Monday 06 December 2004 4:07 am, David Goodenough wrote:
> > I recently bought my eldest son a Samsung P28 laptop, which works just
> > fine with Linux except of course that it suffers from a badly built DSDT.
> >  I have found instructions as to how to fix it and found that this
> > required me to add in a patch to the kernel to allow a DSDT image to be
> > appended to the initrd image.  This patch seems to have been around for a
> > long time and judging by the number of machines listed as needing to have
> > their DSDT updated there is a need to have this patch in the standard
> > kernel.  Is there a reason why this patch has not been included?
> >
> > The most useful page I found that describes this particular patch was
> > http://gaugusch.at/kernel.shtml, which says that SuSE now include the
> > patch anyway, and that Mandrake are considering it.
> >
> > David
>
> There is a feature to compile-in the DSDT included in ACPI patch 20041105.
> I forget if it's in kernel 2.6.9 or not. I think the DSDT-in-initrd
> technique is not recommended anymore.
>
> Andrew
Thanks for the reply.  I am glad that some feature to get this in is now
getting in to the standard kernel, but it does strike me that this in-initrd 
method means that normally you would not have to rebuild your kernel
just because you have a buggy DSDT every time you put up a new kernel.
Normally these days I can work with the stock Debian kernels, and so I
do not need to rebuild the kernel every time.

Do you know who decided this and why?

Regards

David


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
