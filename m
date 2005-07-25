From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: S3 test
Date: Mon, 25 Jul 2005 09:55:58 +0800
Message-ID: <1122256558.2952.3.camel@linux-hp.sh.intel.com>
References: <16A54BF5D6E14E4D916CE26C9AD3057502B653B0@pdsmsx402.ccr.corp.intel.com>
	 <200507202059.28860.hugelmopf@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200507202059.28860.hugelmopf-S0/GAf8tV78@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Frank <hugelmopf-S0/GAf8tV78@public.gmane.org>
Cc: Bernd Schubert <bernd-schubert-Mmb7MZpHnFY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2005-07-20 at 20:59 +0200, Frank wrote:
> Li, Shaohua wrote:
> > Add something like this in /etc/grub.conf:
> >
> > title test
> > 	kernel /boot/kernel-image-name
> > 	initrd /boot/initramfs-name
> 
> This causes my kernel to panic, because it doesn't find the root.
> 
> I don't know if I did the right thing: I built a new kernel, that I configured 
> with "make allnoconfig" and enabled ACPI support + IDE + reiserfs (because 
> my /boot is on a reiserfs-partition).
> 
> My Grub line:
> 
> title s3test
> 	{root (hd0,2)}
> 	kernel /boot/bzImage-s3test {root=/dev/hda3}
> 	initrd /boot/initramfs.cpio
> 
> I tried with and without the parts in curly bracket.
> Is this enough or the completely wrong way to go?
Don't know what's the matter. The initramfs doesn't try to mount root
device and it works for me. I even didn't build IDE & reiserfs, since I
think grub will load the kernel image and initrd image to memory.

Thanks,
Shaohua



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
