From: Oliver Dawid <oliver-csNNzRR391izQB+pC5nmwQ@public.gmane.org>
Subject: Re: S3 broken Samsung P35 - howto debug?
Date: Mon, 22 Nov 2004 09:20:21 +0100
Message-ID: <41A1A145.4090006@helios.de>
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

Hi Matthias,

Matthias Hentges wrote:

> Did you say yes to "Power management options / ACPI / Use compatibily
> PCI resume code" after patching?

Yes I did as you proposed.

> For testing purposes, I'd go with the buggy Samsung DSDT.

Since errors in dsdt seem not to touch any suspend-to-* problem, this is 
a good idea.

>>- which modules are known not to work properly with acpi sleep/ resume? Which 
>>should be unloaded before going to sleep?
> 
> The following things break resume on the P30 (break == freeze on resume)
> 
> - Active sound driver, be it OSS or ALSA. Must be unloaded before
> suspending.
> - radeonfb
> - Accelerated X (DRI or fglrx)
> 
> For testing purposes I'd recommend using a minimalistic kernel .config
> (no usb, firewire, preempt, AGP etc.)

Hmm wouldn't it be good to collect which modules are hanging? Or is it 
platform-dependent?

As dri or fglrx are freezing the system, do you need to abandon X before 
going to sleep?

> There's a little script to restore lost PCI configuration DATA after a
> resume. 
> I've managed to get the backlight on, but that's it heh.

so you aren't sitting totally in the dark but have some miserable lamp 
to illuminate your keyboard ;-)

Oliver


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
