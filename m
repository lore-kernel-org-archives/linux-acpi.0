From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: ACPICA branch (0 Objects with 0 Devices 0 Methods 0 Regions)
Date: Tue, 29 Apr 2008 09:09:05 -0700
Message-ID: <9D39833986E69849A2A8E74C1078B6B33BCDFA@orsmsx415.amr.corp.intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org> <200804290504.54789.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52310 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257AbYD2QJH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 12:09:07 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200804290504.54789.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "Lin, Ming M" <ming.m.lin@intel.com>


It looks like the tables in question are dynamically loaded:

>ACPI: SSDT 7D6E1B32, 02C4 (r1  PmRef  Cpu0Ist      100 INTL 20050513)
>Table [SSDT](id 0044) - 0 Objects with 0 Devices 0 Methods 0 Regions
>ACPI: SSDT 7D6E1E7B, 085E (r1  PmRef  Cpu0Cst      100 INTL 20050513)
>Table [SSDT](id 0045) - 0 Objects with 0 Devices 0 Methods 0 Regions
>ACPI: SSDT 7D6E1A6A, 00C8 (r1  PmRef  Cpu1Ist      100 INTL 20050513)
>Table [SSDT](id 0050) - 0 Objects with 0 Devices 0 Methods 0 Regions
>ACPI: SSDT 7D6E1DF6, 0085 (r1  PmRef  Cpu1Cst      100 INTL 20050513)
>Table [SSDT](id 0051) - 0 Objects with 0 Devices 0 Methods 0 Regions

What the zeroes mean is that a WalkNamespace after the table load did
not find any such objects created by the table.

Something does look wrong, it may not affect your machine, but has the
potential to cause problems on other machines.

The difference in owner IDs between the two traces might mean that there
is some mismatch somewhere. I would debug and determine 1) The actual
owner id created for the newly loaded table, and 2) what owner id is
passed to AcpiDsInitializeObjects after the table is loaded.

Bob



>-----Original Message-----
>From: Len Brown [mailto:lenb@kernel.org]
>Sent: Tuesday, April 29, 2008 2:05 AM
>To: linux-acpi@vger.kernel.org; Moore, Robert; Lin, Ming M
>Subject: Re: ACPICA branch (0 Objects with 0 Devices 0 Methods 0
Regions)
>
>Hmm, i just noticed something strange on the T61
>
>Linus' tree prints these messages:
>
>[lenb@t61 sut]$ grep -i ssdt 2.6.25-06058-ga01e035/dmesg
>ACPI: SSDT 7D6BB9B4, 0269 (r1 LENOVO TP-7L        2100 MSFT  3000000)
>ACPI: SSDT 7D6E26D9, 025F (r1 LENOVO TP-7L        2100 INTL 20050513)
>ACPI: SSDT 7D6E2938, 00A6 (r1 LENOVO TP-7L        2100 INTL 20050513)
>ACPI: SSDT 7D6E29DE, 04F7 (r1 LENOVO TP-7L        2100 INTL 20050513)
>ACPI: SSDT 7D6E2ED5, 01D8 (r1 LENOVO TP-7L        2100 INTL 20050513)
>Table [SSDT](id 0002) - 11 Objects with 0 Devices 7 Methods 0 Regions
>Table [SSDT](id 0003) - 7 Objects with 0 Devices 3 Methods 0 Regions
>Table [SSDT](id 0004) - 4 Objects with 0 Devices 3 Methods 0 Regions
>Table [SSDT](id 0005) - 14 Objects with 0 Devices 5 Methods 0 Regions
>Table [SSDT](id 0006) - 14 Objects with 1 Devices 2 Methods 0 Regions
>ACPI: SSDT 7D6E1B32, 02C4 (r1  PmRef  Cpu0Ist      100 INTL 20050513)
>Table [SSDT](id 003A) - 6 Objects with 0 Devices 4 Methods 0 Regions
>ACPI: SSDT 7D6E1E7B, 085E (r1  PmRef  Cpu0Cst      100 INTL 20050513)
>Table [SSDT](id 003B) - 16 Objects with 0 Devices 1 Methods 0 Regions
>ACPI: SSDT 7D6E1A6A, 00C8 (r1  PmRef  Cpu1Ist      100 INTL 20050513)
>Table [SSDT](id 0046) - 4 Objects with 0 Devices 4 Methods 0 Regions
>ACPI: SSDT 7D6E1DF6, 0085 (r1  PmRef  Cpu1Cst      100 INTL 20050513)
>Table [SSDT](id 0047) - 1 Objects with 0 Devices 1 Methods 0 Regions
>
>
>The acpi test tree prints these messages:
>
>[lenb@t61 sut]$ grep -i ssdt 2.6.25-06238-gf4e0ea3/dmesg
>ACPI: SSDT 7D6BB9B4, 0269 (r1 LENOVO TP-7L        2100 MSFT  3000000)
>ACPI: SSDT 7D6E26D9, 025F (r1 LENOVO TP-7L        2100 INTL 20050513)
>ACPI: SSDT 7D6E2938, 00A6 (r1 LENOVO TP-7L        2100 INTL 20050513)
>ACPI: SSDT 7D6E29DE, 04F7 (r1 LENOVO TP-7L        2100 INTL 20050513)
>ACPI: SSDT 7D6E2ED5, 01D8 (r1 LENOVO TP-7L        2100 INTL 20050513)
>Table [SSDT](id 0002) - 11 Objects with 0 Devices 7 Methods 0 Regions
>Table [SSDT](id 0003) - 7 Objects with 0 Devices 3 Methods 0 Regions
>Table [SSDT](id 0004) - 4 Objects with 0 Devices 3 Methods 0 Regions
>Table [SSDT](id 0005) - 14 Objects with 0 Devices 5 Methods 0 Regions
>Table [SSDT](id 0006) - 14 Objects with 1 Devices 2 Methods 0 Regions
>ACPI: SSDT 7D6E1B32, 02C4 (r1  PmRef  Cpu0Ist      100 INTL 20050513)
>Table [SSDT](id 0044) - 0 Objects with 0 Devices 0 Methods 0 Regions
>ACPI: SSDT 7D6E1E7B, 085E (r1  PmRef  Cpu0Cst      100 INTL 20050513)
>Table [SSDT](id 0045) - 0 Objects with 0 Devices 0 Methods 0 Regions
>ACPI: SSDT 7D6E1A6A, 00C8 (r1  PmRef  Cpu1Ist      100 INTL 20050513)
>Table [SSDT](id 0050) - 0 Objects with 0 Devices 0 Methods 0 Regions
>ACPI: SSDT 7D6E1DF6, 0085 (r1  PmRef  Cpu1Cst      100 INTL 20050513)
>Table [SSDT](id 0051) - 0 Objects with 0 Devices 0 Methods 0 Regions
>
>ie.  "0 Objects with 0 Devices 0 Methods 0 Regions"
>
>dunno if this is just cosmetic -- the p-states that are advertised in
>the SSDT's seem to be working normally, and C-states do too.
>
>-Len
