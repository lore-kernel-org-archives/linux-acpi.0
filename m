From: Oliver Dawid <oliver-csNNzRR391izQB+pC5nmwQ@public.gmane.org>
Subject: Re: S3 broken Samsung P35 - howto debug?
Date: Wed, 24 Nov 2004 11:23:59 +0100
Message-ID: <41A4613F.2020905@helios.de>
References: <200411211600.01820.od@fet.uni-hannover.de> <1101064133.7220.15.camel@mhcln03>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1101064133.7220.15.camel@mhcln03>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>
Cc: Oliver Dawid <od-VRmHG7Xu4f31qYPpFx2fzhvVK+yQ3ZXh@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

now machine is resuming (unfortunately without display waking up) - so I 
got a little success but there is still work to be done.

Matthias Hentges wrote:

>>Now I got several questions how to proceed:
>>
>>- which modules are needed to be compiled into kernel directly? Does it 
>>matter, if ide_* is loaded as module?
> 
> I don't know. I always have essential stuff like IDE compiled into the
> kernel.

As I am booting from a LVM2 volume, I essentially need initrd. This does 
not matter at all. I have stripped down the kernel to a minimum - left 
out usb, sound etc.

now, only few modules are loaded:

- unix
- ide_core
- generic
- piix
- ide_generic
- ide_disk
- dm_mod
- mbcache
- jbd
- ext3

So to answer my qouestion: its not needed to compile ide_* directly into 
kernel. It's enough to have loadable modules instead.

echo 3 > /proc/acpi/sleep is doing its job, waking up the machine using 
powerbutton is working too. System resumes as expected, i can blindly 
type reboot and system reacts as desired.

> Our best bet is the on-board ethernet. It works perfectly after
> resuming. SSH is your friend.
> I've put together a page with my experiences so
> far :http://www.hentges.net/misc/howtos/samsung_p30_s3.shtml
> 
> There's a little script to restore lost PCI configuration DATA after a
> resume. 
> I've managed to get the backlight on, but that's it heh.

Now its time to switch on my backlight ;-)

Regards,
Oliver


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
