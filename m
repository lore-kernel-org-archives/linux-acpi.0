From: Kendall Bennett <kendallb-uto6oM0aG36m1FQbPH9wZw@public.gmane.org>
Subject: Re: [RFC] Reliable video POSTing on resume
Date: Thu, 10 Feb 2005 12:46:12 -0800
Message-ID: <420BC814.4050102@scitechsoft.com>
References: <1107695583.14847.167.camel@localhost.localdomain>	 <420BB267.8060108@tmr.com> <20050210192554.GA15726@sci.fi>	 <1108066096.4085.69.camel@tyrosine>	 <9e473391050210121756874a84@mail.gmail.com>	 <1108067388.4085.74.camel@tyrosine> <9e47339105021012341c94c441@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e47339105021012341c94c441-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, =?ISO-8859-1?Q?Ville_Syrj=E4?= =?ISO-8859-1?Q?l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>, Bill Davidsen <davidsen-sQDSfeB7uhw@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Guys,

I have missed all the original emails in this thread. I was trying to 
re-subscribe to the lkml a few days ago (I just switched over to 
Thunderbird) but I haven't been getting any traffic. So I will try again.

The one thing I can say is that having worked extensively with ATI 
cards, there are some registers that have an effect on whether the BIOS 
image shows up on at the ROM BAR address or not. To get all the ATI 
cards we have working, we have had to massage some of those registers 
because after the POST has been run, they will cause the BIOS image to 
disappear (not intentionally on ATI's part, but a side effect I think).

Note that the cards that require this work just fine if they are in a 
cold boot state when you run the POST - they only have issues after the 
POST code has been run (which actually affects X drivers trying to read 
the BIOS PLL information too).

So perhaps this problem is something similar?

Regards,

Jon Smirl said the following on 2/10/2005 12:34 PM:
> I added Kendall from Scitech to the CC list. He is the expert on
> getting VBIOS's to post. Maybe he can help.
> 
> On Thu, 10 Feb 2005 20:29:47 +0000, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org> wrote:
> 
>>On Thu, 2005-02-10 at 15:17 -0500, Jon Smirl wrote:
>>
>>>On Thu, 10 Feb 2005 20:08:15 +0000, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org> wrote:
>>>
>>>>It also explicitly states that Windows 2000 and XP don't support this,
>>>>which leads me to suspect that vendors no longer expect POSTing to be
>>>>possible after initial system boot.
>>>
>>>No, it means that some of my ATI cards don't function as secondary
>>>adapters on 2K and XP.
>>
>>And nor will any other card that requires POSTing (assuming that it
>>isn't just ATI being less than honest about driver shortcomings). And
>>we've certainly seen in the past that removing support for functionality
>>in Windows tends to result in hardware no longer supporting that
>>functionality.
>>
>>I have real, shipping hardware here that fails if you simply try to
>>execute the video BIOS POST code. If you think this is due to a
>>shortcoming in existing BIOS emulations, I'm more than happy to dump the
>>video and system BIOS regions and send them to you.
>>
>>--
>>Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
>>
>>
> 
> 
> 

-- 
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
