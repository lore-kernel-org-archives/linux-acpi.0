From: Joel Bretz <jbretz@rsn.hp.com>
Subject: Re: AcpiGetFirmwareTable
Date: Wed, 17 May 2006 11:20:45 -0500
Message-ID: <1147882845.20702.44.camel@zion.rsn.hp.com>
References: <B28E9812BAF6E2498B7EC5C427F293A44BC7B5@orsmsx415.amr.corp.intel.com>
	 <1147881519.20702.40.camel@zion.rsn.hp.com>
Reply-To: joel.bretz@hp.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:7064 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1750709AbWEQQUq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 May 2006 12:20:46 -0400
Received: from mailb.rsn.hp.com (it4-3.rsn.hp.com [15.99.203.1])
	by atlrel9.hp.com (Postfix) with ESMTP id 1665034D11
	for <linux-acpi@vger.kernel.org>; Wed, 17 May 2006 12:20:45 -0400 (EDT)
Received: from zion.rsn.hp.com (zion.rsn.hp.com [15.99.19.197])
	by mailb.rsn.hp.com (8.11.1/8.9.3 SMKit7.0) with ESMTP id k4HGKjt05424
	for <linux-acpi@vger.kernel.org>; Wed, 17 May 2006 11:20:45 -0500 (CDT)
In-Reply-To: <1147881519.20702.40.camel@zion.rsn.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I guess I should also note, that I know that AcpiOsGetRootPointer
returns the correct value since I can successfully use

AcpiWalkNamespace (ACPI_TYPE_ANY, Handle, 0xffffffff,
	    DecodeOneDevice, (void*)p, NULL);

Thanks


On Wed, 2006-05-17 at 10:58 -0500, Joel Bretz wrote:
> Hmm something is wrong. :(
> 
> 
> Here's the code that I'm using to get the Debug Port:
> //----- <snip> -----
>     ACPI_STATUS Status;
>     ACPI_TABLE_HEADER *pAcpiTableHeader; 
> 
>     printf("JOEL: Get DGBP\n")
>     Status = AcpiGetFirmwareTable("DBGP",1,ACPI_PHYSICAL_ADDRESSING,
> 	    &pAcpiTableHeader);
>     if(ACPI_FAILURE(Status))
>     {
> 	FAIL_STOP("AcpiGetFirmwareTable failed.\n"); //<
>     }
> 
> //----- </snip> -----
> 
> Here's the output from my system
> 
> //----- <snip> -----
> I> JOEL: Get DBGP
> I> AcpiOsGetRootPointer 
> I> ACPI Error (tbget-0259): Invalid address flags X [X]
> I> ERROR: file: ../src/acpi.c, line: 846, func: GetAcpiDGBP, p:008d37e0:
> I>    AcpiGetFirmwareTable failed.
> I> There has been a failure.
> //----- </snip> -----
> 
> I follow the error message and go take a look at
> acpica-unix-20060317/tables/tbget.c
> 
> the error message comes from a switch statement on 
> Address->PointerType for which there are 3 handled cases:
>  ACPI_PHYSMODE_PHYSPTR
>  ACPI_LOGMODE_LOGPTR
>  ACPI_LOGMODE_PHYSPTR
> 
> I should be executing the ACPI_PHYSMODE_PHYSMODE branch..
> since OsGetRootPointer returns a PHYSICAL_POINTER & I specified
> ACPI_PHYSICAL_ADDRESSING when I called AcpiGetFirmwareTable
> 
> does anyone know what's going wrong here?
> Thanks,
> 
> //--------------------------------
> Joel Bretz
> Hardware Engineer
> Hewlett Packard, Systems VLSI Lab
> email: joel.bretz@hp.com
> //--------------------------------
> 
> 
> 
> On Tue, 2006-05-16 at 14:38 -0700, Moore, Robert wrote:
> > This is the interface that you want to use:
> > 
> > ACPI_STATUS
> > AcpiGetFirmwareTable (
> >     ACPI_STRING             Signature,
> >     UINT32                  Instance,
> >     UINT32                  Flags,
> >     ACPI_TABLE_HEADER       **TablePointer)
> > 
> > 
> > Also, we recently added support for DBGP in the table headers
> > 
> > 
> > 
> > > -----Original Message-----
> > > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > > owner@vger.kernel.org] On Behalf Of Joel Bretz
> > > Sent: Tuesday, May 16, 2006 2:23 PM
> > > To: linux-acpi@vger.kernel.org
> > > Subject: AcpiGetTable( ? )
> > > 
> > > Hi,
> > > I need some information that lives in the DBGP and the HPET Tables.. I
> > > don't see a way that I can get either of those tables.
> > > 
> > > I'm guessing that
> > >    AcpiGetTable(ACPI_TABLE_TYPE,UINT32,ACPI_BUFFER*)
> > > provides the functionality that I need, but I can not find the correct
> > > table types for either of those.
> > > 
> > > I'm using a slightly older version of acpica (acpica-unix-20060317),
> > but
> > > I didn't see entries for
> > >   ACPI_TABLE_DGBP or ACPI_TABLE_HPET
> > > in actypes.h in the latest version either...
> > > 
> > > Is there a way that I can get the information from these 2 tables?
> > > 
> > > Thanks,
> > > Joel
> > > 
> > > //--------------------------------
> > > Joel Bretz
> > > Hardware Engineer
> > > Hewlett Packard, Systems VLSI Lab
> > > email: joel.bretz@hp.com
> > > //--------------------------------
> > > 
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> > in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

