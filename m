From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3
Date: Thu, 17 Feb 2005 21:34:22 +0100
Message-ID: <4214FFCE.4080703@gmx.net>
References: <20050214211105.GA12808@elf.ucw.cz> <1108621005.2096.412.camel@d845pe> <1108638021.4085.143.camel@tyrosine> <4214C3B8.30502@gmx.net> <20050217195456.GA5963@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050217195456.GA5963-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org>
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
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Pavel Machek schrieb:
> 
>>>to reinitialise the graphics hardware, few are going to care about
>>>making life easier for Linux.
>>
> [...]
>>3. Get some shiny certification/label going that can be put on
>>fully conforming products as a sticker. Something like the old
>>"EPA pollution preventer" logo, but with a more appealing design.
>>Perhaps a "InstantOn/PowerSave" sticker, you get the idea.
> 
> Like "This machine actually works" sticker? :-)

Yes.

>>4. Include a mandantory description of video bringup after resume
> 
> That sounds overcomplicated. Simply add this to the specs:

You have to start to think like a vendor with a long legacy. Then my
spec draft will make more sense. Basically, you can't tell a vendor
that his hardware is broken or he will ignore your efforts from that
point on. "It's a question of honour." If, on the other hand, a
vendor can claim his products are conforming to the spec by issuing
a software update for broken hardware, it is much more likely that
the spec gets accepted.

> "BIOS must POST video during S3 wakeup. Video must be working
> and in 80x25 text mode when it jumps to OS. VESA BIOS calls must be
> available to the OS."

That would make some products non-conformant which are working
perfectly today. If the video state is preserved over S3, it doesn't
make sense to declare that behaviour non-conformant.

> BIOS must do that during normal boot; this should be very little
> additional work.

Not necessarily. Some BIOSes stay in graphics mode during the whole
bootup (at least it seems so) and would have to include additional
code to enter 80x25 text mode.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
