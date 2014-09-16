From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [RFC PATCH for AMD Seattle 0/4] Drivers for AMD-Seatlle to boot
 from ACPI
Date: Mon, 15 Sep 2014 23:28:07 -0500
Message-ID: <5417BC57.4030504@amd.com>
References: <1410828446-28502-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-by2on0112.outbound.protection.outlook.com ([207.46.100.112]:14709
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753133AbaIPGO3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Sep 2014 02:14:29 -0400
In-Reply-To: <1410828446-28502-1-git-send-email-suravee.suthikulpanit@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: catalin.marinas@arm.com, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, astone@redhat.com, hanjun.guo@linaro.org, rjw@rjwysocki.net, marc.zyngier@arm.com, mark.rutland@arm.com, Sudeep.Holla@arm.com, olof@lixom.net, grant.likely@linaro.org, graeme.gregory@linaro.org, arnd@arndb.de, jason@lakedaemon.net

Note: Correcting the typo for linux-acpi mailing list in this reply.

Also, I would like to add the link to the "AMD Opteron=99 A1100 Series=20
Processor ACPI Porting Guide", which describes the current ACPI table=20
for AMD Seattle platform here:

http://amd-dev.wpengine.netdna-cdn.com/wordpress/media/2012/10/Seattle_=
ACPI_Guide.pdf

Suravee

On 09/15/2014 07:47 PM, suravee.suthikulpanit@amd.com wrote:
> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>
> As a follow up of the email thread:
>
>      [PATCH v3 00/17] Introduce ACPI for ARM64 based on ACPI 5.1
>      https://lkml.org/lkml/2014/9/1/446
>
> Besides Hanjun Guo's patches above, these are the additional patches =
required
> to boot AMD Seattle platform with full ACPI support:
>
>      [PATCH] efi/arm64: efistub: don't abort if base of DRAM is occup=
ied
>      http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/=
272274.html
>
>      [PATCH v2] efi/arm64: fix fdt-related memory reservation
>      https://lkml.org/lkml/2014/9/8/483
>
>      [PATCH] ata: ahci_platform: Add ACPI support for AMD Seattle SAT=
A controller
>      https://lkml.org/lkml/2014/9/9/834
>
>      [RFC PATCH for Juno 2/2] tty: SBSA compatible UART
>      https://lkml.org/lkml/2014/9/1/448
>      (NOTE: This is not meant to be submitted upstream, but required =
to enable
>       ACPI support for UART SBSA driver.)
>
> These patches are rebased from the linux-3.17-rc4 upstream kernel, an=
d
> compatible with the AMD Seattle Firmware version ROD0070C.
> The full kernel boot log can be found here:
>
>      http://people.linaro.org/~al.stone/seattle-boot-acpi-dmesg.txt
>
> Suravee / Al
>
> Ard Biesheuvel (1):
>    arm64/efi: efistub: don't abort if base of DRAM is occupied
>
> Grame Gregory (1):
>    [RFC PATCH for Juno 2/2] tty: SBSA compatible UART
>
> Mark Salter (1):
>    efi/arm64: fix fdt-related memory reservation
>
> Suravee Suthikulpanit (1):
>    ata: ahci_platform: Add ACPI support for AMD Seattle SATA controll=
er
>
>   arch/arm64/kernel/efi-stub.c       |  16 +-
>   arch/arm64/mm/init.c               |   3 +-
>   drivers/ata/Kconfig                |   2 +-
>   drivers/ata/ahci_platform.c        |  13 ++
>   drivers/firmware/efi/libstub/fdt.c |  10 +-
>   drivers/tty/Kconfig                |   6 +
>   drivers/tty/Makefile               |   1 +
>   drivers/tty/sbsauart.c             | 328 ++++++++++++++++++++++++++=
+++++++++++
>   8 files changed, 365 insertions(+), 14 deletions(-)
>   create mode 100644 drivers/tty/sbsauart.c
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
