From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Presario R3120US not updating present rate
Date: Tue, 15 Jun 2004 12:09:54 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040615100954.GO1095@poupinou.org>
References: <20040614215520.GA17906@dominikbrodowski.de> <40CE5F69.7030500@pacific.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <40CE5F69.7030500-s7p20SfEDVaVc3sceRu5cw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ken Hughes <khughes-s7p20SfEDVaVc3sceRu5cw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jun 14, 2004 at 07:31:05PM -0700, Ken Hughes wrote:
> I noticed that I alway get "present rate: 0 mA" when I
> cat /proc/acpi/battery/BAT1/state .  Running acpi -ab
> gives the following:
> 
>  35 budgie: ./acpi -ab
>      Battery 1: charging, 88%, charging at zero rate - will never fully 
> charge.
>    AC Adapter 1: on-line
>  36 budgie: ./acpi -ab
>      Battery 1: discharging, 88%, charging at zero rate - will never 
> fully charge.
>    AC Adapter 1: off-line
> 
> The DSDT is attached - any hints?
> 

You have that in the ASL:
	Device (BAT1)
	{
	    Name (_HID, EisaId ("PNP0C0A"))
	    Name (_UID, 0x01)

            ...
            ...

	    Name (PBST, Package (0x04)
	    {
		0x01, 
		0xFFFFFFFF, 
		0xFFFFFFFF, 
		0x39D0
	    })

            ...
            ...

	    Method (_BST, 0, NotSerialized)
	    {
		If (ECOK ())
		{
		    Sleep (0x14)
		    Store (\_SB.PCI0.LPC0.EC0.BST0, Local0)
		    And (Local0, 0x07, Local0)
		    Store (Local0, Index (PBST, 0x00))
		    Sleep (0x14)
		    Store (\_SB.PCI0.LPC0.EC0.GAU0, Local2)
		    Sleep (0x14)
		    Store (\_SB.PCI0.LPC0.EC0.BPV0, Index (PBST, 0x03))
		    Sleep (0x14)
		    Store (\_SB.PCI0.LPC0.EC0.BFC0, Local1)
		    Sleep (0x14)
		    If (Local2)
		    {
			Multiply (Local2, Local1, Local2)
			Divide (Local2, 0x64, Local6, Local2)
			If (Local6)
			{
			    Increment (Local2)
			}
		    }

		    Store (0x00, Index (PBST, 0x01))
		    Store (Local2, Index (PBST, 0x02))
		}

		Return (PBST)
	    }

The 'Store(0, Index(PBST, 0x01))' will put 0 in the second entry to the
PBST.  This entry match the present-rate.  As you can see, 0 will always
be put, so it's a DSDT trouble, not a linux one unfortunately.

Cheers, 


-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
