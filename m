From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: acpi on new gateway laptops
Date: Mon, 17 Nov 2003 10:54:51 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031117104936.N60907@root.org>
References: <20031112232315.GD430@masanjin.net> <20031117102219.O60721@root.org>
 <20031117183900.GA32570@masanjin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031117183900.GA32570-xW3KcqxHEMnk1uMJSBkQmQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: William Morgan <wmorgan-xW3KcqxHEMnk1uMJSBkQmQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 17 Nov 2003, William Morgan wrote:
> Excerpts (reformatted) from Nate Lawson's mail of 17 Nov 2003 (EST):
> > Your DSDT attempts to access regions before there is an attached EC to
> > service the calls to that space, yes.  So the two approaches are to
> > provide an ECDT or change the DSDT to not reference those spaces early
> > in boot.  The problem with the latter option is that those accesses
> > may be crucial to initializing your laptop.  So if you remove them, it
> > may start up in a partially initialized state.  It's probably cleaner
> > to provide an ECDT.
>
> Thanks for your reply! That's the sentiment others have expressed as
> well---the easiest thing to do is provide an ECDT. Unfortunately, we're
> not really sure how to do this, and no one seems able (or willing!) to
> say.
>
> The ACPI spec describes the contents of the table, but it's not clear to
> me how, exactly, what the "processor relative address of the embedded
> controller command/status register, in generic address structure format"
> is supposed to be. How can we discover all these gory details about the
> EC?

Get the data from the DSDT.  Dump it with acpidmp, search for PNP0C09,
then write down the resources.  Mine is below:

                Device (EC)
                {
                    Name (_HID, EisaId ("PNP0C09"))
                    Name (_UID, 0x00)
                    Name (_GPE, 0x1C)
                    ...
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0062, 0x0062, 0x01, 0x01)
                        IO (Decode16, 0x0066, 0x0066, 0x01, 0x01)
                    })
                }

This corresponds to a GPE of 0x1c, control reg 0x66, data reg 0x62.  Below
is the correct ECDT for this EC:

  ECDT: Length=82, Revision=1, Checksum=5,
        OEMID=IBM, OEM Table ID=TP-1A, OEM Revision=0x1160,
        Creator ID=IBM, Creator Revision=0x1
        EC_CONTROL=0x66:0[8] (IO)
        EC_DATA=0x62:0[8] (IO)
        UID=0, GPE_BIT=0x1c
        EC_ID=\_SB.PCI0.LPC.EC

Note that I develop FreeBSD so Linux may have slightly different ways of
defining things.

-Nate


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
