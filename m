From: Robert Vollmert <rvollmert-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Shuttle SB61G2 fan speed
Date: Thu, 9 Oct 2003 00:55:14 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031008225514.GA4583@krikkit>
References: <E1A7IkI-0004qc-8W@cell01.cell01.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1A7IkI-0004qc-8W-6vcCkRnH9/iXl4vLVl4uKAC/G2K4zDHf@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Eric Northup <digitale-eFwX6J65rk/J8bqQQ1YlwQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

On Wed, Oct 08, 2003 at 02:09:10PM -0400, Eric Northup wrote:
> I've posted it at http://www.digitaleric.net/dsdt.gz

Thanks.

I think that for fan control via ACPI to work, the fan device should
specify an associated power resource that provides _ON/_OFF methods
for starting and stopping the fan. Your DSDT doesn't appear to do
that.

You could try calling FON/FOFF manually to see if those methods work,
at least. I don't know how to best do this, though. When I did that
kind of testing, I modified the asus_acpi module. But maybe there's an
easier way to do this?

If these work, and the missing power resource thing is correct, maybe
you could add one to your DSDT? You should be able to find working
code in some of the DSDTs posted on acpi.sf.net. FYI, the relevant
code for the ASUS M2N is

Name (FAN1, 0x00)

Device (FN00)
{
    Name (_HID, EisaId ("PNP0C0B"))

    Name (_PR0, Package (0x01)
    {
        GFAN
    })
}

PowerResource (GFAN, 0x00, 0x0000)
{
    Method (_STA, 0, NotSerialized)
    {
        Return (FAN1)
    }

    Method (_ON, 0, NotSerialized)
    {
        Store (0x01, FAN1)
    }

    Method (_OFF, 0, NotSerialized)
    {
        Store (0x00, FAN1)
    }
} 

If you modified _ON to call FON and _OFF to call FOFF, and adapted
your fan device to reference the power resource, this might work. Of
course, it's quite possible that it won't, especially since fan
control in that notebook doesn't really work as suggested by the ACPI
spec. Also, please note that a lot of this is speculation.

>  I also re-compiled the kernel with ACPI debugging enabled.  Here is the
> relevant (I think) part of dmesg (I can put the whole thing but its long
> so I'm not sending it unless it would be helpful)

As far as I can tell, this is OK. Temperature reporting also appears
to work.

Cheers
Robert


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
