From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: 2.6.0-test4 acpi problems
Date: Sun, 31 Aug 2003 02:19:41 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200308310219.41304.adq_dvb@lidskialf.net>
References: <20030830215116.GA1444@rootdir.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030830215116.GA1444-YJlxJerscEeELgA04lAiVw@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Claas Langbehn <claas-YJlxJerscEeELgA04lAiVw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Saturday 30 Aug 2003 10:51 pm, Claas Langbehn wrote:
> To: kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>
> Hello!
>
>
> I have got an Epox 8K9A9i mainboard with an Athlon XP 1800+ CPU. The
> chipset is an VIA KT400A. The bios is dated 12.05.2003.
> When booting with ACPI enabled, the interrupts dont get enumerated
> properly. with acpi=ht it works, but i dont have enough features.
> Below you see my bootlog with acpi and further down the bootlog with
> acpi=off. Is there a way to use full acpi support and "normal"
> interrupts? pci=noacpi was not really successful.
>
> How can I help acip development and do more debugging?

Aha, this is a known problem with the KT400 chipset. All BIOSes I've 
encountered for the KT400 have a nasty bug in the AML code which breaks ACPI 
IRQ routing.

The only way to make it work is to directly program the hardware itself. Via 
are sending me docs on the KT400, so I will add appropriate code to 
arch/i386/pci/irq.c for this board. As far as I can make out this is how 
Windows makes ACPI work on this board... it has specific hardware support for 
certain chipsets.

Hopefully I'll have something sometime next week.....



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
