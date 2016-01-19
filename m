From: <Stuart_Hayes@Dell.com>
Subject: ACPI IPMI device with _CID getting wrong driver attached
Date: Tue, 19 Jan 2016 14:46:51 -0600
Message-ID: <959D45574D89AF41A9DADF6F446A2E9A50AE8A4F6F@AUSX7MCPS310.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ausxipps301.us.dell.com ([143.166.148.223]:11869 "EHLO
	ausxipps301.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757379AbcASUrW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jan 2016 15:47:22 -0500
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net
Cc: cminyard@mvista.com

I'm having a problem on a number of systems where the IPMI driver isn't able to find the ACPI IPMI device.

This is happening because the ACPI scan is attaching the acpi_pnp handler to the ACPI IPMI device, which is happening because the IPMI device has a _CID of PNP0C01 in addition to an _HID of IPI0001.  This is a problem because acpi_scan_attach_handler() doesn't know about the IPMI drivers (ipmi_si / ipmi_ssif), which don't register as PNP or ACPI drivers, but instead expect the ACPI scan find no applicable driver and thus create a platform device.

This could be fixed pretty easily by modifying acpi_scan_attach_handler() to make it return 0 without attaching a handler to devices that have a _HID of IPI0001 when the kernel has an IPMI driver available (if, say, CONFIG_IPMI_SI, CONFIG_IPMI_SI_MODULE, CONFIG_IPMI_SSIF, or CONFIG_IPMI_SSIF_MODULE are defined)... but would this be accepted?  Or is this something that will require reworking the IPMI drivers?  Or is there another way?

I'm willing to work on a patch, but I'm not sure what would be an acceptable way to fix this.

Thanks,
Stuart

