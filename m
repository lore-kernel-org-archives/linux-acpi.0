From: Eric Valette <eric.valette@free.fr>
Subject: Re: [ACPI] Re: 2.6.8.1-mm1 hangs on boot with ACPI
Date: Thu, 19 Aug 2004 10:26:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <41246425.5000104@free.fr>
References: <566B962EB122634D86E6EE29E83DD808182C35CE@hdsmsx403.hd.intel.com>	 <1092898173.25911.224.camel@dhcppc4> <1092903048.6392.7.camel@dhcp-225.mlm.tactel.se>
Reply-To: eric.valette@free.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S263772AbUHSI0T@vger.kernel.org>
In-Reply-To: <1092903048.6392.7.camel@dhcp-225.mlm.tactel.se>
To: Pontus Fuchs <pontus.fuchs@tactel.se>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Pontus Fuchs wrote:
> On Thu, 2004-08-19 at 08:49, Len Brown wrote:
> 
>>>After upgrading to 2.6.8.1-mm1 from plain 2.6.8.1 my machine does not
>>>boot anymore. The last message i see is:
>>>
>>>ACPI: Processor [CPU0] (supports C1,C2,C3, 8 throttling states)
>>>
>>>In plain 2.6.8.1 the next messages would be:
>>>
>>>ACPI: Thermal Zone [THRM] (52 C)
>>>Console: switching to colour frame buffer device 175x65
>>>Linux agpgart interface v0.100 (c) Dave Jones
>>>agpgart: Detected SiS 648 chipset
>>>
>>>Booting with acpi=off works fine. I have also tried pci=routeirq but
>>>it
>>>does not make any difference.
>>>
>>>The machine is an Asus L5c laptop.
>>
>>Please try booting with "pci=routeirq"
>>If that doesn't work, please take stock 2.6.8.1 and apply the latest
>>patch here:
>>http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.8/
>>and give it a go.
>>
>>This will bring your kernel up to the same ACPI patch that is in the -mm
>>tree, but without all the other stuff in the mm tree.
>>
>>If it fails, then ACPI broke.  If it works, then something in -mm broke
>>ACPI.
> 
> 
> Hi,
> 
> I did what you suggested but the kernel still hangs. I have put the
> details on bugme.osdl.org:
> 
> http://bugme.osdl.org/show_bug.cgi?id=3233
> 
> Pontus Fuchs

Could you try the patch included in 
<http://bugme.osdl.org/show_bug.cgi?id=3191> as it fixes my L3C and the 
analysis of the problem may well lead to an ACPI crash...



-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr
