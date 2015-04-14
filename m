From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] PCI / hotplug: Propagate the "ignore hotplug" setting to
 parent
Date: Tue, 14 Apr 2015 12:28:12 -0300
Message-ID: <1429025292.3383705.253616133.4A1DF301@webmail.messagingengine.com>
References: <2001450.KHHLaZsp3O@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40317 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754077AbbDNP2N (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Apr 2015 11:28:13 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id E42D920ABA
	for <linux-acpi@vger.kernel.org>; Tue, 14 Apr 2015 11:28:12 -0400 (EDT)
In-Reply-To: <2001450.KHHLaZsp3O@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Apr 13, 2015, at 11:23, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Refine the mechanism introduced by commit f244d8b623da (ACPIPHP / radeon
> / nouveau: Fix VGA switcheroo problem related to hotplug) to propagate
> the ignore_hotplug setting of the device to its parent bridge in case
> hotplug notifications related to the graphics adapter switching are
> given for the bridge rather than for the device itself (the need to
> be ignored in both cases).

I do apologise if this is a stupid question, but is there any chance the bridge will be connected to other devices that do require hotplug handling, and not just to the GPU?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
