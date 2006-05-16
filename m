From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: AcpiGetTable( ? )
Date: Tue, 16 May 2006 14:38:48 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A44BC7B5@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33144 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932142AbWEPVjc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2006 17:39:32 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joel.bretz@hp.com, linux-acpi@vger.kernel.org

This is the interface that you want to use:

ACPI_STATUS
AcpiGetFirmwareTable (
    ACPI_STRING             Signature,
    UINT32                  Instance,
    UINT32                  Flags,
    ACPI_TABLE_HEADER       **TablePointer)


Also, we recently added support for DBGP in the table headers



> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Joel Bretz
> Sent: Tuesday, May 16, 2006 2:23 PM
> To: linux-acpi@vger.kernel.org
> Subject: AcpiGetTable( ? )
> 
> Hi,
> I need some information that lives in the DBGP and the HPET Tables.. I
> don't see a way that I can get either of those tables.
> 
> I'm guessing that
>    AcpiGetTable(ACPI_TABLE_TYPE,UINT32,ACPI_BUFFER*)
> provides the functionality that I need, but I can not find the correct
> table types for either of those.
> 
> I'm using a slightly older version of acpica (acpica-unix-20060317),
but
> I didn't see entries for
>   ACPI_TABLE_DGBP or ACPI_TABLE_HPET
> in actypes.h in the latest version either...
> 
> Is there a way that I can get the information from these 2 tables?
> 
> Thanks,
> Joel
> 
> //--------------------------------
> Joel Bretz
> Hardware Engineer
> Hewlett Packard, Systems VLSI Lab
> email: joel.bretz@hp.com
> //--------------------------------
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
