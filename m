From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI reads wrong temperature
Date: Mon, 3 Nov 2008 17:48:49 +0000
Message-ID: <20081103174849.GA4285@srcf.ucam.org>
References: <20081031140247.325670@gmx.net> <20081031143030.GA9177@srcf.ucam.org> <20081031210913.3180@gmx.net> <20081102092541.GE10983@srcf.ucam.org> <20081102113112.316040@gmx.net> <1225677936.26020.17.camel@yakui_zhao.sh.intel.com> <20081103090153.250280@gmx.net> <9F0C1DB20AFA954FA1DA05309350433D3E5CA72D@pdsmsx503.ccr.corp.intel.com> <20081103145723.GB496@srcf.ucam.org> <alpine.LFD.2.00.0811031246550.3132@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52542 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbYKCRs4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Nov 2008 12:48:56 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811031246550.3132@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Zhao, Yakui" <yakui.zhao@intel.com>, Peter Mahlknecht <mali100@gmx.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, Nov 03, 2008 at 12:47:19PM -0500, Len Brown wrote:
> 
> > I don't think the BIOS is doing anything wrong here. It's entitled to 
> > assume that the operating system won't load drivers for hardware it's 
> > not declaring.
> 
> agreed, we need a linux solution.

There's a kernel warning in this kind of situation, but IIRC we were 
still at the point where there were false positives.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
