From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3
Date: Thu, 17 Feb 2005 20:54:57 +0100
Message-ID: <20050217195456.GA5963@openzaurus.ucw.cz>
References: <20050214211105.GA12808@elf.ucw.cz> <1108621005.2096.412.camel@d845pe> <1108638021.4085.143.camel@tyrosine> <4214C3B8.30502@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4214C3B8.30502-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > to reinitialise the graphics hardware, few are going to care about
> > making life easier for Linux.
> 
> 1. A first step towards better DSDTs would be to make the ASL compiler
> complain about the same things which are complained about by the
> in-kernel ACPI interpreter. An example would be the following:
> 
> acpi_processor-0496 [10] acpi_processor_get_inf: Invalid PBLK length [7]
> 
> The ASL compiler will not complain about it, yet the kernel will
> refuse to do any processor throttling with a PBLK length of 7.

Not sure if you can check all interesting stuff statically.

> 2. Urge/force vendors to use the latest ASL compiler available.

Heh, good luck.

> 3. Get some shiny certification/label going that can be put on
> fully conforming products as a sticker. Something like the old
> "EPA pollution preventer" logo, but with a more appealing design.
> Perhaps a "InstantOn/PowerSave" sticker, you get the idea.

Like "This machine actually works" sticker? :-)

> 4. Include a mandantory description of video bringup after resume

That sounds overcomplicated. Simply add this to the specs:
"BIOS must POST video during S3 wakeup. Video mujst be working
and in 80x25 text mode when it jumps to OS. VESA BIOS calls must be available to the OS."

BIOS must do that during normal boot; this should be very little additional
work.
			Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
