From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [ACPI] Re: 2.5.44: How to decode call trace
Date: Wed, 23 Oct 2002 12:48:46 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20021023124846.L27461@parcelfarce.linux.theplanet.co.uk>
References: <87elai82xb.fsf@goat.bogus.local.suse.lists.linux.kernel> <p73isztstim.fsf@oldwotan.suse.de> <878z0p1m2y.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <878z0p1m2y.fsf-7Fr62mCC+AxPE4CVVyAePw@public.gmane.org>; from olaf.dietsche#list.linux-kernel-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org on Wed, Oct 23, 2002 at 12:33:25PM +0200
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Cc: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 23, 2002 at 12:33:25PM +0200, Olaf Dietsche wrote:
> When I build with "make -k EXTRA_CFLAGS=-g EXTRA_LDFLAGS=-g bzImage",
> I get a ton of error messages from drivers/acpi/include/actypes.h and
> other acpi related stuff, starting with: #error ACPI_MACHINE_WIDTH not
> defined. Maybe this is not the usual way to build with -g, but I don't
> get these errors with "make -k bzImage". Maybe someone is interested
> in this.

Not really.  Users shouldn't be overriding EXTRA_CFLAGS, it's for the
benefit of various parts of the kernel.  Some other parts of the kernel
you break by doing this:

./arch/i386/mach-generic/Makefile:EXTRA_CFLAGS  += -I../kernel
./drivers/ide/pci/Makefile:EXTRA_CFLAGS := -Idrivers/ide
./drivers/message/fusion/Makefile:EXTRA_CFLAGS += ${MPT_CFLAGS}
./drivers/usb/storage/Makefile:EXTRA_CFLAGS     := -Idrivers/scsi
./fs/smbfs/Makefile:EXTRA_CFLAGS += -DSMBFS_PARANOIA
./fs/xfs/Makefile:EXTRA_CFLAGS +=        -Ifs/xfs -funsigned-char
./sound/oss/emu10k1/Makefile:    EXTRA_CFLAGS += -DEMU10K1_DEBUG

The normal way to do what you want is to edit the Makefile and add -g
directly to CFLAGS.

-- 
Revolutions do not require corporate support.
