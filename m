From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Link error: function "cmpxchg" is not defined
Date: 24 Mar 2004 00:54:20 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1080107660.18508.15.camel@dhcppc4>
References: <87ptb3bx0h.fsf@localhost.i-did-not-set--mail-host-address--so-tickle-me>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <87ptb3bx0h.fsf-bi+AKbBUZKa9iW1SM0nyN4RarTOWFVVqTdcDvyEvLSPbOj2S/riVXGfe97SVfj0f6XfCTY0wUs4@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Free Ekanayaka <free-Jko+Qxvg0ikdnm+yROfE0A@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

IIRC this was an obscure dependency on CONFIG_SMP, but I thought we
fixed this some time back.

I'm surprised you're seeing this, I build 32 different 2.4.24 kernels
with the current patch.

If after a make clean and a download of the latest patch (sorry, same
name;-) you still see the error, then please email me your .config.

thanks,
-Len


On Tue, 2004-03-23 at 06:53, Free Ekanayaka wrote:
> Hi,
> 
> I'm trying to complile 2.4.24 patched against acpi-20040311-2.4.24.diff.gz.
> 
> When it comes to link I get:
> 
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> ld -m elf_i386 -T /build/cvs-autoreleasedeb/kernel-image-2.4.24-i386-multimedia-2.4.24/build-386/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
> 	--start-group \
> 	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
> 	 drivers/acpi/acpi.o drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/pcmcia/pcmcia.o drivers/net/pcmcia/pcmcia_net.o drivers/pnp/pnp.o drivers/video/video.o drivers/usb/usbdrv.o drivers/media/media.o \
> 	net/network.o \
> 	/build/cvs-autoreleasedeb/kernel-image-2.4.24-i386-multimedia-2.4.24/build-386/arch/i386/lib/lib.a /build/cvs-autoreleasedeb/kernel-image-2.4.24-i386-multimedia-2.4.24/build-386/lib/lib.a /build/cvs-autoreleasedeb/kernel-image-2.4.24-i386-multimedia-2.4.24/build-386/arch/i386/lib/lib.a \
> 	--end-group \
> 	-o vmlinux
> drivers/acpi/acpi.o(.text+0x8ac1): In function `acpi_ev_global_lock_handler':
> : undefined reference to `cmpxchg'
> drivers/acpi/acpi.o(.text+0x8c21): In function `acpi_ev_acquire_global_lock':
> : undefined reference to `cmpxchg'
> drivers/acpi/acpi.o(.text+0x8d3d): In function `acpi_ev_release_global_lock':
> : undefined reference to `cmpxchg'
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> Is there some specific kernel option I have to set in .config in order
> to get cmpxchg defined?
> 
> Thanks,
> 
> Free Ekanayaka
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
