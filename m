From: Kendall Bennett <kendallb-uto6oM0aG36m1FQbPH9wZw@public.gmane.org>
Subject: Re: [RFC] Reliable video POSTing on resume
Date: Thu, 10 Feb 2005 13:20:58 -0800
Message-ID: <420BD03A.3030501@scitechsoft.com>
References: <1107695583.14847.167.camel@localhost.localdomain>	 <420BB267.8060108@tmr.com> <20050210192554.GA15726@sci.fi>	 <1108066096.4085.69.camel@tyrosine>	 <9e473391050210121756874a84@mail.gmail.com>	 <1108067388.4085.74.camel@tyrosine>	 <9e47339105021012341c94c441@mail.gmail.com>	 <420BC814.4050102@scitechsoft.com> <1108069596.4085.78.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1108069596.4085.78.camel@tyrosine>
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
Cc: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>, Bill Davidsen <davidsen-sQDSfeB7uhw@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Matthew Garrett said the following on 2/10/2005 1:06 PM:
> On Thu, 2005-02-10 at 12:46 -0800, Kendall Bennett wrote:
> 
> 
>>So perhaps this problem is something similar?
> 
> 
> I don't think so - if I dd out of ROM, I get something that looks like a
> video BIOS (and, indeed, I can make VBE calls to and from it). The
> problem is jumping to c000:0003 and executing - this has the effect of
> turning off the backlight and giving an illegal instruction error
> (I /think/ - I may be getting the machine I have here confused with one
> a tester has...)

Laptops are a little different as they will make calls from the Video 
BIOS into the system BIOS, so you need to make sure that the system BIOS 
is also available in the execution environment. So if you are using an 
x86 emulator, you need to make sure the system BIOS is mapped into the 
emulator image and that any necessary resources it might need are available.

Regards,

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
