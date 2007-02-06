From: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>
Subject: RE: Bad libata resume behaviour due to ACPICA change (in acpi-test)
Date: Tue, 6 Feb 2007 15:17:47 +0300
Message-ID: <B41635854730A14CA71C92B36EC22AAC804186@mssmsx411>
References: <20070205235904.GA18392@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:34314 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753AbXBFMRy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Feb 2007 07:17:54 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20070205235904.GA18392@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>

T43 2668-NG2 BIOS 1.23 EC 1.03


>-----Original Message-----
>From: Henrique de Moraes Holschuh [mailto:hmh@hmh.eng.br]
>Sent: Tuesday, February 06, 2007 2:59 AM
>To: Starikovskiy, Alexey Y
>Cc: linux-acpi@vger.kernel.org; Brown, Len
>Subject: Re: Bad libata resume behaviour due to ACPICA change (in acpi-
>test)
>
>On Mon, 05 Feb 2007, Starikovskiy, Alexey Y wrote:
>> I cannot reproduce your problem with T43 here on linux-acpi-test with
>> defconfig (relevant ACPI modules were tried both dynamic and static).
>> Resume time is about 4-6 seconds, not 20-40 as you mention.
>
>Never tried a thinkpad in defconfig mode.  Will do.
>
>> Could you please send your .config and try defconfig on your machine?
>>
>> BTW, my T43 use AHCI mode of SATA controller, if it matters...
>
>Mine is stuck in legacy mode, so we are using different drivers
(ata_piix
>in
>my case).  Which BIOS and firmware you got?  What is your machine type?
I
>am very interested in a way to get my T43 into AHCI mode...
>
>Mine is a ThinkPad T43 2687-DDU, BIOS is 1.29, EC firmware is 1.06.
>
>--
>  "One disk to rule them all, One disk to find them. One disk to bring
>  them all and in the darkness grind them. In the Land of Redmond
>  where the shadows lie." -- The Silicon Valley Tarot
>  Henrique Holschuh
