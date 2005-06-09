From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: EC confusion
Date: Thu, 9 Jun 2005 14:51:26 +0800
Message-ID: <20050609065126.GA8009@linux.sh.intel.com>
References: <BAY1-F127B656D271A56CE966C54A8FD0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BAY1-F127B656D271A56CE966C54A8FD0-MsuGFMq8XAE@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Paulo Vitor Magacho da Silva <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 2005.06.08 19:04:13 -0300, Paulo Vitor Magacho da Silva wrote:
> Hi,
> 
>  I know this subject has been alredy addressed but I still couldn't get my 
> laptop to work. If hit Fn+F4 (Sleep button) nothing happens. If I hit 
> several times it starts working. If I hit Fn+F5 (to turn off the LCD) it 
> confuses with Fn+F4. And if I hit a few times it starts to work.

I got some reports for this kind of issue on ASUS L5D and Acer 1520.
This is another report for the issue that burst-mode-ec patch could have
bug on these models.

>  The last working kernel version I had was 2.6.7, but this kernel has some 
> problems with usb and my network card driver after resume.
>  I am trying to use kernel 2.6.11.11, with the following patches:
>  - ACPI DSDT in initrd from http://gaugusch.at/kernel.shtml

Is this DSDT modified one? Why?

>  - EC patches from http://bugme.osdl.org/show_bug.cgi?id=4124, one from 
> 04/02/2005 and the other from 04/04/2005. I can't exactly tell which they 
> are because the bugme.osdl.org webpage is down at the moment.
>  I've also tryed the S3 test patch of Shaohua Li. No problems found.
>  My laptop is Acer Aspire 1613Lmi.

Send me dmesg, acpidmp. 

> 
> Thanks,
> Paulo
> 

Thanks,
Luming


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
