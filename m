From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: How do you disable PCI steering in ACPI?
Date: Sun, 27 Jul 2003 14:31:22 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307271431.22011.adq_dvb@lidskialf.net>
References: <200307261928.09994.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200307261928.09994.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?q?S=E9rgio=20Monteiro=20Basto?= <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I thought this was a more appropriate list to ask this question, since it is 
directly ACPI related.

I've tracked down the remaining issue in my board. The problem appears to be 
the "PCI IRQ steering".. where it maps the PCI IRQs onto the XT-PIC IRQs.

If you remember, my problem was that I received no IRQs from any PCI expansion 
cards.

In my BIOS's PCI/PnP config section, I am able to configure IRQ steering. For 
IRQs < 15, I can say "PCI", or "reserved". If I mark all IRQs as "reserved", 
then onboard PCI devices start working perfectly. 

What I think is happening is the PCI IRQs are attached to both the APIC AND 
the XT-PIC. The XT-PIC is then conflicting with the IO-APIC, and is pulling 
the lines up/down innappropriately.

In Windows, it must be disabling the PCI IRQ->XT-PIC attachment.

I need a generic way to configure this. Actually configuring this sort of this 
seems to be chipset-specific, so I assume theres a way of doing it in ACPI. 
Does anyone have any ideas what this method might be? I've tried various 
things, none of which work correctly.

The changing BIOS config trick is not a long term solution: not all BIOSes let 
you do this.



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
