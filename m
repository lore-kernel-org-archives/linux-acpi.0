From: Erich Schubert <erich-yAnU9OPA7Idd/oRx+cCnAQ@public.gmane.org>
Subject: ACPI on Thinkpad A31p
Date: Mon, 18 Aug 2003 23:13:48 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030818211348.GA1194@legolas.drinsama.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,
i'm trying to get ACPI working on my IBM Thinkpad A31p.
I fear i'll need some DSDT patch as on my Dell Inspiron.
Len: Fyi: kernel: No local APIC present or hardware disabled
-- seems like my Thinkpad doesn't have a LAPIC.

Well, no to my actual problems:
- Most things work fine now, CPU throttling, AC
- The embedded controller threw a lot of errors, i applied the patch
from Jayan quoted by Yu Luming (comment out a block in ec.c)
- processor info has a "performance" file containing "0 MHz, 0 mW, 500 uS"
twice with no bogomips difference between these two states (throttling
does reduce the bogomips)
- battery "state" is broken throwing the following errors:
    ACPI-1121: *** Error: Method execution failed
    [\_SB_.PCI0.LPC_.EC__.GBST] (Node c12f41c0), AE_AML_INTERNAL
    ACPI-1121: *** Error: Method execution failed
    [\_SB_.PCI0.LPC_.EC__.BAT0._BST] (Node c12f4440), AE_AML_INTERNAL

The battery not telling its charging state is a major missing item.
Furthermore ACPI has no S1 on this machine.

It would be nice to know what to blame IBM for and what is maybe not yet
done in acpi. ;) -- i certainly do hope that IBM will provide some more
updates for this machine (especially for the WLAN card, whose firmware
has problems with hostap)

Thank you.

Greetings,
Erich


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
