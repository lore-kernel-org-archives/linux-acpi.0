From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Re: Samsung P35 and S3 suspend
Date: Thu, 16 Dec 2004 19:10:42 +0100
Message-ID: <41C1CFA2.20304@gmx.net>
References: <41BFC3AD.5030001@gmx.net> <1103117333.5924.3.camel@mhcln03>	 <41C07B6F.70900@gmx.net> <1103159022.5924.17.camel@mhcln03> <41C0FFF3.4010902@gmx.net> <41C19BD8.7050201@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41C19BD8.7050201-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Oliver Dawid <od-VRmHG7Xu4f31qYPpFx2fzhvVK+yQ3ZXh@public.gmane.org>, =?ISO-8859-1?Q?Stefan_D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Carl-Daniel Hailfinger schrieb:
> Carl-Daniel Hailfinger schrieb:
> 
>>Matthias Hentges schrieb:
>>
>>
>>>Am Mittwoch, den 15.12.2004, 18:59 +0100 schrieb Carl-Daniel Hailfinger:
>>>
>>>
>>>>Oh, and once I get S3 working with 2.6.9 I'll do a binary search
>>>>to find the changeset that is causing the problems after 2.6.9
>>>>and report back.
>>>
>>>That would be most appreciated. I still haven't fully recovered from
>>>trying 30+ kernels / configurations to find the borked patch ;)
>>
>>A first hint: CONFIG_REGPARM killed swsusp in some kernels before
>>2.6.10-rc3, it could also be the culprit for S3.
> 
> OK, I got S3 working with all kernels since 2.6.9 (well, your patches
> had to be modified slightly). Right now I'm running on the latest
> Linus -bk tree.
> 
> I will now try other configurations and a full bootup.

OK, it is working perfectly with the latest Linus -bk tree and
everything configured in (SuSE .config, comparable to allmodconfig).
The only things which are NOT enabled are:
-CONFIG_REGPARM
-CONFIG_HIGHMEM
-CONFIG_EFI
-CONFIG_FB
-CONFIG_VIDEO_SELECT

Before suspending, I start both X-Servers (like you) and then
chvt 1
modprobe -r uhci_hcd ehci_hcd ohci1394 snd_intel8x0
sleep 5
echo 3 >/proc/acpi/sleep

Resume procedure is the same as yours.

I'm still trying to figure out what the Vesa X-Server does what
can't be done with vbetest or similar.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
