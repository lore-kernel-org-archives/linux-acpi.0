From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Re: Samsung P35 and S3 suspend
Date: Thu, 16 Dec 2004 18:32:09 +0100
Message-ID: <200412161832.09711.stefandoesinger@gmx.at>
References: <41BFC3AD.5030001@gmx.net> <41C0FFF3.4010902@gmx.net> <41C19BD8.7050201@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41C19BD8.7050201-hi6Y0CQ0nG0@public.gmane.org>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004-hi6Y0CQ0nG0@public.gmane.org>, Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>, Oliver Dawid <od-VRmHG7Xu4f31qYPpFx2fzhvVK+yQ3ZXh@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


> OK, I got S3 working with all kernels since 2.6.9 (well, your patches
> had to be modified slightly). Right now I'm running on the latest
> Linus -bk tree.
>
> I will now try other configurations and a full bootup.
Just a note about 2.6.10-rc2/3 kernels: I also had some Problems with them. 
snd-Intel8x0 needs an update concerning PCI config save/restore and ehci-hcd 
causes problems after resume. uhci-hcd suspend/resume works for me, except 
that I must not plug or unplug usb devices while the system is supended.

> Besides that, I think we could convince the X.Org developers that
> the "get display working" bug is their problem ;-)
> It seems they have merged some suspend/resume bugfixes for Radeon and
> will merge at least one more bugfix in the next few days. Basically,
> it should be possible that the normal Radeon Xserver rePOSTs the card
> itself once it detects a resume event. If that is done properly, we
> could get rid of the hack completely and would only have to live with
> the text console.
No, I think it's the kernels problem. The various framebuffer drivers should 
know how to wake up the card.
There were some discussions on the linux-fbdev-devel list about writing a 
lightwhight(20-30k) 8086 emulator for the kernel to avoid real mode hacks.
As far as I know, this should be based on the 8086 emulator XFree/X.org uses.

Cheers,
Stefan


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
