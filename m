From: downtime null <downtime-4ZEeE0JWFE8uNY9OAzV8TA@public.gmane.org>
Subject: Re: ACPI on Travelmate c100
Date: Tue, 07 Sep 2004 14:14:20 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1094584459.4263.25.camel@zen.localnet>
References: <1094056399.6160.17.camel@zen.localnet>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1094056399.6160.17.camel-mA+20SYq9KgXpj0+iOhflA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2004-09-01 at 11:33, downtime null wrote:
> I'm trying to get the ACPI stuff working an my Acer Travelmate c100.
> I've seen a couple of posts about this, but I'm not able to get it
> working. I found the patch from John Turney at
> http://sourceforge.net/mailarchive/forum.php?thread_id=3854113&forum_id=6102 and manually applied the changes to my kernel, but upon reboot with the new kernel, the system reboots very early in the boot process. I don't understand the kernel code well enough to do much hacking on it, so I was wondering if anyone had any good resources on getting this working. I'm using Fedora Core 2 with the updated kernel.
> 
> $ uname -a
> Linux zen.localnet 2.6.8-1.521custom #6 Sat Aug 28 18:12:02 CDT 2004
> i686 i686 i386 GNU/Linux
> 
> Any help is appreciated.
> 
> Thanks,
> 
> Russell
> 

Where would I start to try and correct the ACPI problem. Apparently, the
2.6.x kernel will not enable the ACPI if there is an error. If I run
dmesg, I get :

ACPI: RSDP (v000 Acer                                      ) @
0x000ec2d0
  >>> ERROR: Invalid checksum

The BIOS memory map looks like :

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffc0000 (usable)
 BIOS-e820: 000000000ffc0000 - 000000000ffe0000 (reserved)
 BIOS-e820: 000000000ffe0000 - 000000000ffe8000 (ACPI data)
 BIOS-e820: 000000000ffe8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)

running acpidmp from pmtools gives me this :

RSDP "Acer" @ 0x000ec2d0
  0000: 52 53 44 20 50 54 52 20 00 41 63 65 72 20 20 00  RSD PTR .Acer 
.
  0010: 00 00 00 00                                      ....
 
acpidmp: cannot map the RSDT


As stated in my first email, I tried manually applying the patch
provided in that post. I say I manually applied it because all 3 hunks
failed when I tried to use 'patch -p1'. I have some knowledge of
programming, but I don't completely understand what the patch is trying
to do and I don't know how to get debugging information from the kernel;
especially since these changes to the kernel just cause it to reboot
when it hits the ACPI init.

Any help is appreciated.

Thanks.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
