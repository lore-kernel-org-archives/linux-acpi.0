From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: no /proc/acpi, trying to dump dsdt to a file
Date: Wed, 29 Mar 2006 12:02:57 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E04D4B477@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:22822 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750707AbWC2UC7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2006 15:02:59 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: glen martin <lists@locutory.org>, "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

Compiler uses the same error checking code.
Bob


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of glen martin
> Sent: Wednesday, March 29, 2006 11:57 AM
> To: Brown, Len
> Cc: linux-acpi@vger.kernel.org
> Subject: Re: no /proc/acpi, trying to dump dsdt to a file
> 
> the nssearch patch certainly bypasses the first level problem. Here's
> the dmesg output with that patch applied.
> 
> <>
>  tbxface-0109 [02] load_tables           : ACPI Tables successfully
> acquired
> nssearch-0311: *** Error: ns_search_and_enter: Bad character in ACPI
> Name: 43035350
> nssearch-0311: *** Error: ns_search_and_enter: Bad character in ACPI
> Name: 43035350
> Parsing all Control
>
Methods:................................................................
..
> ...
>
........................................................................
..
> .......................
>
........................................................................
..
> .......................
> .........
> Table [DSDT](id 0005) - 815 Objects with 73 Devices 272 Methods 18
Regions
> ACPI Namespace successfully loaded at root c05abe7c
> evxfevnt-0091 [03] enable                : Transition to ACPI mode
> successful
> <>
> 
> Now /proc/acpi/dsdt is present! However:
> <>
> test A8N # cat /proc/acpi/dsdt > dsdt1.dat
> 
> test A8N # iasl -d dsdt1.dat
> 
> Intel ACPI Component Architecture
> AML Disassembler version 20060127 [Mar 29 2006]
> Copyright (C) 2000 - 2006 Intel Corporation
> Supports ACPI Specification Revision 3.0a
> 
> Loading Acpi table from file dsdt1.dat
> Acpi table [DSDT] successfully installed and loaded
> Pass 1 parse of [DSDT]
> 
> test A8N # more dsdt1.dsl
> ACPI Error (nssearch-0405): Bad character in ACPI Name: 43035350
> [20060127]
> ACPI Error (dswload-0393): [0x43035350] (NON-ASCII) Namespace lookup
> failure, AE_BAD_CHARACTER
> ACPI Exception (psloop-0347): AE_BAD_CHARACTER, During name
> lookup/catalog [20060127]
> Could not parse ACPI tables, AE_BAD_CHARACTER
> <>
> 
> 
> I also tried acpidump (thanks for the suggestion), which gave me:
> <>
> test acpidump # ./acpidump -t DSDT -o dsdt.hex
> Wrong checksum for generic table!
> <>
> 
> 
> 
> 
> Brown, Len wrote:
> 
> >>-----Original Message-----
> >>From: Brown, Len
> >>Sent: Wednesday, March 29, 2006 2:04 PM
> >>To: 'glen martin'; linux-acpi@vger.kernel.org
> >>Subject: RE: no /proc/acpi, trying to dump dsdt to a file
> >>
> >>You can dump your ACPI tables with acpidump, no matter if you
> >>are booted in ACPI mode or not.  Get the latest from pmtools here:
> >>
> >>http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
> >>
> >>/DSDT.aml not found.
> >>
> >>
> >>>tbxface-0109 [02] load_tables           : ACPI Tables successfully
> acquired
> >>>nssearch-0311: *** Error: ns_search_and_enter: Bad character in
ACPI
> >>>Name: 43035350
> >>>dswload-0292: *** Error: Looking up [0x43035350] (NON-ASCII)
> >>>in namespace, AE_BAD_CHARACTER
> >>> psloop-0287 [09] ps_parse_loop         : During name
lookup/catalog,
> >>>AE_BAD_CHARACTER
> >>>tbxface-0115: *** Error: acpi_load_tables: Could not load
namespace:
> >>>AE_BAD_CHARACTER
> >>>tbxface-0123: *** Error: acpi_load_tables: Could not load tables:
> >>>AE_BAD_CHARACTER
> >>>ACPI: Unable to load the System Description Tables
> >>>
> >>>
> >>>Any suggestions?
> >>>
> >>>
> >>Replace the non-ascii character with an ascii one.
> >>There is a patch about to work around this -- let me find it...
> >>
> >>
> >
> >Please try the test patch here:
> >https://bugzilla.novell.com/show_bug.cgi?id=147621#c22
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
