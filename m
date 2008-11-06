From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: ACPI reads wrong temperature
Date: Thu, 06 Nov 2008 14:12:52 +0800
Message-ID: <1225951972.3989.99.camel@yakui_zhao.sh.intel.com>
References: <20081031140247.325670@gmx.net>
	 <20081031143030.GA9177@srcf.ucam.org> <20081031210913.3180@gmx.net>
	 <20081102092541.GE10983@srcf.ucam.org> <20081102113112.316040@gmx.net>
	 <1225677936.26020.17.camel@yakui_zhao.sh.intel.com>
	 <20081103090153.250280@gmx.net>
	 <9F0C1DB20AFA954FA1DA05309350433D3E5CA72D@pdsmsx503.ccr.corp.intel.com>
	 <20081103145723.GB496@srcf.ucam.org>
	 <alpine.LFD.2.00.0811031246550.3132@localhost.localdomain>
	 <20081103174849.GA4285@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45693 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886AbYKFGFo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Nov 2008 01:05:44 -0500
In-Reply-To: <20081103174849.GA4285@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, Peter Mahlknecht <mali100@gmx.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2008-11-04 at 01:48 +0800, Matthew Garrett wrote:
> On Mon, Nov 03, 2008 at 12:47:19PM -0500, Len Brown wrote:
> > 
> > > I don't think the BIOS is doing anything wrong here. It's entitled to 
> > > assume that the operating system won't load drivers for hardware it's 
> > > not declaring.
> > 
> > agreed, we need a linux solution.
> 
> There's a kernel warning in this kind of situation, but IIRC we were 
> still at the point where there were false positives.
On your box after the i2c-i801 driver is loaded, the smbus controller
will be used by the AML code and i2c-i801 driver. Unfortunately there is
no synchronization between them. IMO this is the BIOS fault. The SMbus
will be accessed by the two different modules. But it is exported by
BIOS. 
    So the better solution is that:
    a. SMBus is hidden in BIOS. In such case the Linux OS can't detect
the SMbus controller . Of course it won't try to load the device driver
for it. 
    b. Linux OS won't load the device driver for it. 

thanks.
> 

