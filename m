From: Rathgeb Markus <maggu2810-S0/GAf8tV78@public.gmane.org>
Subject: Re: s3 buggy after kernel-update
Date: Thu, 17 Nov 2005 15:15:38 +0100
Message-ID: <437C908A.4070600@web.de>
References: <59D45D057E9702469E5775CBB56411F1D91C9D@pdsmsx406> <437AFE25.9080500@web.de> <20051117121639.GA14597@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051117121639.GA14597-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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

the important thing in my script are the following lines:

	statedir=3D/tmp
	/usr/bin/chvt 12
	/usr/sbin/vbetool vbestate save > $statedir/vbe
	/usr/bin/sync
	echo -n mem > /sys/power/state
	/usr/bin/sync
	/usr/sbin/vbetool post
	/tmp/radeon/boot-radeon
	/usr/sbin/vbetool vbestate restore < $statedir/vbe
	/usr/bin/chvt 7

with the kernel 2.6.12-gentoo-r10 it works fine.

with newer kernel for example 2.6.14-gentoo-r02 this do not work
i started without X
i conencted to my laptop AFTER wake up, to see the error messages...

when i execute
	/usr/sbin/vbetool post
or
	boot-radeon
from http://www.doesi.gmxhome.de/linux/tm800s3/s3.html

i get:
"Ung=FCliger Maschinenbefehl"
(in english, invalid machinecommand i guess)

and when i execute startx:
(EE) RADEON(0): No V_BIOS fount


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=3D7628&alloc_id=3D16845&op=3Dclick
