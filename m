From: "Huang, FrankR" <FrankR.Huang@amd.com>
Subject: RE: [Devel] RE: Welcome to the "Devel" mailing list
Date: Thu, 23 Oct 2008 09:59:37 +0800
Message-ID: <DD1CC71B621B004FA76856E5129D6B1702126C59@sbjgexmb1.amd.com>
References: <mailman.0.1224489394.31433.devel@lists.acpica.org> <DD1CC71B621B004FA76856E5129D6B17020B97D1@sbjgexmb1.amd.com> <d3f22a0810201931m6be4de39sf9e6a94ff658e427@mail.gmail.com> <DD1CC71B621B004FA76856E5129D6B17020B99D3@sbjgexmb1.amd.com> <d3f22a0810210024w5403eacbk5a4c6b46a8488dd8@mail.gmail.com> <DD1CC71B621B004FA76856E5129D6B17020B9A1B@sbjgexmb1.amd.com> <d3f22a0810210111v2e3f4ec2p74832538e3bd7a0d@mail.gmail.com> <DD1CC71B621B004FA76856E5129D6B17020B9B14@sbjgexmb1.amd.com> <alpine.LFD.1.10.0810220014380.2984@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:2668 "EHLO
	SG2EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181AbYJWCGt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Oct 2008 22:06:49 -0400
Content-Class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Len,

	I used the 2.6.27 kernel to gave a try. But there is less info. for ACPI , moreover,not as much as 2.6.24 kernel(only the ACPI table info).
	The config for ACPI is nearly the same, and acpi.debug_level and acpi.debug_layer is the same value.

Thanks,
Frank

-----Original Message-----
From: Huang, FrankR 
Sent: Wednesday, October 22, 2008 1:47 PM
To: 'Len Brown'
Cc: 'linux-acpi@vger.kernel.org'
Subject: RE: [Devel] RE: Welcome to the "Devel" mailing list

 Thanks, Len.
 I need the ACPI_FUNCTION_TRACE output , otherwise I will write printk() for look into the kernel acpi load process and debug my BIOS acpi part.
 I have tried the 2.6.22 and .2.6.24 kernel. Unfuntunely, after setting the acpi.debug_level and acpi.debug_layer to 0xFFFFFFFF and give the enough log_buf_len. Still there is no ACPI_FUNCTION_TRACE out.
 I'll try the 2.6.27 kernel and report the result.

Thanks,
Frank

-----Original Message-----
From: Len Brown [mailto:lenb@kernel.org]
Sent: Wednesday, October 22, 2008 12:18 PM
To: Huang, FrankR
Cc: Lin Ming; devel@lists.acpica.org
Subject: RE: [Devel] RE: Welcome to the "Devel" mailing list

wrong list for this (linux specific) discussion, it should be on linux-acpi@vger.kernel.org

function tracing is not a new feature, it should work in 2.6.22 as well.
the new part was splitting it out into its own config option -- it used to be enabled under CONFIG_ACPI_DEBUG=y.
maybe we screwed it up when we split it out and didn't notice b/c it isn't used often.
If 2.6.27 doesn't work, please report it to the list above.

thanks,
-Len


On Tue, 21 Oct 2008, Huang, FrankR wrote:

> I use 2.6.24 kernel and have this option to Y. But still there is no ACPI_FUNCTION_TRACE output. 
> 
> -----Original Message-----
> From: Lin Ming [mailto:lin@minggr.cn]
> Sent: Tuesday, October 21, 2008 4:11 PM
> To: Huang, FrankR
> Cc: devel@lists.acpica.org
> Subject: Re: [Devel] RE: Welcome to the "Devel" mailing list
> 
> You also have to config CONFIG_ACPI_DEBUG_FUNC_TRACE=y.
> 
> Lin Ming
> 


