From: Krzysztof Kolasa <kkolasa@winsoft.pl>
Subject: Re: System crash on boot, system x86 32bit, kernel-next
Date: Sun, 29 Nov 2015 13:27:49 +0100
Message-ID: <565AEF45.9060109@winsoft.pl>
References: <565AD9A8.7060702@winsoft.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vps01.winsoft.pl ([5.133.9.51]:37440 "EHLO vps01.winsoft.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971AbbK2M1y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Nov 2015 07:27:54 -0500
In-Reply-To: <565AD9A8.7060702@winsoft.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, jiang.liu@linux.intel.com, hanjun.guo@linaro.org, bhelgaas@google.com, rafael.j.wysocki@intel.com

On 29.11.2015 11:55, Krzysztof Kolasa wrote:
> My old laptop, Fujitsu Siemens Amilo Pro v3405 hard oops on boot, bisected first bad commit:
> 
> 4d6b4e69a245 x86/PCI/ACPI: Use common interface to support PCI host bridge
> 

my oversight, problem solved two days earlier:

http://marc.info/?l=linux-acpi&m=144863858125985&w=2

the patch also works OK on my computer

Krzysztof Kolasa

