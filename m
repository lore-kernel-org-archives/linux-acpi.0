From: Stefan Schweizer <sschweizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3
Date: Wed, 16 Feb 2005 06:54:47 +0100
Message-ID: <e796392205021521541da7ee25@mail.gmail.com>
References: <20050214211105.GA12808@elf.ucw.cz>
Reply-To: Stefan Schweizer <sschweizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050214211105.GA12808-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Model                           hack (or "how to do it")
------------------------------------------------------------------------------
Acer Aspire 1406LC          ole's radeonfb patch

I have to turn off dri, and then it works with the radeonfb patch. I
use this method because I like the fancy framebuffersplash on booting
.. although I do not reboot often when S3 wors ;)

You can find the patch here:
http://dev.gentoo.org/~marineam/patch-radeonfb-2.6.11-rc2-mm2

or for older kernels:
http://dev.gentoo.org/~genstef/files/radeon-s3-resume-2.6.10.patch

The problems with this patch are:
- you need to press a key to come back from the "resume-console" after resume.
- DRI in X does not work (at least for me with intel-agp, others
reportet it works)
I just disabloed it by not loading intel-agp (hotplug-blacklist)

I have not only issues with video not coming back, but I also need to
append acpi=noirq to my command-line that I am able to finish resuming
and use my devices correctly afterwards.

Regards,
Stefan


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
