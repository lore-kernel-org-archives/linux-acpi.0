From: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>
Subject: Re: S3 broken Samsung P35 - howto debug?
Date: Wed, 24 Nov 2004 17:28:36 +0100
Message-ID: <1101313716.7299.2.camel@mhcln03>
References: <200411211600.01820.od@fet.uni-hannover.de>
	 <1101064133.7220.15.camel@mhcln03> <41A4613F.2020905@helios.de>
	 <200411241354.53598.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200411241354.53598.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan =?ISO-8859-1?Q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Oliver Dawid <oliver-csNNzRR391izQB+pC5nmwQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Am Mittwoch, den 24.11.2004, 13:54 +0100 schrieb Stefan Dösinger:
> > Now its time to switch on my backlight ;-)
> The attached program may help you. It uses lrmi and vm86 to call the reset 
> routine of the VGA bios. I use it to wake up my radeon card.
> 
> You need the lrmi libaries.
> Compile with gcc boot-vga-bios.c -o boot-vga-bios -llrmi
> It's a user space program, you can call it eighter manually or better from a 
> script.

Yeah, I tried that already. Thanks for mentioning it though :)

If I call it before suspending my monitor goes black and can not be
revived w/o rebooting. If I call it after S3 (when the monitor is dead
anyways) it doesn't do anything. Would have been to easy :)
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
