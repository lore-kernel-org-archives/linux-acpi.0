From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: fix IRQ routing via DSDT at a NO-APIC unit
Date: Wed, 30 Jul 2003 17:44:59 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307301744.59796.adq_dvb@lidskialf.net>
References: <3F2778AA.7080806@paceblade.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3F2778AA.7080806-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Robert Woerle <robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday 30 July 2003 08:50, Robert Woerle wrote:
> Hi
>
> sorry for the question since i saw that this ( or a similar ) topic is
> already discussed , but i had the acpi-devel
> list running on digest mode and it is hard to follow a topic with that .
> Now switched back to to non-digest .
>
> My issue is :
> Can i fix a faulty IRQ-Routing via DSDT ?
> My unit has not a IO-APIC but a normal XT-PIC
> it also looks that some IRQ`s are provided already by the BIOS and so
> are active already .

One thing I spotted last night is that if neither IO-APIC or IO-SAPIC (ia64 
only) are enabled, linux ACPI does no _PRT initialisation.

Your bios (and mine!) both have the following style of entry in the _PRT 
returned in PIC mode:

                Package (0x04)
                {
                    0x0014FFFF,
                    0x00,
                    \_SB.PCI0.ISA.LNKU,
                    0x00
                },

So they definitely *should* have _PRT initialisation done.

This would explain whats happening.. your BIOS is setting up some IRQs as you 
say, but is relying on ACPI to set up the rest. 

Hopefully, this should be fixed by my upcoming PIC mode patch.



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
