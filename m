From: Alistair John Strachan <s0348365-Y3tGgqFSo3OFxr2TtlUqVg@public.gmane.org>
Subject: Re: Re: Call for help: list of machines with working S3
Date: Tue, 15 Feb 2005 13:17:15 +0000
Message-ID: <200502151317.15633.s0348365@sms.ed.ac.uk>
References: <20050214211105.GA12808@elf.ucw.cz> <200502150605.11683.s0348365@sms.ed.ac.uk> <4211E729.1090305@colitti.com>
Reply-To: s0348365-Y3tGgqFSo3OFxr2TtlUqVg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <4211E729.1090305-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>
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
To: Lorenzo Colitti <lorenzo-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>
Cc: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday 15 Feb 2005 12:12, Lorenzo Colitti wrote:
> Alistair John Strachan wrote:
> > On Monday 14 Feb 2005 21:11, Pavel Machek wrote:
> >>Table of known working systems:
> >>Model                         hack (or "how to do it")
> >>[...]
> >>HP NC6000   s3_bios (2)
> >
> > The above report is incorrect. On 2.6.11-rc4, even with the s3_bios
> > option, the NC6000 (which I own) still does not wake up from S3 sleep.
> > The wiki linked somewhere else in this thread also identifies these
> > machines as not working.
>
> I beg to differ: it works for me on 2.6.11-rc3 (even with the swsusp2
> patch). However, I need to use acpi_sleep=s3_bios, and I can't use
> radeonfb or it will lock up on resume.
>
> .config attached.
>

As recommended elsewhere in this thread, I'm not using any sort of framebuffer 
driver, but vesafb IS compiled in (but no vga= option is present). Does it 
need to be compiled out completely?

I have acpi_sleep=s3_bios on cmdline. I am not using swsusp2 (and I can't see 
how this is at all related to software suspend).

Perhaps it is the machine BIOS. Which version do you have?

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
