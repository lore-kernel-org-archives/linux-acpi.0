From: Proinnsias Breathnach <proinnsias-cv59FeDIM0c@public.gmane.org>
Subject: Re: Re: Call for help: list of machines with working S3
Date: Thu, 24 Feb 2005 11:21:18 +0000
Message-ID: <20050224112118.GV26667@project-bob.org>
References: <20050214211105.GA12808@elf.ucw.cz> <29495f1d050223113044b96fcf@mail.gmail.com> <1109217054.10202.1.camel@neuromancer.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109217054.10202.1.camel-/ZsuMndpQpsb5wn6fCfWY+TW4wlIGRCZ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 24, 2005 at 11:50:54AM +0800, Ow Mun Heng wrote:
> In some cases, the D600 _can_ work. I've had it working on 2.6.7 kernel.
> I've seen references that it works on 2.6.9 but fails on 2.6.10 with a
> blank screen. 
> 
> I'm on 2.6.10 right now and it does not work. Actually I don't even get
> SSH access or anything like that
> 
> 
That's curious - I've a D600 beside me here with the latest Dell BIOS on
it, and it boots/S3/resume etc fine - uptime of well over a week now -
mostly either on battery or suspended !!

grub contains the following line:
kernel	/boot/vmlinuz-2.6.10-3-686 root=/dev/hda2 ro vga=normal 

Kernel is the "vanilla" ubuntu 2.6.10-3 kernel from Hoary.

P


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
