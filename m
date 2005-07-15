From: Bernd Schubert <bernd-schubert-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: S3 test
Date: Fri, 15 Jul 2005 16:29:36 +0200
Message-ID: <200507151629.36606.bernd-schubert@gmx.de>
References: <1121160149.20699.6.camel@linux-hp.sh.intel.com> <200507151536.21857.hugelmopf@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200507151536.21857.hugelmopf-S0/GAf8tV78@public.gmane.org>
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
Cc: Frank <hugelmopf-S0/GAf8tV78@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello Frank,

> Is there anybody on this list, who has tried this initramfs yet and can give 
a
> short list of the steps involved? I have never before built a kernel for use
> with initram, but I would like to test it on my S3-broken laptop.

I'm planning to do it over the weekend (there was just too much to do
over the week). So far I have never used an initramfs myself, but I'm
rather experienced with initrd's. I guess you only need to specify a
line 'initrd = /path_to_initramfs/initramfs' in lilo, so something similar to
this:

# a rescue image that calls a shell in the initrd
image=/boot/linux-2.6.9-tc5
        label=2.6.9_rescue
        read-only
        initrd=/boot/initrd-lvm-2.6.-amd64-lvm2_32_shell.gz

Recent kernels seem to first check if its an initramfs or initrd and I hope 
they will do the proper thing themselves. I'm not sure if the kernel needs 
ramdisk support, but I guess it needs it.

Better DON'T do it globally for all kernels, you might have problems to boot a 
normal kernel again ;-)


About grub I don't know how to use/configure it.


Hope it helps,
	Bernd


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
