From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: S3 broken Samsung P35 - howto debug?
Date: Wed, 24 Nov 2004 13:54:53 +0100
Message-ID: <200411241354.53598.stefandoesinger@gmx.at>
References: <200411211600.01820.od@fet.uni-hannover.de> <1101064133.7220.15.camel@mhcln03> <41A4613F.2020905@helios.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dSIpBo7Rjp7E0Mf"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41A4613F.2020905-csNNzRR391izQB+pC5nmwQ@public.gmane.org>
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
Cc: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>, Oliver Dawid <oliver-csNNzRR391izQB+pC5nmwQ@public.gmane.org>, Oliver Dawid <od-VRmHG7Xu4f31qYPpFx2fzhvVK+yQ3ZXh@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--Boundary-00=_dSIpBo7Rjp7E0Mf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


> Now its time to switch on my backlight ;-)
The attached program may help you. It uses lrmi and vm86 to call the reset 
routine of the VGA bios. I use it to wake up my radeon card.

You need the lrmi libaries.
Compile with gcc boot-vga-bios.c -o boot-vga-bios -llrmi
It's a user space program, you can call it eighter manually or better from a 
script.

Cheers,
Stefan

--Boundary-00=_dSIpBo7Rjp7E0Mf
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="boot-vga-bios.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="boot-vga-bios.c"

#define LRMI_DEBUG 1

#include <stdlib.h>
#include <stdio.h>
#include <lrmi.h>

void err(char *function, int exitval) {
	fprintf(stderr, "%s():\n");
	exit(exitval);
}

int main () {
	struct LRMI_regs regs;
	
	ioperm(0, 1024, 1);
	iopl(3);

	if (!LRMI_init()) {
		err("LRMI_init", 1);
	}

	memset(&regs, 0, sizeof(regs));
	
	/*
	   if ((pvp = xf86GetPciInfoForEntity(pInt->entityIndex)))
	   	X86_AX = (pvp->bus << 8) | (pvp->device << 3) | (pvp->func & 0x7);
	   pushw(pInt, X86_CS);
	   pushw(pInt, X86_IP);
	   X86_CS = pInt->BIOSseg;
	   X86_EIP = 0x0003;
	   X86_ES = 0;                  // standard pc es 
	*/

	regs.eax = ((1 << 8) | (0 << 3) | (0 & 0x7)) & 0x0000FFFF;
	regs.cs = 0x0000c000;
	regs.ip = 0x00000003;
	//regs.ip = 0;
	//regs.es = 0;

	if (!LRMI_call(&regs)) {
		err("LRMI_int", -1);
	}


	exit(0);
}

--Boundary-00=_dSIpBo7Rjp7E0Mf--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
