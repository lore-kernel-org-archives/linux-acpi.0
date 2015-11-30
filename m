From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: System crash on boot, system x86 32bit, kernel-next
Date: Mon, 30 Nov 2015 03:15:50 +0100
Message-ID: <2283173.SshlpcnRtM@vostro.rjw.lan>
References: <565AD9A8.7060702@winsoft.pl> <565AEF45.9060109@winsoft.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62239 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751730AbbK3BqE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Nov 2015 20:46:04 -0500
In-Reply-To: <565AEF45.9060109@winsoft.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Krzysztof Kolasa <kkolasa@winsoft.pl>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, jiang.liu@linux.intel.com, hanjun.guo@linaro.org, bhelgaas@google.com, rafael.j.wysocki@intel.com

On Sunday, November 29, 2015 01:27:49 PM Krzysztof Kolasa wrote:
> On 29.11.2015 11:55, Krzysztof Kolasa wrote:
> > My old laptop, Fujitsu Siemens Amilo Pro v3405 hard oops on boot, bisected first bad commit:
> > 
> > 4d6b4e69a245 x86/PCI/ACPI: Use common interface to support PCI host bridge
> > 
> 
> my oversight, problem solved two days earlier:
> 
> http://marc.info/?l=linux-acpi&m=144863858125985&w=2
> 
> the patch also works OK on my computer

Great, thanks for letting us know!

Rafael

