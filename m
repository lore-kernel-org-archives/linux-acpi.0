From: Hanno =?ISO-8859-15?B?QvZjaw==?= <hanno-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: ACPI patches updated (20021205)
Date: Sat, 7 Dec 2002 16:54:51 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021207165451.3ecab0f0.hanno@gmx.de>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A57A@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A57A-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
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

I wanted to let you know that I still have those AE_ALREADY_EXISTS messages on boot.
I already sent you dmesg, lspci and dsdt-output. I can give you more info if you need.

evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode successful
   evgpe-0263: *** Info: GPE Block0 defined as GPE0 to GPE15
   evgpe-0263: *** Info: GPE Block1 defined as GPE16 to GPE31
Executing all Device _STA and_INI methods:................evrgnini-0243: *** Error: Could not install Pci_config handler for PCI0, AE_ALREADY_EXISTS
.evrgnini-0243: *** Error: Could not install Pci_config handler for PCI0, AE_ALREADY_EXISTS
...............................evrgnini-0243: *** Error: Could not install Pci_config handler for PCI0, AE_ALREADY_EXISTS
....evrgnini-0243: *** Error: Could not install Pci_config handler for PCI0, AE_ALREADY_EXISTS
...


-- 
Hanno Boeck - hanno-Mmb7MZpHnFY@public.gmane.org               /"\
                                         \ / ASCII Ribbon Campaign
Say no to DCMA, TCPA, Palladium!          X  Against HTML Mail
www.stop1984.com                         / \


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
