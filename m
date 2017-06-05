From: Linda Knippers <linda.knippers@hpe.com>
Subject: Re: [PATCH 01/15] ACPICA: Disassembler: Enhance resource descriptor
 detection
Date: Mon, 5 Jun 2017 11:57:09 -0400
Message-ID: <59357F55.8050707@hpe.com>
References: <cover.1493194142.git.lv.zheng@intel.com>
 <fe4a8655a06221df851d5781609058f16aa65e93.1493194142.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:16828 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdFEP5U (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2017 11:57:20 -0400
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 9922E61485
        for <linux-acpi@vger.kernel.org>; Mon,  5 Jun 2017 15:57:19 +0000 (UTC)
In-Reply-To: <fe4a8655a06221df851d5781609058f16aa65e93.1493194142.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org


On 04/26/2017 04:17 AM, Lv Zheng wrote:
> From: Bob Moore <robert.moore@intel.com>
> 
> ACPICA commit ba5020b2dbe1538e4ccd7ac2dfd8843a690c007f
> 
> This change enhances the detection of resource descriptors
> within a buffer object. For the end_tag opcode, the second byte
> is defined to be either a checksum or zero. All known ASL compilers
> insert a zero for this byte. The disassembler now ensures this
> byte is zero before deciding that a buffer should be disassembled
> to a resource descriptor. This helps eliminate incorrect decisions
> when attempting to disassemble a buffer to a resource descriptor.

This commit breaks things on my platform. I'm testing on an HPE ProLiant DL380Gen9
but I also see errors on other ProLiant servers, including much older ones.

With this commit, I see errors like:

[ 4.496926] acpi PNP0A03:00: [Firmware Bug]: no secondary bus range in _CRS
[ 4.496929] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus 7f-ff])
[ 4.496934] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[ 4.496938] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[ 4.496949] acpi PNP0A03:00: failed to parse _CRS method, error code -5
[ 4.496950] acpi PNP0A03:00: Bus 0000:7f not present in PCI namespace
[ 4.499111] acpi PNP0A03:01: [Firmware Bug]: no secondary bus range in _CRS
[ 4.499113] ACPI: PCI Root Bridge [UNC1] (domain 0000 [bus ff])
[ 4.499115] acpi PNP0A03:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[ 4.499118] acpi PNP0A03:01: _OSC failed (AE_NOT_FOUND); disabling ASPM
[ 4.499126] acpi PNP0A03:01: failed to parse _CRS method, error code -5
[ 4.499127] acpi PNP0A03:01: Bus 0000:ff not present in PCI namespace
[ 4.502133] acpi PNP0A08:00: [Firmware Bug]: no secondary bus range in _CRS
[ 4.502136] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[ 4.502138] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[ 4.502268] acpi PNP0A08:00: _OSC: platform does not support [AER]
[ 4.502386] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[ 4.502387] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[ 4.502646] acpi PNP0A08:00: failed to parse _CRS method, error code -5
[ 4.502647] acpi PNP0A08:00: Bus 0000:00 not present in PCI namespace
[ 4.504816] acpi PNP0A08:01: [Firmware Bug]: no secondary bus range in _CRS
[ 4.504819] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-ff])
[ 4.504821] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[ 4.504936] acpi PNP0A08:01: _OSC: platform does not support [AER]
[ 4.505042] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[ 4.505043] acpi PNP0A08:01: FADT indicates ASPM is unsupported, using BIOS configuration
[ 4.505057] acpi PNP0A08:01: failed to parse _CRS method, error code -5
[ 4.505058] acpi PNP0A08:01: Bus 0000:80 not present in PCI namespace
...
[ 4.524563] PCI: Using ACPI for IRQ routing
[ 4.524564] PCI: Discovered peer bus 00
[ 4.524565] PCI: root bus 00: using default resources
[ 4.524566] PCI: Probing PCI hardware (bus 00)
[ 4.524586] ACPI: \: failed to evaluate _DSM (0x1001)

This causes random things to break, such as the ability for an ACPI method
to make IPMI calls because ipmi_si doesn't find the ACPI-specified BMC.

> 
> Link: https://github.com/acpica/acpica/commit/ba5020b2
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  drivers/acpi/acpica/utresrc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
> index ff096d9..e0587c8 100644
> --- a/drivers/acpi/acpica/utresrc.c
> +++ b/drivers/acpi/acpica/utresrc.c
> @@ -474,6 +474,15 @@ acpi_ut_walk_aml_resources(struct acpi_walk_state *walk_state,
>  				return_ACPI_STATUS(AE_AML_NO_RESOURCE_END_TAG);
>  			}
>  
> +			/*
> +			 * The end_tag opcode must be followed by a zero byte.
> +			 * Although this byte is technically defined to be a checksum,
> +			 * in practice, all ASL compilers set this byte to zero.
> +			 */
> +			if (*(aml + 1) != 0) {
> +				return_ACPI_STATUS(AE_AML_NO_RESOURCE_END_TAG);

If I replace the return with an ACPI_ERROR, I get output like this:

[ 4.497662] ACPI Error: Non-zero value: 0xE5 (20170303/utresrc-484)
[ 4.500111] ACPI Error: Non-zero value: 0xE5 (20170303/utresrc-484)
[ 4.506862] ACPI Error: Non-zero value: 0xE5 (20170303/utresrc-484)
[ 4.509011] ACPI Error: Non-zero value: 0xE5 (20170303/utresrc-484)
[ 4.516777] ACPI Error: Non-zero value: 0x50 (20170303/utresrc-484)
[ 4.519710] ACPI Error: Non-zero value: 0x50 (20170303/utresrc-484)
[ 4.541214] ACPI Error: Non-zero value: 0xE4 (20170303/utresrc-484)
[ 4.543670] ACPI Error: Non-zero value: 0xE4 (20170303/utresrc-484)
[ 4.584594] ACPI Error: Non-zero value: 0x07 (20170303/utresrc-484)
[ 4.586754] ACPI Error: Non-zero value: 0x11 (20170303/utresrc-484)

By not returning an error, I no longer see the other errors and everything
seems to work.

I haven't yet determined whether the non-zero value is a valid checksum but
it's definitely not zero.

If the byte is technically defined to be a checksum, then the code ought to
accept a valid checksum.  If it turns out that my platform isn't actually
providing a valid checksum, then I'd like to see a warning or something
rather than a error, since this change will break a lot of systems.

-- ljk

> +			}
> +
>  			/* Return the pointer to the end_tag if requested */
>  
>  			if (!user_function) {
> 

