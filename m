From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: PCI not restored correctly after suspend to ram
Date: 19 Mar 2004 23:47:32 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1079758052.7278.666.camel@dhcppc4>
References: <200403180935.09436.stefan.doesinger@gym-leoben.asn-graz.ac.at>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200403180935.09436.stefan.doesinger-dYJrdcitkgg0+Ua9VpOLR6Q1ief8SNuKXqFh9Ls21Oc@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: stefan.doesinger-dYJrdcitkgg0+Ua9VpOLR6Q1ief8SNuKXqFh9Ls21Oc@public.gmane.org
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Stefan,
Re: pci config space bit change on the host bridge after resume

- 00: 86 80 40 33 06 01 90 30 03 00 00 06 00 00 00 00
+ 00: 86 80 40 33 06 01 90 20 03 00 00 06 00 00 00 00

byte 7 bit 4 cleared -- that is the Received Target Abort bit
in the PCI status register.  It is probably set as a result
of us reading from a slot that isn't present.
As the status register is write-1-to clear,
you can't bring this bit back by writing to it even if you wanted to.

>fixpci.sh:
>#First device: Host bridge
>DEV=00:00.0
>echo "Configuring $DEV"
>
>$SETPCI -s $DEV 08.w=0x0330

I think this address is incorrect anyway, this will write bytes 8 an 9
when you wanted to write byte 7, yes?
 
$SETPCI -s $DEV 07.b=0x03

cheers,
-Len




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
