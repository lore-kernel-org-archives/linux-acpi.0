From: "Paulo Vitor Magacho da Silva" <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: RE: EC issue on Acer Aspire 1520
Date: Mon, 04 Jul 2005 12:45:58 -0300
Message-ID: <BAY10-F12BCFD8D6707925BC2115AA8E70@phx.gbl>
References: <3ACA40606221794F80A5670F0AF15F8408A272E9@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8408A272E9@pdsmsx403>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello

I've sent an email about the EC confusion I had with an Acer Aspire 1613lmi. 
I have a few updates.
First, kernel 2.6.12-rc2-mm2 doesn't show the EC confusion problem. However 
with this kernel when I resume from S3 the laptop just reboots. I replace 
the wakeup.S of kernel 2.6.12-rc2-mm2 with the one in kernel 2.6.7. With 
this new wakeup code, the laptop doesn't reboot, but the ethernet card 
doesn't work afterwards. I get some WATCHDOG errors.
I still want to try to find out exaclty which line in the wakeup.S code 
makes the laptop reboot.

Paulo

>From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>To: "ACPI devel" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
>Subject: [ACPI] EC issue on Acer Aspire 1520
>Date: Thu, 30 Jun 2005 15:06:56 +0800
>
>All,
>I recall there was bug reports on this ML about slow -ec-access issue on
>Acer Aspire 1520 and ASUS L5D.
>I want to know if it is only observed with sbs-cm package? If so, please
>test 2.6.12-rc4-mm2 without sbs-cm
>package. I just have chance to run 2.6.12-rc4-mm2 with
>burst-mode-ec-patch on a Acer aspire 1520  today.
>And  it looks just ok.
>

_________________________________________________________________
MSN Messenger: converse online com seus amigos .  
http://messenger.msn.com.br



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
