From: Bob Weber <rjweber-EkmVulN54Sk@public.gmane.org>
Subject: Re: Compile problem in DSDT.dsl file
Date: Wed, 19 Jan 2005 22:46:58 -0800
Message-ID: <200501192246.58642.rjweber@ieee.org>
References: <200501101200.13340.rjweber@ieee.org> <20050117130819.GA8558@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050117130819.GA8558-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 17 January 2005 5:08 am, Karol Kozimor wrote:
> A rebranded ASUS, M3N in this case. Someone once suggested to move those
> statements to an _INI method, please search the archives for the exact
> solution.

Thanks for the response Karol. I did find similar references in the archives, 
but I couldn't find any suggestion of moving them to an _INI method. All I 
could find was to comment them out. So, I did this (note the /*    */).

    Name (_S0, Package (0x04)
    {
        0x00, 
        0x00, 
        0x00, 
        0x00
    })
    
    /* If (SS1)
    {
        Name (_S1, Package (0x04)
        {
            0x02, 
            0x00, 
            0x00, 
            0x00
        })
    }

    If (SS3)
    {
        Name (_S3, Package (0x04)
        {
            0x05, 
            0x00, 
            0x00, 
            0x00
        })
    }

    If (SS4)
    {
        Name (_S4, Package (0x04)
        {
            0x06, 
            0x00, 
            0x00, 
            0x00
        })
    }
    */
 
I question this fix. It seems moving them would be more appropriate, but let's 
just see if I can boot up. I believe these deal with sleep states, right? 
Recompiling results in several errors about methods not returning values, but 
it builds. I'm looking for ideas on what I should really do to fix this dsdt. 
This seems to be a common compiling problem. 

I also checked the posted DSDT table for an Asus M3N on the website (custom). 
It will not compile either, with the same error. Maybe this is a check that 
wasn't enforced on previous compilers, or I'm looking at the wrong dsdt file.

I patched the 2.6.10 kernel and rebuilt it to include my new dsdt.hex file. 
But, it still freezes at boot-up unless I include acpi=off as a boot arg. 
When I do include "acpi=off" and boot-up, I do an acpidmp to see if the new 
dsdt file has been loaded, and it looks the same as the original, but maybe 
acpi=off keeps the new dsdt from being used. Do I need to do anything more to 
get the new dsdt file loaded at boot-up? 

How can I better debug what's going on? When the sysem freezes after "loading 
kernel ...", it's kind of hard to get anywhere.

- Bob

On Monday 17 January 2005 5:08 am, Karol Kozimor wrote:
> Thus wrote Bob Weber:
> > Hello. I've had ACPI working on my laptop, but with the latest kernel I
> > cannot boot unless I have "acpi=off".
> >
> > After reading up on the linux ACPI effort, I decided to try and tackle
> > this. I have an enpower ENP24004 centrino-based system. With an Intel
> > chipset, I figured chances are good that the only issue is in the DSDT
> > table.
> >
> > I've extracted the DSDT code, and when I compile it with "iasl -tc
> > dsdt.dsl", I get the following:
> >
> > Intel ACPI Component Architecture
> > ASL Optimizing Compiler / AML Disassembler version 20030918 [Sep 18 2003]
> > Copyright (C) 2000 - 2003 Intel Corporation
> > Supports ACPI Specification Revision 2.0b
> >
> > dsdt.dsl  7573:     If (SS1)
> > Error    1037 -      ^ parse error, unexpected PARSEOP_IF
>
> A rebranded ASUS, M3N in this case. Someone once suggested to move those
> statements to an _INI method, please search the archives for the exact
> solution.
> Best regards,

-- 
----------------------------------------------------------------------------
The only maxim of a free government ought to be to trust no man living with
power to endanger the public liberty. -John Adams, 2nd US president
(1735-1826)


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
