From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: acpi on new gateway laptops
Date: Mon, 17 Nov 2003 12:07:30 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031117120555.E61216@root.org>
References: <20031112232315.GD430@masanjin.net> <20031117102219.O60721@root.org>
 <20031117183900.GA32570@masanjin.net> <20031117104936.N60907@root.org>
 <20031117193719.GB32570@masanjin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031117193719.GB32570-xW3KcqxHEMnk1uMJSBkQmQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: William Morgan <wmorgan-acpi-devel-xW3KcqxHEMnk1uMJSBkQmQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 17 Nov 2003, William Morgan wrote:
> Excerpts (reformatted) from Nate Lawson's mail of 17 Nov 2003 (EST):
> > Get the data from the DSDT.  Dump it with acpidmp, search for PNP0C09,
> > then write down the resources.  Mine is below:
>
> Hm, mine looks like this:
>
>   Device(H_EC) {
>       Name(_HID, 0x090cd041)
>       Name(_UID, 0x1)
>       Method(_CRS) {
>           Name(BFFR, Buffer(0x12) {0x47, 0x1, 0x62, 0x0, 0x62, 0x0, 0x0, 0x1, 0x47, 0x1, 0x66, 0x0, 0x66, 0x0, 0x0, 0x1, 0x79, 0x0 })
>           Return(BFFR)
>       }
>       OperationRegion(ECR_, EmbeddedControl, 0x0, 0xff)
>       ...
>   }
>
> So I'm guessing that this also corresponds to control reg=0x66 and data
> reg=0x62 as I see those two numbers in the buffer. So I think I should be able
> to use an ECDT that's identical to yours, except the EC_ID field (which in my
> case is "\_SB_.PCI0.LPCB.H_EC")....

Looks right but you need to get your _GPE bit also. I think it's 0x79
but you really need to parse the buffer to be sure.  There is a flag to
acpidmp to parse buffer contents.

-Nate


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
