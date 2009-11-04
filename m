From: Yinghai Lu <yhlu.kernel@gmail.com>
Subject: Re: [PATCH] PCIe AER: honor ACPI HEST FIRMWARE FIRST mode
Date: Wed, 4 Nov 2009 12:55:50 -0800
Message-ID: <86802c440911041255i59024efckf496dfa966da8560@mail.gmail.com>
References: <20091006173311.GA15751@auslistsprd01.us.dell.com>
	 <4ACEE220.1020705@jp.fujitsu.com>
	 <20091009182810.GB24889@mock.linuxdev.us.dell.com>
	 <20091009183319.GC24889@mock.linuxdev.us.dell.com>
	 <4AEA4C82.6010604@jp.fujitsu.com>
	 <20091030025313.GA1042@mock.linuxdev.us.dell.com>
	 <4AEA5C52.2030900@jp.fujitsu.com>
	 <20091102175123.GA4028@mock.linuxdev.us.dell.com>
	 <20091104091106.32489ad7@jbarnes-piketon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:56867 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932267AbZKDUzp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Nov 2009 15:55:45 -0500
In-Reply-To: <20091104091106.32489ad7@jbarnes-piketon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Matt Domsch <Matt_Domsch@dell.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Tom Long Nguyen <tom.l.nguyen@intel.com>, Zhang Yanmin <yanmin.zhang@intel.com>, linux-kernel@vger.kernel.org, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Huong_Nguyen@dell.com

On Wed, Nov 4, 2009 at 9:11 AM, Jesse Barnes <jbarnes@virtuousgeek.org>=
 wrote:
> On Mon, 2 Nov 2009 11:51:24 -0600
> Matt Domsch <Matt_Domsch@dell.com> wrote:
>
>> From 97ec121f91e5c76dc037f8d2abaea84c5476676e Mon Sep 17 00:00:00 20=
01
>> From: Matt Domsch <Matt_Domsch@dell.com>
>> Date: Thu, 8 Oct 2009 23:18:11 -0500
>> Subject: [PATCH] PCIe AER: honor ACPI HEST FIRMWARE FIRST mode
>>
>> Feedback from Hidetoshi Seto and Kenji Kaneshige incorporated. =A0Th=
is
>> correctly handles PCI-X bridges, PCIe root ports and endpoints, and
>> prints debug messages when invalid/reserved types are found in the
>> HEST. =A0PCI devices not in domain/segment 0 are not represented in
>> HEST, thus will be ignored.
>>
>> Today, the PCIe Advanced Error Reporting (AER) driver attaches itsel=
f
>> to every PCIe root port for which BIOS reports it should, via ACPI
>> _OSC.
>>
>> However, _OSC alone is insufficient for newer BIOSes. =A0Part of ACP=
I
>> 4.0 is the new APEI (ACPI Platform Error Interfaces) which is a way
>> for OS and BIOS to handshake over which errors for which components
>> each will handle. =A0One table in ACPI 4.0 is the Hardware Error Sou=
rce
>> Table (HEST), where BIOS can define that errors for certain PCIe
>> devices (or all devices), should be handled by BIOS ("Firmware First
>> mode"), rather than be handled by the OS.
>>
>> Dell PowerEdge 11G server BIOS defines Firmware First mode in HEST, =
so
>> that it may manage such errors, log them to the System Event Log, an=
d
>> possibly take other actions. =A0The aer driver should honor this, an=
d
>> not attach itself to devices noted as such.
>>
>> Furthermore, Kenji Kaneshige reminded us to disallow changing the AE=
R
>> registers when respecting Firmware First mode. =A0Platform firmware =
is
>> expected to manage these, and if changes to them are allowed, it cou=
ld
>> break that firmware's behavior.
>>
>> The HEST parsing code may be replaced in the future by a more
>> feature-rich implementation. =A0This patch provides the minimum need=
ed
>> to prevent breakage until that implementation is available.
>>
>> Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>
>> ---
>
> Applied to my linux-next branch, thanks.
>

can not find acpi_hest.c and acpi_hest.h

maybe need to wait acpi hest code is there?

YH
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
