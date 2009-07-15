From: Hector Martin <hector@marcansoft.com>
Subject: Re: [PATCH -mm] ACPI video: only one ACPI bus video device is allowed
 for one VGA controller
Date: Wed, 15 Jul 2009 23:59:36 +0200
Message-ID: <4A5E5148.808@marcansoft.com>
References: <1247649488.26272.106.camel@rzhang-dt> <20090715143103.GB22098@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from marcansoft.com ([80.68.93.119]:55651 "EHLO smtp.marcansoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286AbZGOV7j (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jul 2009 17:59:39 -0400
In-Reply-To: <20090715143103.GB22098@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

Henrique de Moraes Holschuh wrote:
> On Wed, 15 Jul 2009, Zhang Rui wrote:
>> Only one ACPI video bus device for a VGA controller.
>>
>> Some buggy BIOS exports multiple ACPI video bus devices for the same
>> VGA controller, and multiple backlight control methods as well.
>> This messes up the ACPI video backlight control.
>> http://bugzilla.kernel.org/show_bug.cgi?id=13577
>>
>> With this patch applied, only the first ACPI video bus device
>> under a PCI device node is bind to ACPI video driver.
>>
>> The questions is that, we never notice this kind of devices before,
>> thus I'm not sure this won't break any laptops.
> 
> Laptops often have more than one video bus device, and you _have_ to choose
> the one that is _active_ (which might not be the first one you find).  This
> is done on laptops that can have either discrete or in-chipset graphics, for
> example.  I have seen it in several thinkpad models.

The video subsystem already picks only graphics devices that actually
exist in the PCI bus. The issue here is that there are two ACPI
"subdevices" under one address reference to a PCI device (which exists),
and both have backlight functionality. I am not aware of any standard
method to distinguish between such devices - I'd say it's probably yet
another DSDT bug.

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc

