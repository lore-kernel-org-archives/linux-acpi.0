From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: problems with PRT and PCI routing table
Date: Fri, 14 Mar 2003 10:42:30 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A1FA@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Referencing the ASL below, I believe the ASL is wrong.

Specifically the sequence should be:

1) Create IRQ resource template(s)
2) Fill in IRQ information
3) Return resource template

However, the below ASL appears to have #2 *after* an if/else that
returns the empty template. In addition, the code that does #3 only
seems to fill in the IRQ template, not the Interrupt template. (you use
the IRQ template to return IRQs <= 15, the Interrupt template for irqs
>15.)

So, the correct thing would be for the BIOS to properly implement this
_CRS method. However, we can assume that Windows is not using _CRS like
we are, so therefore to avoid this problem (and others on other
machines) perhaps we should redo the code to not rely on _CRS so much -
perhaps if CRS is zero, then we need to assign an IRQ from one of the
possibilities (obtained from _PRS).

Also, the current policy does not reassign the IRQ even if _CRS is not
listed in _PRS. It might be interesting to see if that should be
changed.

None of this really helps you in the immediate term, sorry...

> you'll find the whole disassembly attached ... I had to do it 
> with the Windows version of "iasl"
> because the Linux version causes a "segmentation fault" on my 
> system :(

Is this repeatable, if you compile it yourself from the acpica-unix
package?

Regards -- Andy

> 	Method (_CRS, 0, NotSerialized)
> 	{
> 	    Name (B37A, ResourceTemplate ()
> 	    {
> 		IRQ (Level, ActiveLow, Shared) {}
> 	    })
> 	    CreateByteField (B37A, 0x01, IRB1)
> 	    CreateByteField (B37A, 0x02, IRB2)
> 	    Name (B47A, ResourceTemplate ()
> 	    {
> 		Interrupt (ResourceConsumer, Level, ActiveLow, Shared)
> 		{
> 		    0x00000000,
> 		}
> 	    })
> 	    If (LNot (LEqual (DEID, 0x3177)))
> 	    {
> 		If (LNot (LEqual (DEID, 0x3147)))
> 		{
> 		    Return (B37A)
> 		}
> 		Else
> 		{
> 		    Return (B47A)
> 		}
> 	    }
> 	    Else
> 	    {
> 		Return (B47A)
> 	    }
> 
> 	    Store (0x00, Local3)
> 	    Store (0x00, Local4)
> 	    And (PIRA, 0xF0, Local1)
> 	    ShiftRight (Local1, 0x04, Local1)
> 	    If (LNot (LEqual (Local1, 0x00)))
> 	    {
> 		If (LGreater (Local1, 0x07))
> 		{
> 		    Subtract (Local1, 0x08, Local2)
> 		    ShiftLeft (One, Local2, Local4)
> 		}
> 		Else
> 		{
> 		    If (LGreater (Local1, 0x00))
> 		    {
> 			ShiftLeft (One, Local1, Local3)
> 		    }
> 		}
> 
> 		Store (Local3, IRB1)
> 		Store (Local4, IRB2)
> 	    }
> 	}
> 


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
