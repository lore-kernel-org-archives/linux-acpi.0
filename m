From: Aman Gupta <acpi-e31a5gnSYeGubukWoKzokaxOck334EZe@public.gmane.org>
Subject: Re: Radeon PM Support
Date: Thu, 19 Aug 2004 15:37:19 +0000 (UTC)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <loom.20040819T173209-640@post.gmane.org>
References: <88056F38E9E48644A0F562A38C64FB6002A92B31@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Pallipadi, Venkatesh <venkatesh.pallipadi@...> writes:
> 
> I guess we need to do something like this "acpi_sleep=vgapost", 
> rather than doing a generic vgapost for all display devices. 
> As the generic solution seems to have broken few systems 
> which were working before.
> 
> I have two systems with almost identical video setup, with 
> Radeon 9000M AGP adapter. vgapost works on one system and 
> fails on another. The failing system never returns 
> from real mode vgapost call. I also found that 
> the VBIOS is not same on these two systems. Probably 
> different versions of the firmware. I am digging further 
> to find out why it works on one Radeon 9000M and not 
> on another one. 
> 
> -Venki


Does vgapost work if you do it on the commandline using the
http://www.doesi.gmxhome.de/linux/tm800s3/resources/boot-radeon.c utility? Are
there any differences in the lspci -vv output of the two cards? Are they both on
1:0.0?

Can you post a patch that implements acpi_sleep=vgapost so it can be tested on
different systems?

  Aman Gupta



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
