From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3
Date: Wed, 16 Feb 2005 14:47:45 +0100
Message-ID: <20050216134745.GE1446@elf.ucw.cz>
References: <20050214211105.GA12808@elf.ucw.cz> <20050216142916.0f48c36f@orfeo.nikhef.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050216142916.0f48c36f-acHaiI0CM+haAVKTNDtesg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Tim Dijkstra <tim-TpnWJeB+oO0hKRfeEwdQzg@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org> wrote:
> 
> 
> > 
> > Model                           hack (or "how to do it")
> > ---------------------------------------------------------------------
> Acer TravelMate 636Lci		acpi_sleep=s3_bios vga=normal
> 
> This is with vanilla 2.6.10 kernel. I had some problems before but now
> it seems to work with a full system. This means, X (with ali-agp and nv
> driver, haven't tried anything else), wlan-pccard, usb, etc. The only
> thing that I've found that will hang resume is the ieee1394 subsystem.
> 
> If I choose anything else than vga=normal, the screen will go back to
> vga=normal resolution on resume without linux noticing: a big
> unusable mess as a result.

You may want to try acpi_sleep=s3_bios,s3_mode (without vga=normal)...


								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
