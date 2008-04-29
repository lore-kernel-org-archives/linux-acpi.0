From: Len Brown <lenb@kernel.org>
Subject: Re: ACPICA branch (0 Objects with 0 Devices 0 Methods 0 Regions)
Date: Tue, 29 Apr 2008 05:04:54 -0400
Message-ID: <200804290504.54789.lenb@kernel.org>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43062 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765611AbYD2OUs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Apr 2008 10:20:48 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>

Hmm, i just noticed something strange on the T61

Linus' tree prints these messages:

[lenb@t61 sut]$ grep -i ssdt 2.6.25-06058-ga01e035/dmesg
ACPI: SSDT 7D6BB9B4, 0269 (r1 LENOVO TP-7L        2100 MSFT  3000000)
ACPI: SSDT 7D6E26D9, 025F (r1 LENOVO TP-7L        2100 INTL 20050513)
ACPI: SSDT 7D6E2938, 00A6 (r1 LENOVO TP-7L        2100 INTL 20050513)
ACPI: SSDT 7D6E29DE, 04F7 (r1 LENOVO TP-7L        2100 INTL 20050513)
ACPI: SSDT 7D6E2ED5, 01D8 (r1 LENOVO TP-7L        2100 INTL 20050513)
Table [SSDT](id 0002) - 11 Objects with 0 Devices 7 Methods 0 Regions
Table [SSDT](id 0003) - 7 Objects with 0 Devices 3 Methods 0 Regions
Table [SSDT](id 0004) - 4 Objects with 0 Devices 3 Methods 0 Regions
Table [SSDT](id 0005) - 14 Objects with 0 Devices 5 Methods 0 Regions
Table [SSDT](id 0006) - 14 Objects with 1 Devices 2 Methods 0 Regions
ACPI: SSDT 7D6E1B32, 02C4 (r1  PmRef  Cpu0Ist      100 INTL 20050513)
Table [SSDT](id 003A) - 6 Objects with 0 Devices 4 Methods 0 Regions
ACPI: SSDT 7D6E1E7B, 085E (r1  PmRef  Cpu0Cst      100 INTL 20050513)
Table [SSDT](id 003B) - 16 Objects with 0 Devices 1 Methods 0 Regions
ACPI: SSDT 7D6E1A6A, 00C8 (r1  PmRef  Cpu1Ist      100 INTL 20050513)
Table [SSDT](id 0046) - 4 Objects with 0 Devices 4 Methods 0 Regions
ACPI: SSDT 7D6E1DF6, 0085 (r1  PmRef  Cpu1Cst      100 INTL 20050513)
Table [SSDT](id 0047) - 1 Objects with 0 Devices 1 Methods 0 Regions


The acpi test tree prints these messages:

[lenb@t61 sut]$ grep -i ssdt 2.6.25-06238-gf4e0ea3/dmesg
ACPI: SSDT 7D6BB9B4, 0269 (r1 LENOVO TP-7L        2100 MSFT  3000000)
ACPI: SSDT 7D6E26D9, 025F (r1 LENOVO TP-7L        2100 INTL 20050513)
ACPI: SSDT 7D6E2938, 00A6 (r1 LENOVO TP-7L        2100 INTL 20050513)
ACPI: SSDT 7D6E29DE, 04F7 (r1 LENOVO TP-7L        2100 INTL 20050513)
ACPI: SSDT 7D6E2ED5, 01D8 (r1 LENOVO TP-7L        2100 INTL 20050513)
Table [SSDT](id 0002) - 11 Objects with 0 Devices 7 Methods 0 Regions
Table [SSDT](id 0003) - 7 Objects with 0 Devices 3 Methods 0 Regions
Table [SSDT](id 0004) - 4 Objects with 0 Devices 3 Methods 0 Regions
Table [SSDT](id 0005) - 14 Objects with 0 Devices 5 Methods 0 Regions
Table [SSDT](id 0006) - 14 Objects with 1 Devices 2 Methods 0 Regions
ACPI: SSDT 7D6E1B32, 02C4 (r1  PmRef  Cpu0Ist      100 INTL 20050513)
Table [SSDT](id 0044) - 0 Objects with 0 Devices 0 Methods 0 Regions
ACPI: SSDT 7D6E1E7B, 085E (r1  PmRef  Cpu0Cst      100 INTL 20050513)
Table [SSDT](id 0045) - 0 Objects with 0 Devices 0 Methods 0 Regions
ACPI: SSDT 7D6E1A6A, 00C8 (r1  PmRef  Cpu1Ist      100 INTL 20050513)
Table [SSDT](id 0050) - 0 Objects with 0 Devices 0 Methods 0 Regions
ACPI: SSDT 7D6E1DF6, 0085 (r1  PmRef  Cpu1Cst      100 INTL 20050513)
Table [SSDT](id 0051) - 0 Objects with 0 Devices 0 Methods 0 Regions

ie.  "0 Objects with 0 Devices 0 Methods 0 Regions"

dunno if this is just cosmetic -- the p-states that are advertised in
the SSDT's seem to be working normally, and C-states do too.

-Len
