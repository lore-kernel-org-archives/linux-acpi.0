From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI reads wrong temperature
Date: Mon, 3 Nov 2008 14:57:23 +0000
Message-ID: <20081103145723.GB496@srcf.ucam.org>
References: <20081031140247.325670@gmx.net> <20081031143030.GA9177@srcf.ucam.org> <20081031210913.3180@gmx.net> <20081102092541.GE10983@srcf.ucam.org> <20081102113112.316040@gmx.net> <1225677936.26020.17.camel@yakui_zhao.sh.intel.com> <20081103090153.250280@gmx.net> <9F0C1DB20AFA954FA1DA05309350433D3E5CA72D@pdsmsx503.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:39583 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955AbYKCO50 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Nov 2008 09:57:26 -0500
Content-Disposition: inline
In-Reply-To: <9F0C1DB20AFA954FA1DA05309350433D3E5CA72D@pdsmsx503.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhao, Yakui" <yakui.zhao@intel.com>
Cc: Peter Mahlknecht <mali100@gmx.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, Nov 03, 2008 at 10:50:27PM +0800, Zhao, Yakui wrote:
> Thanks for the info.
> From the attached info we can know that the I/O start address for SMbus is 0x18E0. And SMbus is internally used in AML code.
> 
> If the I2C-i801 driver is loaded, there is the conflict between BIOS and OS.
> 
> So I think that it is a BIOS bug. And this can't be fixed by Linux-kernel.

I don't think the BIOS is doing anything wrong here. It's entitled to 
assume that the operating system won't load drivers for hardware it's 
not declaring.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
