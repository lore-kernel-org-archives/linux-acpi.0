From: Corey Minyard <minyard@acm.org>
Subject: Re: [Openipmi-developer] acpi_find_bmc() and acpi_get_table()
Date: Wed, 28 Feb 2007 16:44:56 -0600
Message-ID: <45E605E8.1010502@acm.org>
References: <200702102327.28312.lenb@kernel.org> <45E5F733.8080708@acm.org>	<5DDAB7BA7BDB58439DD0EED0B8E9A3AE073884@ausx3mpc102.aus.amer.dell.com> <200702281535.31329.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mta9.adelphia.net ([68.168.78.199]:44927 "EHLO
	mta9.adelphia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932089AbXB1Wo7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Feb 2007 17:44:59 -0500
In-Reply-To: <200702281535.31329.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jordan_Hargrave@dell.com, linux-acpi@vger.kernel.org, Matt_Domsch@dell.com, alexey.y.starikovskiy@linux.intel.com, openipmi-developer@lists.sourceforge.net, lenb@kernel.org

Bjorn Helgaas wrote:
> On Wednesday 28 February 2007 15:05, Jordan_Hargrave@dell.com wrote:
>   
>> The reason for the acpi_bus_register/unregister is to get the handle
>> of the IPMI ACPI object.  There isn't a way to get the device handle
>> otherwise.  Once it gets the handle it doesn't need the ACPI device
>> anymore.
>>     
>
> Well, but in a world of truth and beauty, we should treat the
> interface as an ACPI device, and we really should only be using
> it after acpi_ipmi_add() and before acpi_ipmi_remove().  So that
> implies that we shouldn't call acpi_bus_unregister_driver() until
> we're ready to unload the driver.
>   
yes, that sounds more reasonable to me.
> I have no idea how multiple IPMI devices should be handled.  But
> some HP systems have several, and I think they can be hot-added
> and removed.
The current IPMI driver can actually do hot add and remove, so if the low-level ACPI code does the add/remove, it will automagically work.    I'd like to know how well that worked :).

-Corey
