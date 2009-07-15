From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH -mm] ACPI video: only one ACPI bus video device is
 allowed for one VGA controller
Date: Wed, 15 Jul 2009 11:31:03 -0300
Message-ID: <20090715143103.GB22098@khazad-dum.debian.net>
References: <1247649488.26272.106.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37679 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753307AbZGOObI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jul 2009 10:31:08 -0400
Content-Disposition: inline
In-Reply-To: <1247649488.26272.106.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, hector@marcansoft.com

On Wed, 15 Jul 2009, Zhang Rui wrote:
> Only one ACPI video bus device for a VGA controller.
> 
> Some buggy BIOS exports multiple ACPI video bus devices for the same
> VGA controller, and multiple backlight control methods as well.
> This messes up the ACPI video backlight control.
> http://bugzilla.kernel.org/show_bug.cgi?id=13577
> 
> With this patch applied, only the first ACPI video bus device
> under a PCI device node is bind to ACPI video driver.
> 
> The questions is that, we never notice this kind of devices before,
> thus I'm not sure this won't break any laptops.

Laptops often have more than one video bus device, and you _have_ to choose
the one that is _active_ (which might not be the first one you find).  This
is done on laptops that can have either discrete or in-chipset graphics, for
example.  I have seen it in several thinkpad models.

There is also the new class of laptops that have *both* discrete and
in-chipset GPUs and can switch them at runtime (well, Linux can't cope with
it yet and ends up requiring the switch to be done in BIOS setup screen,
AFAIK, but I hope that changes someday).  I never looked at the DSDT of one
of these to know how it looks like, but it would make sense that the ACPI
video driver would have to be able to bind to more than one display device,
and drive them separately, and do the right thing when the device is
hotplugged/hotunplugged (or activated/deactivated)...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
