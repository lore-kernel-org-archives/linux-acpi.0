From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: disabling "rfkill hotplug" on newer eeepc-laptop models
Date: Mon, 22 Feb 2010 15:10:36 +0100
Message-ID: <71cd59b01002220610x3c5e182ep20bf4c701a55fccc@mail.gmail.com>
References: <4B7FDAAD.1040704@tuffmail.co.uk>
	 <20100220154415.GA25161@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:33533 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031Ab0BVOKh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Feb 2010 09:10:37 -0500
In-Reply-To: <20100220154415.GA25161@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux-pci@vger.kernel.org, linux acpi <linux-acpi@vger.kernel.org>

On Sat, Feb 20, 2010 at 4:44 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Sat, Feb 20, 2010 at 12:50:53PM +0000, Alan Jenkins wrote:
>
>> 1. checking PCI config space, to see whether the device is really absent
>> before we mark it as unplugged.
>> 2. a generic mechanism which would replace the current eeepc-specific code.
>
> The generic mechanism will become necessary with .34 anyway, as soon as
> the PCI runtime power management code lands. It'll be taking the
> notification handlers for these devices.
>
> I think we effectively need to move some of the acpiphp code and make it
> generic. These shouldn't be exposed as hotplug slots, but if we receive
> a rescan notification and the device is no longer there then it's pretty
> obvious that we need to remove it...
>
> On the other hand, your patch looks fine for the immediate issue.
>
> --
> Matthew Garrett | mjg59@srcf.ucam.org
>

Alan, could you re-send the patch with a formated changelog ? (and you
can add my Acked-By)
Thanks,

-- 
Corentin Chary
http://xf.iksaif.net
