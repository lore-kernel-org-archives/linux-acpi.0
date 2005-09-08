From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Latest acpica
Date: Thu, 08 Sep 2005 19:21:33 +0200
Message-ID: <4320731D.5070706@suse.de>
References: <971FCB6690CD0E4898387DBF7552B90E02A69A30@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E02A69A30-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, dhurst-mn4gwa5WIIQysxA8WJXlww@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Moore, Robert wrote:
> The compilation errors of this form:
> 
> 
> dsdt_org.dsl   149:                     , AddressRangeMemory,
> TypeStatic)
> 
> Error    1094 -                Missing ResourceSource string (required)
> ^
> are caused by specifying a ResourceIndex with no corresponding
> ResourceString.  We recently tightened up the iASL compiler to detect
> this condition and flag it as an error, as per the following text from
> the ACPI specification, 3.0:
> 
> DWord Address Space Descriptor 
> 
> Byte 46
>  Resource Source Index
>  (Optional) Only present if Resource Source (below) is present. This
> field gives an index to the specific resource descriptor that this
> device consumes from in the current resource template for the device
> object pointed to in Resource Source.
>  
> A relevant ASL source statement is below.
> 
>                 DWordMemory (ResourceProducer, PosDecode, MinFixed,
> MaxFixed, Cacheable, ReadWrite,
> 
>                     0x00000000, // Address Space Granularity
> 
>                     0x000A0000, // Address Range Minimum
> 
>                     0x000BFFFF, // Address Range Maximum
> 
>                     0x00000000, // Address Translation Offset
> 
>                     0x00020000, 0x00,,
> 
>                     , AddressRangeMemory, TypeStatic)
> 
> It is the 0x00 that is causing the issue, it should not be there.
> 
Yes those 0x00 are there.
> 
> However, we recently changed the disassembler to detect this condition
> within existing AML code and to emit ASL code that is compilable.  In
> this case, the statement comes out of the disassembler like this:
> 
>  
> 
>                 DWordMemory (ResourceProducer, PosDecode, MinFixed,
> MaxFixed, Cacheable, ReadWrite,
> 
>                     0x00000000, // Address Space Granularity
> 
>                     0x000A0000, // Address Range Minimum
> 
>                     0x000BFFFF, // Address Range Maximum
> 
>                     0x00000000, // Address Translation Offset
> 
>                     0x00020000,,,
> 
>                     , AddressRangeMemory, TypeStatic)
> 
> Which is compilable code.

Ok, thanks.
Then the DSDT posted lately in (subject) "Compal EFL30 ACPI"
Cannot be compiled with newer ACPICA versions because it has been disassembled
with an older iasl...

> 
> This change to the disassembler appeared in ACPICA version 20050617:
> 
> Enhanced the disassembler to emit compilable code in the face of
> incorrect AML resource descriptors. If the optional ResourceSourceIndex
> is present, but the ResourceSource is not, do not emit the
> ResourceSourceIndex in the disassembly. Otherwise, the resulting code
> cannot be compiled without errors.
> 
> 
      Thomas


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
