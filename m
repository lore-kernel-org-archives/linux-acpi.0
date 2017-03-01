From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPICA: Detect duplicate SSDT tables
Date: Wed, 1 Mar 2017 22:56:46 +0100
Message-ID: <CAJZ5v0i70OWDZXb7CObRykiEpgQ_=1QWA2ZQM9YYQipVLPbaxg@mail.gmail.com>
References: <20170227093432.3308-1-hdegoede@redhat.com> <1AE640813FDE7649BE1B193DEA596E886CE430EF@SHSMSX101.ccr.corp.intel.com>
 <d2552299-d658-af67-44f1-7e528133cfaf@redhat.com> <1AE640813FDE7649BE1B193DEA596E886CE43ED5@SHSMSX101.ccr.corp.intel.com>
 <a2cdcf07-055c-6cb2-a0f2-b179a128f845@redhat.com> <94F2FBAB4432B54E8AACC7DFDE6C92E37E56876F@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34542 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753862AbdCBD6X (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Mar 2017 22:58:23 -0500
Received: by mail-ot0-f193.google.com with SMTP id w44so6267950otw.1
        for <linux-acpi@vger.kernel.org>; Wed, 01 Mar 2017 19:58:22 -0800 (PST)
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E56876F@ORSMSX110.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "Box, David E" <david.e.box@intel.com>

On Wed, Mar 1, 2017 at 9:38 PM, Moore, Robert <robert.moore@intel.com> wrote:
> Sorry if I've missed any of this conversation, but I have a couple of thoughts:
>
> 1) It might be sufficient to just compare the incoming table header (36 bytes). The header contains both the table length and the checksum -- as well as the OEM ID and OEM version. I take it that the XSDT pointers to the duplicate tables are different.
>
> 2) As far as comparing every incoming SSDT byte-for-byte against all previously loaded SSDTs, I have to think "what about the boot time?". Especially since SSDTs are increasing in both size and number (See example from a real machine below).
>
>
> ACPI: RSDP 0x0000000000492954 000024 (v02 Intel )
> ACPI: XSDT 0x000000000068C938 0000B4 (v00 Intel  AcpiExec 00001001 INTL 20170224)
> ACPI: FACP 0x0000000000492978 000114 (v05 Intel  AcpiExec 00001001 INTL 20170224)
> ACPI: DSDT 0x0000000000690048 022FD6 (v02 LENOVO CB-01    00000001 ACPI 00040000)
> ACPI: FACS 0x0000000000492AB0 000040
> ACPI: SSDT 0x00000000006B3028 0004B7 (v02 LENOVO CB-01    00000001 ACPI 00040000)
> ACPI: SSDT 0x000000000068D940 000B49 (v02 LENOVO CB-01    00000001 ACPI 00040000)
> ACPI: SSDT 0x00000000006B34E8 0004A3 (v02 LENOVO CB-01    00000001 ACPI 00040000)
> ACPI: SSDT 0x00000000006B3998 000E58 (v02 LENOVO CB-01    00000001 ACPI 00040000)
> ACPI: SSDT 0x00000000006B47F8 00037F (v02 PmRef  Cpu0Cst  00003001 INTL 20121220)
> ACPI: SSDT 0x000000000068E498 000660 (v02 PmRef  Cpu0Ist  00003000 INTL 20121220)
> ACPI: SSDT 0x00000000006B4B80 0005AA (v02 PmRef  ApIst    00003000 INTL 20121220)
> ACPI: SSDT 0x000000000068EB00 000119 (v02 PmRef  ApCst    00003000 INTL 20121220)
> ACPI: SSDT 0x000000000068EC28 00004B (v02 LENOVO CB-01    00000001 ACPI 00040000)
> ACPI: SSDT 0x00000000006B5138 0052EE (v02 LENOVO CB-01    00000001 ACPI 00040000)
> ACPI: SSDT 0x00000000006BA430 002C4A (v02 LENOVO CB-01    00000001 ACPI 00040000)
> ACPI: SSDT 0x00000000006BD088 0004C8 (v02 LENOVO CB-01    00000001 ACPI 00040000)
> ACPI: SSDT 0x000000000068EC80 0002D4 (v01 LENOVO CB-01    00000001 ACPI 00040000)
> ACPI: SSDT 0x00000000006BD558 002BAE (v02 LENOVO CB-01    00000001 ACPI 00040000)
> ACPI: SSDT 0x00000000006C0110 00019A (v02 LENOVO CB-01    00000001 ACPI 00040000)
> ACPI: SSDT 0x00000000006C02B8 0006DC (v02 LENOVO CB-01    00000001 ACPI 00040000)
>

Right.

Whatever allows us to make a "we've loaded this table already, skip
it" decision without comparing byte-for-byte, please.

Thanks,
Rafael
