From: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>
Subject: Re: Re: Samsung P35 and S3 suspend
Date: Thu, 16 Dec 2004 19:41:57 +0100
Message-ID: <1103222517.5924.24.camel@mhcln03>
References: <41BFC3AD.5030001@gmx.net> <1103117333.5924.3.camel@mhcln03>
	 <41C07B6F.70900@gmx.net> <1103159022.5924.17.camel@mhcln03>
	 <41C0FFF3.4010902@gmx.net> <41C19BD8.7050201@gmx.net>
	 <41C1CFA2.20304@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41C1CFA2.20304-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Oliver Dawid <od-VRmHG7Xu4f31qYPpFx2fzhvVK+yQ3ZXh@public.gmane.org>, Stefan =?ISO-8859-1?Q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Am Donnerstag, den 16.12.2004, 19:10 +0100 schrieb Carl-Daniel
Hailfinger:
> Carl-Daniel Hailfinger schrieb:

[...]

> OK, it is working perfectly with the latest Linus -bk tree and
> everything configured in (SuSE .config, comparable to allmodconfig).
> The only things which are NOT enabled are:
> -CONFIG_REGPARM
> -CONFIG_HIGHMEM
> -CONFIG_EFI
> -CONFIG_FB
> -CONFIG_VIDEO_SELECT

I'll try that, thanks :)

> Before suspending, I start both X-Servers (like you) and then
> chvt 1
> modprobe -r uhci_hcd ehci_hcd ohci1394 snd_intel8x0
> sleep 5
> echo 3 >/proc/acpi/sleep

Basically the same here.

> Resume procedure is the same as yours.
> 
> I'm still trying to figure out what the Vesa X-Server does what
> can't be done with vbetest or similar.

Here's my theory:

All that is needed to bring back our card is:
1: VGA POST
2. VESA reset

The kernel parameter "acpi_sleep=s3_bios,s3_mode" would do just that.
But for some retarded reason, any kernel access to the card freezes the
machine.

Find the reason, and the kernel parameter should work perfectly.
Maybe even framebuffer could be used (and hence, bootsplash).


-- 
Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian SID. Geek by Nature, Linux by Choice



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
