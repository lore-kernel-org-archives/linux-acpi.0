From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 0/2] ACPI: return error in acpi_pci_irq_enable when there
 is no irq
Date: Fri, 13 Sep 2013 08:52:18 -0400
Message-ID: <52330A82.7050607@redhat.com>
References: <1375965314-24232-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49436 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842Ab3IMMwX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Sep 2013 08:52:23 -0400
In-Reply-To: <1375965314-24232-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org



On 08/08/2013 08:35 AM, Heikki Krogerus wrote:
> Hi,
> 
> This is the fix for the Dell PowerEdge 840 issue where nothing
> allocated an irq for it's PCH if I understood correctly. The issue was
> reported by Prarit Bhargava.
> 
> The second patch is just a minor cleanup.
> 
> Thanks,
> 
> 
> Heikki Krogerus (2):
>   ACPI / PCI: don't allow PCI devices without irq to be enabled
>   ACPI / PCI: remove an extra check from acpi_pci_irq_enable()
> 

Rafael, is this in your queue?

Thanks,

P.
