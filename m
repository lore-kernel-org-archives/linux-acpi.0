From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3
Date: Tue, 15 Feb 2005 23:40:37 +0100
Message-ID: <42127A65.3090104@gmx.net>
References: <20050214211105.GA12808@elf.ucw.cz>	 <20050215125555.GD16394@gamma.logic.tuwien.ac.at>	 <42121EC5.8000004@gmx.net> <20050215170837.GA6336@gamma.logic.tuwien.ac.at>	 <4212460A.4000100@gmx.net> <1108498875.12026.18.camel@elrond.flymine.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108498875.12026.18.camel-Xmbc1Sz64/5pghhO6/9/sx2eb7JE58TQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Matthew Garrett schrieb:
> On Tue, 2005-02-15 at 19:57 +0100, Carl-Daniel Hailfinger wrote:
> 
> 
>>Kendall Bennett is working with me to get suspend/resume working
>>even with framebuffers. Once we have results, I'll post them here.
> 
> 
> I've had success using vesafb with vbetool state restoration. vga16fb
> ought to work fairly happily.

Well, in my testing the machine deadlocked if any framebuffer was
active during resume. It even deadlocked *before* I could run vbetool.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
