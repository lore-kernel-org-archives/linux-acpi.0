From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH] acpica events: Call acpi_os_hotplug_execute on
 Ejection Requests
Date: Fri, 23 Sep 2011 02:13:11 +0100
Message-ID: <20110923011311.GA18632@srcf.ucam.org>
References: <1316733417-22528-1-git-send-email-prarit@redhat.com>
 <CAErSpo70F012EEh3TEdgK=rSst-27P-j8JxMDkcUaJGd29BnDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47864 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767Ab1IWBNO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Sep 2011 21:13:14 -0400
Content-Disposition: inline
In-Reply-To: <CAErSpo70F012EEh3TEdgK=rSst-27P-j8JxMDkcUaJGd29BnDg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Prarit Bhargava <prarit@redhat.com>, linux-acpi@vger.kernel.org

We're seeing an increasing number of machines that use acpi 
notifications to trigger rescans of devices - for instance, SD readers 
that only appear on the PCI bus once a card has been inserted. These 
often fail to flag themselves as removable or ejectable, so the acpiphp 
core never binds. I think we need to fix this pretty urgently, for PCI 
if nothing else.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
