From: Jike Song <albcamus@gmail.com>
Subject: Re: [PATCH 2/8] PCI / PCIe/ AER: Introduce pci_aer_available()
Date: Tue, 3 Aug 2010 17:41:38 +0800
Message-ID: <AANLkTimZV8KSkAR5Tc0nDK=TmzX1edKiJ9qSSgZ8v0h9@mail.gmail.com>
References: <201008022351.31406.rjw@sisk.pl>
	<201008022354.46369.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:60303 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755535Ab0HCJlk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Aug 2010 05:41:40 -0400
In-Reply-To: <201008022354.46369.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, linux-pm@lists.linux-foundation.org, linux-pci@vger.kernel.org, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Matthew Garrett <mjg59@srcf.ucam.org>

On Tue, Aug 3, 2010 at 5:54 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Introduce a function allowing the caller to check if PCIe AER should
> be enabled.
>

Maybe it's misnamed?  How about pcie_aer_disable is not set and MSI is
enabled, but there is not AER capability implemented at all?

-- 
Thanks,
Jike
