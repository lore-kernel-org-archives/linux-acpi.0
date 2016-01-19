From: Corey Minyard <cminyard@mvista.com>
Subject: Re: ACPI IPMI device with _CID getting wrong driver attached
Date: Tue, 19 Jan 2016 15:22:46 -0600
Message-ID: <569EA926.4050609@mvista.com>
References: <959D45574D89AF41A9DADF6F446A2E9A50AE8A4F6F@AUSX7MCPS310.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36175 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342AbcASVWs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jan 2016 16:22:48 -0500
Received: by mail-oi0-f50.google.com with SMTP id o124so192896607oia.3
        for <linux-acpi@vger.kernel.org>; Tue, 19 Jan 2016 13:22:48 -0800 (PST)
In-Reply-To: <959D45574D89AF41A9DADF6F446A2E9A50AE8A4F6F@AUSX7MCPS310.AMER.DELL.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stuart_Hayes@Dell.com, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net

On 01/19/2016 02:46 PM, Stuart_Hayes@Dell.com wrote:
> I'm having a problem on a number of systems where the IPMI driver isn't able to find the ACPI IPMI device.
>
> This is happening because the ACPI scan is attaching the acpi_pnp handler to the ACPI IPMI device, which is happening because the IPMI device has a _CID of PNP0C01 in addition to an _HID of IPI0001.  This is a problem because acpi_scan_attach_handler() doesn't know about the IPMI drivers (ipmi_si / ipmi_ssif), which don't register as PNP or ACPI drivers, but instead expect the ACPI scan find no applicable driver and thus create a platform device.

I recently pulled out the pnp code in ipmi_si in favour of a platform 
device.  The trouble was that you couldn't register both the ipmi_si and 
ipmi_ssif driver with IPI0001 (even though they were in different 
spaces) because IPI0001 was hard-coded into the acpi_pnp tables.  This 
fix prevented having to update a lot of firmware.

Plus I was under the impression that this was the right thing to do, 
anyway.  Perhaps it wasn't, but I didn't get a comment from the 
linux-acpi list when I submitted it (twice).

> This could be fixed pretty easily by modifying acpi_scan_attach_handler() to make it return 0 without attaching a handler to devices that have a _HID of IPI0001 when the kernel has an IPMI driver available (if, say, CONFIG_IPMI_SI, CONFIG_IPMI_SI_MODULE, CONFIG_IPMI_SSIF, or CONFIG_IPMI_SSIF_MODULE are defined)... but would this be accepted?

That sounds like a bad hack to me.

>    Or is this something that will require reworking the IPMI drivers?  Or is there another way?

The question in my mind is why the IPMI device has a _CID of PNP0C01 (or 
is it PNP0c01?  That's the only thing I found.).    From what I can tell 
from the spec, PNP0c01 is a "system board", and Linux has it as a 
"memory controller", neither of which is really applicable.

But I admit that I don't know very much about these things.  I believe 
the right place to fix this is the driver, if we can.  I'm hoping for a 
simple solution.

-corey
