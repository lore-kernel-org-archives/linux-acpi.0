From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: S3 test
Date: Mon, 18 Jul 2005 10:36:10 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD3057502B653B0@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bernd Schubert <bernd-schubert-Mmb7MZpHnFY@public.gmane.org>
Cc: Frank <hugelmopf-S0/GAf8tV78@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>
>> Is there anybody on this list, who has tried this initramfs yet and
can
>give
>a
>> short list of the steps involved? I have never before built a kernel
for
>use
>> with initram, but I would like to test it on my S3-broken laptop.
>
>I'm planning to do it over the weekend (there was just too much to do
>over the week). So far I have never used an initramfs myself, but I'm
>rather experienced with initrd's. I guess you only need to specify a
>line 'initrd =3D /path_to_initramfs/initramfs' in lilo, so something
similar
>to
>this:
>
># a rescue image that calls a shell in the initrd
>image=3D/boot/linux-2.6.9-tc5
>        label=3D2.6.9_rescue
>        read-only
>        initrd=3D/boot/initrd-lvm-2.6.-amd64-lvm2_32_shell.gz
>
>Recent kernels seem to first check if its an initramfs or initrd and I
hope
>they will do the proper thing themselves. I'm not sure if the kernel
needs
>ramdisk support, but I guess it needs it.
>
>Better DON'T do it globally for all kernels, you might have problems to
>boot a
>normal kernel again ;-)
Absolutely :) !

>About grub I don't know how to use/configure it.
Add something like this in /etc/grub.conf:

title test
	kernel /boot/kernel-image-name
	initrd /boot/initramfs-name

Thanks,
Shaohua


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
