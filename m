From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Re: Call for help: list of machines with working S3
Date: Fri, 25 Feb 2005 16:25:47 +0100
Message-ID: <20050225152547.GB22631@message-id.gmane0305.slipkontur.de>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 24, 2005 at 11:50:54AM +0800, Ow Mun Heng wrote:

> In some cases, the D600 _can_ work. I've had it working on 2.6.7 kernel.
> I've seen references that it works on 2.6.9 but fails on 2.6.10 with a
> blank screen. 
> 
> I'm on 2.6.10 right now and it does not work. Actually I don't even get
> SSH access or anything like that

worksforme. D600 with Pentium M 1700 (Banias). I have to boot with
vga=normal, using any framebuffer prevents resume (it instead boots
immediately to the BIOS, no trace of even a try at resuming.

The backlight stays off until i switch back to X which also restores the
console etc.

kernel is SUSE-2.6.11-rc4-bk9-27-default (works since about four weeks,
IIRC). X version is 

strolchi:~ # X -version
X Window System Version 6.8.2
Release Date: 9 February 2005

I do not think that there is a special SUSE-hack in the X modules to get
the video back, but i will investigate this.

AFAICT i do not have to unload any modules, only the uhci-hcd will not
work after resume, but it does not prevent suspend/resume. I always hated
the D600 for the lack of S3 but now i love it ;-)
-- 
Stefan Seyfried



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
