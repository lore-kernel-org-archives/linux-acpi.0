From: Emmanuel =?iso-8859-1?Q?Thom=E9?= <Emmanuel.Thome-MZpvjPyXg2s@public.gmane.org>
Subject: Re: s3_late_bios
Date: Tue, 9 Nov 2004 13:56:31 +0100
Message-ID: <20041109125631.GB8015@tate.loria.fr>
References: <20041108144947.GA31267@tate.loria.fr> <3195717504110815096a527710@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3195717504110815096a527710-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Greg <gonufer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Interesting.

I'll have a look to see if the same kind of things happen for me (I still
have crashes when resuming from vesa modes).

E.

On Mon, Nov 08, 2004 at 03:09:09PM -0800, Greg wrote:
> > Sorry I've been off for a week. Here is the version of the s3_late_bios
> > patch with the segment info coded in C.
> 
> This only works on my Sony VAIO Z1 if the PIC IMR is saved and
> restored around the VGA POST.  For some reason, when returning from
> the BIOS, bit 0 of the IMR is set.  That masks further clock
> interrupts so sleeping waits hang the machine after that point (for
> instance when resuming the pci devices on bus #2 like the e100). 
> Reading the IMR before and after the real-mode POST shows that only
> bit 0 is different.
> 
> Cheers!greg


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
