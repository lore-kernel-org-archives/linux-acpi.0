From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH RESEND] ACPI: Add Toshiba NB100 to Vista _OSI blacklist
Date: Tue, 29 Oct 2013 23:44:50 +0100
Message-ID: <2710175.xeuRHdVpyL@vostro.rjw.lan>
References: <526FE7E8.80806@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65162 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752056Ab3J2Wcm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Oct 2013 18:32:42 -0400
In-Reply-To: <526FE7E8.80806@linux.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: levex@linux.com
Cc: Len Brown <lenb@kernel.org>, Robert Hancock <hancockrwd@gmail.com>, Aaron Lu <aaron.lu@intel.com>, ACPI List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tuesday, October 29, 2013 05:52:56 PM Levente Kurusa wrote:
> This patch adds Toshiba NB100 to the Vista _OSI blacklist.
> 
> The _OSI(Windows 2006) method is bugged on the netbook resulting in messed up
> PCI IRQ Routing information. This was observed on a netbook,
> whose SATA controller mode was set to Compatibility mode.
> The driver would then register itself to IRQ#16, but the device
> was in fact issuing interrupts to IRQ#20.
> No side-effects were found during testing, everything is
> working as it did before.
> 
> See thread:
> http://marc.info/?t=137862230200001&r=1&w=2
> http://www.spinics.net/lists/linux-ide/msg46173.html
> 
> 
> Signed-off-by: Levente Kurusa <levex@linux.com>
> Reviewed-by: Robert Hancock <hancockrwd@gmail.com>

That should be in linux-pm/linux-next already, isn't it there?

Rafael

