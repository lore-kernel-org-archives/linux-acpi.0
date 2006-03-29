From: glen martin <lists@locutory.org>
Subject: Re: no /proc/acpi, trying to dump dsdt to a file
Date: Wed, 29 Mar 2006 12:27:37 -0800
Message-ID: <442AEDB9.9090702@locutory.org>
References: <971FCB6690CD0E4898387DBF7552B90E04D4B477@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m198-163.dsl.rawbw.com ([198.144.198.163]:52719 "EHLO
	slowpoke.locutory.org") by vger.kernel.org with ESMTP
	id S1750787AbWC2U1h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Mar 2006 15:27:37 -0500
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E04D4B477@orsmsx403.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org

Doh! So it does. I created the analogous fix, commenting out nssearch.c 
line 406, and now have a shiny disassembled DSDT to play with. Hooray!

I  cleaned the nssearch error messages from the top of the disassembled 
output, then recompiled with iasl, which got a small number of errors to 
track down.

But remember, this whole story started when iasl was puking on the dsdt 
file I downloaded from sourceforge. So I diff'd my disassembly against 
the file I found in the repository and discovered a large number of 
changes that replace numeric constants "0x00, 0x01" with symbols (ZERO, 
ONE).  Did iasl used to handle symbolic names for constants? I can't 
imagine someone going through to replace all these by hand ... :b



Moore, Robert wrote:

>Compiler uses the same error checking code.
>Bob
>
>  
>
>
>>test A8N # iasl -d dsdt1.dat
>>
>>Intel ACPI Component Architecture
>>AML Disassembler version 20060127 [Mar 29 2006]
>>Copyright (C) 2000 - 2006 Intel Corporation
>>Supports ACPI Specification Revision 3.0a
>>
>>Loading Acpi table from file dsdt1.dat
>>Acpi table [DSDT] successfully installed and loaded
>>Pass 1 parse of [DSDT]
>>
>>test A8N # more dsdt1.dsl
>>ACPI Error (nssearch-0405): Bad character in ACPI Name: 43035350
>>[20060127]
>>ACPI Error (dswload-0393): [0x43035350] (NON-ASCII) Namespace lookup
>>failure, AE_BAD_CHARACTER
>>ACPI Exception (psloop-0347): AE_BAD_CHARACTER, During name
>>lookup/catalog [20060127]
>>Could not parse ACPI tables, AE_BAD_CHARACTER
>><>
>>
>>    
>>

