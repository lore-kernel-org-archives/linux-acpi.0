From: Jan De Luyck <lkml-gY0FE6dpLprYtjvyW6yDsg@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3
Date: Mon, 14 Mar 2005 07:19:00 +0100
Message-ID: <200503140719.01536.lkml@kcore.org>
References: <20050214211105.GA12808@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050214211105.GA12808-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 14 February 2005 22:11, Pavel Machek wrote:
> Hi!
>
> Stefan provided me initial list of machines where S3 works (including
> video). If you have machine that is not on the list, please send me a
> diff. If you have eMachines... I'd like you to try playing with
> vbetool (it worked for me), and if it works for you supplying right
> model numbers.

Acer Travelmate 803LCi, working Suspend to ram:
- Have to use the soft-boot method for the radeon
- Have to shutdown the following parts: 
  * hotplug (actually the USB subsystem, but hotplug does that nicely)
  * ALSA (modem won't work otherwise without reloading the modules)
    (snd_intel8x0m module)
  * MySQL (hinders the actual suspension process and kicks the pc back to 
    where it was)

Other than these little things it works like a charm :)

Jan
-- 
Bumper sticker:
 All the parts falling off this car are of the very finest
 British manufacture.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
