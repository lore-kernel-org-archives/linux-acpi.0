From: Kjartan Maraas <kmaraas-gyXR7Lt7FVk/G1V5fR+Y7Q@public.gmane.org>
Subject: Re: Re: Call for help: list of machines with working S3
Date: Mon, 21 Feb 2005 15:25:52 +0100
Message-ID: <1108995952.4819.2.camel@localhost.localdomain>
References: <20050214211105.GA12808@elf.ucw.cz>
	 <200502151742.55362.s0348365@sms.ed.ac.uk>
	 <1108563926.4986.3.camel@localhost.localdomain>
	 <200502182049.11088.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <200502182049.11088.s0348365-Y3tGgqFSo3OFxr2TtlUqVg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alistair John Strachan <s0348365-Y3tGgqFSo3OFxr2TtlUqVg@public.gmane.org>
Cc: Lorenzo Colitti <lorenzo-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

fre, 18,.02.2005 kl. 20.49 +0000, skrev Alistair John Strachan:
> On Wednesday 16 Feb 2005 14:25, Kjartan Maraas wrote:
> > tir, 15,.02.2005 kl. 17.42 +0000, skrev Alistair John Strachan:
> > > On Tuesday 15 Feb 2005 16:16, Lorenzo Colitti wrote:
> > > [snip]
> > >
> > > > Ok, here is the output from dmidecode (Debian package) and from lspci.
> > > > I don't have acpidmp and I don't know where to get it, but if you think
> > > > it's necessary I can download it if you tell me where to find it.
> > >
> > > Find below a diff of my dmidecode output versus Lorenzo's. Nothing much
> > > to call home about.
> >
> > I've attached a diff against Lorenzo's too. Only difference is that my
> > laptop is a nc4010, and looking here it's clear that this model doesn't
> > support APM at least. I also have non-working S3. It behaves just like
> > the entry in the ubuntu wiki for the nc6000 in all three cases with a
> > full system running at least. I'll try init=/bin/sh later to see if that
> > helps and if it does experiment with removing modules one by one...
> 
> Got it. Sorry for the radio silence, I've been busy for a few days.
> 
> I discovered that either the i2c_core.ko or i2c_i801.ko modules cause the hang 
> on resume! If you stop the entire i2c subsystem from being loaded by hotplug 
> (note this is the BUS driver, not the sensors driver!), then resume works 
> perfectly! Presumably there's a bug in the resuming of this module.
> 
> In other news, USB devices only work after I remove uhci_hcd and ehci_hcd and 
> reload them.
> 
> The s3_bios workaround allows video to kind of work, but I can't use anything 
> other than vga=normal (vesafb results in corruption), and the screen is no 
> longer artificially resized to fill the LCD, it's native res and centered 
> (which sure is annoying).
> 
> Kjartan, I hope you isolate the driver causing you problems, as it seems these 
> machines can be made, even if it is a bit of a headache.
> 
I tried it again now using init=/bin/sh and acpi_sleep=s3_bios and it
still gives a black screen on resume... :-/

Cheers
Kjartan




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
