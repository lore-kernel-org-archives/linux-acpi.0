From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: 2.6.13-rc3-mm3
Date: Fri, 29 Jul 2005 12:33:30 -0700
Message-ID: <20050729123330.2fcfb751.akpm@osdl.org>
References: <20050728025840.0596b9cb.akpm@osdl.org>
	<42E96A42.7060405@gmail.com>
	<20050728164640.062286fe.akpm@osdl.org>
	<42EA4FCC.7030600@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42EA4FCC.7030600-S0/GAf8tV78@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Thonke <tk-shockwave-S0/GAf8tV78@public.gmane.org>
Cc: iogl64nx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Michael Thonke <tk-shockwave-S0/GAf8tV78@public.gmane.org> wrote:
>
> Andrew Morton schrieb:
> > Michael Thonke <iogl64nx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >> here again I have two problems. With 2.6.13-rc3-mm3 I have problems 
> >>  using my SATA drives on Intel ICH6.
> >>  The kernel can't route there IRQs or can't discover them. the option 
> >>  irqpoll got them to work now.
> >>  The problem is new because 2.6.13-rc3[-mm1,mm2] work without any problems.
> > 
> > OK.  Please generate the full dmesg output for -mm2 and for -mm3 and run
> > `diff -u dmesg.mm2 dmesg.mm3' and send it?  And keep those files because we
> > may end up needing to add them to an acpi bugzilla entry ;)
> 
> Well I did a little mistake..it only worked correctly up to
> 2.6.13-rc3-mm1 but this dmesg output I have.
> 
> Well as I save mm[2,3] are unable to setup the correct IRQs for the
> devices..and please note that 2.6.13-rc3-mm3 only booted with irqpoll so
> its in the dmesg output "dmesg.mm3"
> Normaly the IRQ routed to something about 1xx now they are 1-21?! Caused
> by irqpoll?
> 

Are these problems only present in -mm kernels?  Does 2.6.13-rc4 work OK?

> > Odd trace.  Do you have CONFIG_KALLSYMS enabled?  If not, please turn it on.
> 
> Mh I tried but my system freezes on boot then. And screen leaves blank.
> > 

Oh geeze.

@@ -53,10 +23,18 @@
 Enabling fast FPU save and restore... done.
 Enabling unmasked SIMD FPU exception support... done.
 Checking 'hlt' instruction... OK.
+    ACPI-0287: *** Error: Region SystemMemory(0) has no handler
+    ACPI-0127: *** Error: acpi_load_tables: Could not load namespace: AE_NOT_EXIST
+    ACPI-0136: *** Error: acpi_load_tables: Could not load tables: AE_NOT_EXIST
+ACPI: Unable to load the System Description Tables
 ENABLING IO-APIC IRQs
-..TIMER: vector=0x31 pin1=2 pin2=0
+..TIMER: vector=0x31 pin1=2 pin2=-1
 NET: Registered protocol family 16
 PCI: Using configuration type 1
+ACPI: Subsystem revision 20050708
+ACPI: Interpreter disabled.

Well it looks like ACPI committed suicide, so there's probably not much
point looking at the other things until that gets addressed.

Would you have time to raise a kernel bugzilla entry for this?  Raise it
against the ACPI AML interpreter, version 20050708 and mention the above
failure.  The output of acpidump (from
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/pmtools-20050727.tar.gz)
will probably be asked for.

Thanks.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
