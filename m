From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Subject: Re: [OLPC-devel] Re: [RFC][PATCH 1/2] ACPI: Idle Processor PM	Improvements
Date: Fri, 01 Sep 2006 15:14:47 +0200
Message-ID: <44F83247.8050309@gmx.net>
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com>	<200608311713.21618.bjorn.helgaas@hp.com>	<1157070616.7974.232.camel@localhost.localdomain> <200608312353.05337.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:409 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751113AbWIANPF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Sep 2006 09:15:05 -0400
In-Reply-To: <200608312353.05337.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: jg@laptop.org, Linux Kernel ML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, ACPI ML <linux-acpi@vger.kernel.org>, Adam Belay <abelay@novell.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, devel@laptop.org, Bjorn Helgaas <bjorn.helgaas@hp.com>

Len Brown wrote:
> 
> But frankly, with gaping functionality holes in Linux suspend/resume support such as
> IDE and SATA, I think that optimizing for suspend/resume speed on a mainstream laptop
> is somewhat "forward looking".

OLPC has no IDE/SATA devices, just 512 MB of onboard NAND flash.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
