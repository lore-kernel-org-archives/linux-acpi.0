From: Timo Aaltonen <tjaalton-kf+aQKke1yb1KXRcyAk9cg@public.gmane.org>
Subject: suspend on IBM Thinkpad T23 almost working
Date: Fri, 20 Aug 2004 11:17:58 +0300 (EEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.OSF.4.58.0408201102290.304585@replicant.hut.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


	Hi

  I've compiled 2.6.8.1 with the latest acpi-patch
(acpi-20040715-2.6.8.diff). I'm running it with pci=noapic, and things
seem to be fine, but suspend is not really what it tries to be. It
consumes a lot more power than it should, and compared to APM-suspend the
rightmost led ("->X") is lit (whatever that means). I've tried removing
USB (uhci-hcd) and PCMCIA (yeanta_socket), but they didn't help. What
next?

ps. vesafb breaks after first suspend-resume-cycle, so I have to use plain
vga console

pps. iasl doesn't compile on Debian:

cc -Wall -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../include
-c -o aslcompilerlex.o aslcompilerlex.c
aslcompiler.l: In function `comment':
aslcompiler.l:837: error: `yytext_ptr' undeclared (first use in this function)
aslcompiler.l:837: error: (Each undeclared identifier is reported only once
aslcompiler.l:837: error: for each function it appears in.)
make: *** [aslcompilerlex.o] Error 1


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
