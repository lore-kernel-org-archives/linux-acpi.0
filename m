From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Acer Aspire 5315 cooling problems with new kernel(s)
Date: Tue, 08 Dec 2009 09:08:34 +0800
Message-ID: <1260234514.27069.184.camel@rzhang1-desktop>
References: <4B1D9AD3.9040303@maskui.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60968 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965208AbZLHBHW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Dec 2009 20:07:22 -0500
In-Reply-To: <4B1D9AD3.9040303@maskui.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eabe Kuik <e.kuik@maskui.nl>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2009-12-08 at 08:16 +0800, Eabe Kuik wrote:
> Hi,
> 
> I'm using the kernel 2.6.29.6-huge-smp that comes with Slackware 13.0,
> the installed distro. I noticed that newer kernels (2.6.31.6 & 2.6.32)
> don't handle the cooling fan correct on my Acer Aspire 5315 (Bios
> V1.29). The 2.6.31.6 kernel does not turn on the fan so that the
> laptop shuts itself down to prevent overheating and damaging the
> hardware. With the 2.6.32 kernel the fan is turn on, but not
> controled! E.g. it runs on one speed, not like the 2.6.29.6 kernel
> that matches the fan speed to the temperature.
> 
> 2.6.31.6 config -> http://pastebin.com/m4ec3e8a1
> 2.6.32 config -> http://pastebin.com/m58669dc
> 
> So, for now I'm stuck with the 2.6.29.6 kernel. I hope you can solve
> this in the future kernels.
> 

it would be great if you can open a new bug at
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
and attach the dmesg, acpidump output.
please also verify if boot option "acpi_enforce_resources=lax" helps in
2.6.31 kernel.

thanks,
rui


