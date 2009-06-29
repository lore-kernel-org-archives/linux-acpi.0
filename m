From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH 1/8] eeepc-laptop: Register as a pci-hotplug device
Date: Mon, 29 Jun 2009 13:44:24 +0100
Message-ID: <9b2b86520906290544g2f5d1da9m8539a5a6f67cf33c@mail.gmail.com>
References: <1245990020-20455-1-git-send-email-lenb@kernel.org>
	 <6af05c22969dce2776375953131b56e9f4282848.1245989983.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:41824 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbZF2Muc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Jun 2009 08:50:32 -0400
Received: by fxm18 with SMTP id 18so936395fxm.37
        for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2009 05:50:34 -0700 (PDT)
In-Reply-To: <6af05c22969dce2776375953131b56e9f4282848.1245989983.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentincj@iksaif.net>
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Randy Dunlap <randy.dunlap@oracle.com>

On 6/26/09, Len Brown <lenb@kernel.org> wrote:
> From: Corentin Chary <corentincj@iksaif.net>
>
> The eee contains a logically (but not physically) hotpluggable PCIe slot.
> Currently this is handled by adding or removing the PCI device in response
> to rfkill events, but if a user has forced pciehp to bind to it (with the
> force=1 argument) then both drivers will try to handle the event and
> hilarity (in the form of oopses) will ensue. This can be avoided by having
> eee-laptop register the slot as a hotplug slot. Only one of pciehp and
> eee-laptop will successfully register this, avoiding the problem.
>
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
> Tested-by: Darren Salt <linux@youmustbejoking.demon.co.uk>
> Signed-off-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> Signed-off-by: Len Brown <len.brown@intel.com>

Actually this only solves half the problem.

> +	result = eeepc_setup_pci_hotplug();
> +	/*
> +	 * If we get -EBUSY then something else is handling the PCI hotplug -
> +	 * don't fail in this case
> +	 */
> +	if (result == -EBUSY)
> +		return 0;
> +	else if (result)
> +		goto pci_fail;
> +
>  	return 0;

It works fine if eeepc-laptop is loaded first, preventing pciehp from
messing with the hardware.  But it doesn't stop eeepc-laptop from
messing with the hardware if pciehp is loaded first.  In that case,
eeepc-laptop fails to register as a PCI hotplug device, but it still
messes with the hardware.

I have tested this - if I do

modprobe -r eeepc-laptop
modprobe pciehp pciehp_force=1
modprobe eeepc-laptop

and press the wireless-toggle key a couple of times, I get a lovely
set of oopses and a non-responsive system.

Thanks
Alan
