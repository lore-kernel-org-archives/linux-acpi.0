From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: S3 broken Samsung P35 - howto debug?
Date: Wed, 24 Nov 2004 22:21:45 +0100
Message-ID: <200411242221.45175.stefandoesinger@gmx.at>
References: <200411211600.01820.od@fet.uni-hannover.de> <200411242012.36750.stefandoesinger@gmx.at> <1101328293.7299.15.camel@mhcln03>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1101328293.7299.15.camel@mhcln03>
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
To: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>
Cc: Oliver Dawid <oliver-csNNzRR391izQB+pC5nmwQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> > The vgaboot.exe is a dos program which calls the reset routine. You can
> > try to run it from freedos / MS-Dos. vgaboot.asm is the source. I gzipped
> > the .exe because some mail servers seem to block it
>
> This one is new to me. But, excuse the maybe silly question, what good
> is a dos.exe to me when I need to POST the card in Linux? Does it work
> with wine or dosemu?
I wrote it to do some tests. It's only 2 lines of assembler, notthing special

> I'll burn a bootable DOS CD later today and see if it can POST the card.
> I don't have much hope since the code looks very familiar to radeon_boot
> (which doesn't work).
That's what it is good for: To test if the POST routine of you card works. If 
vgaboot.exe doesn't work in DOS, you'll have no chance


> It's a Radeon 9200 (see the attached lspci -vvv log for details)
I have an Radeon 9000 mobility and I started to reverse engineer the reset 
code and implement it in an 32 Bit protected mode linux kernel module. The 
code that is implemented seems to work on an M6 card and on my M9, so it's 
likely to work for yours. The Problem is that I stopped because school 
started again and it doesn't finish the reset yet. I assume about 50% to 60% 
are done already.

I can send you my code and you may continue it, but it might be dangerous. I 
have no documentation about the card, and the reset routine modifies high 
frequency PLL registers, which can be dangeros. No one(except ATI people) can 
say if my code is correct. It may do anything, including breaking your card & 
display, break your dishes, drown your cat(if you have one), .....

Cheers,
Stefan


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
