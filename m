From: Lorenzo Colitti <lorenzo-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Re: Call for help: list of machines with working S3
Date: Tue, 15 Feb 2005 22:09:26 +0100
Message-ID: <42126506.8020407@colitti.com>
References: <20050214211105.GA12808@elf.ucw.cz>	 <1108482083.12031.10.camel@elrond.flymine.org>	 <42122054.8010408@colitti.com>  <200502151742.55362.s0348365@sms.ed.ac.uk> <1108500194.12031.21.camel@elrond.flymine.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108500194.12031.21.camel-Xmbc1Sz64/5pghhO6/9/sx2eb7JE58TQ@public.gmane.org>
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
Cc: Alistair John Strachan <s0348365-Y3tGgqFSo3OFxr2TtlUqVg@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Matthew Garrett wrote:
>>                Vendor: Hewlett-Packard
>>-               Version: 68BDD Ver. F.0F
>>-               Release Date: 07/23/2004
>>+               Version: 68BDD Ver. F.11
>>+               Release Date: 11/22/2004
> 
> 
> Ok, so you both have different BIOS versions and different CPUs.

S3 works for me with both BIOS F.0F, which I was using before, and F.11, 
which I flashed today after learning it existed.

> Everything else looks pretty identical. Could you both
> stick /proc/acpi/dsdt up somewhere so I can check if there are any
> relevant looking differences?

I would advise trying to compile a custom kernel from scratch with my 
.config first.

I got S3 working first with a very basic kernel config, but I couldn't 
get it to work with my usual kernel. Assuming it was some feature that 
caused the problem, I started disabling features in the hope of getting 
it to work, but I ended up with two different kernels with seemingly 
irrelevant differences, of which one would succesfully resume and one 
wouldn't. So I started added features to the other kernel, and I never 
found out what caused the problem.

I'm not saying that this is not deterministic, but I am saying that, at 
least in my case, it's not obvious what it is that stops S3 from 
working. :-)


Cheers,
Lorenzo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
