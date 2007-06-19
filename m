From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 3/3] ACPI autoloading - Create __mod_acpi_device_table symbol for all acpi drivers.
Date: Tue, 19 Jun 2007 18:27:57 -0300
Message-ID: <20070619212757.GB23946@khazad-dum.debian.net>
References: <1182111863.4204.6.camel@noname> <20070617224947.GA17951@khazad-dum.debian.net> <1182257607.28514.643.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60393 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751191AbXFSV2G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Jun 2007 17:28:06 -0400
Content-Disposition: inline
In-Reply-To: <1182257607.28514.643.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Kay Sievers <kasievers@suse.de>

On Tue, 19 Jun 2007, Thomas Renninger wrote:
> On Sun, 2007-06-17 at 19:49 -0300, Henrique de Moraes Holschuh wrote:
> > On Sun, 17 Jun 2007, Thomas Renninger wrote:
> > > Create __mod_acpi_device_table symbol for all acpi drivers.
> > 
> > thinkpad-acpi will autoload by DMI ids in 2.6.23, which is a much better
> > solution for model-specific drivers like thinkpad-acpi than autoloading by
> > HID, IMHO.

> Yes, I saw some dmi udev strings on Kay's machine and for the thinkpad
> module dmi autoloading is much better.

Yeah. The HIDs thinkpad-acpi binds to might exist on non-thinkpads, while
the DMI matching should be good for all new boxes, and all of the old ones
which I have some sort of data on.  The few very old thinkpads I am not
autoloading on are probably not going to care, wouldn't benefit much from
thinkpad-acpi anyway... or they will send me email about it.

> Not in general, only if the driver provides additional functions and the
> ACPI device does not appear on machines that need those additional
> functions.

Or, if you risk too many false positives.

> > Thus, I'd prefer if your patches did not make thinkpad-acpi autoload by HID.

> It would not really hurt? At least thinkpad module is an acpi driver for

It would, if we start trying to autoload on false positive matches.  If we
did not have any other way to autoload, that would be fine, but since we
will have DMI matches also in 2.6.23...

> those two HIDs... But your are right, it's superfluous, here with
> __mod_acpi_device_table symbol ripped out of thinkpad.ko.

Thank you. I did not test the patch, but I am ok with it, now.

> Hmm, what do you think about splitting the Thinkpad driver into Hotkey,
> PCI and rest? This one got a complicated beast...

It is cooking.  In fact, I was halfway through it, when Richard started
getting me fired up about improving the input layer support in
thinkpad-acpi, which is a damn more fun thing to do... so it stalled, but
now thinkpad-acpi has proper input support, which I will be sending for
acpi-test merging quite soon now.

Some sort of split will be done. Probably for 2.6.23, even.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
