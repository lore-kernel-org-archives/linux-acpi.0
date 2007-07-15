From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI: thinkpad-acpi: rename pci HID constant
Date: Sun, 15 Jul 2007 22:23:38 +0100
Message-ID: <20070715212338.GA6610@srcf.ucam.org>
References: <11844223322928-git-send-email-hmh@hmh.eng.br> <11844223351798-git-send-email-hmh@hmh.eng.br> <20070714223713.GC25782@srcf.ucam.org> <20070715180246.GE14134@khazad-dum.debian.net> <20070715183412.GB3235@srcf.ucam.org> <20070715211820.GH19066@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:60900 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbXGOVXr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Jul 2007 17:23:47 -0400
Content-Disposition: inline
In-Reply-To: <20070715211820.GH19066@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: lenb@kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Sun, Jul 15, 2007 at 06:18:21PM -0300, Henrique de Moraes Holschuh wrote:

> Oh, you CAN use the IBM0068 device to autoload.  I am not really sure
> nothing but ThinkPads use it, and I already have other autoload hooks (based
> on DMI) anyway, but it can be used as an autoload hint, yes.
> 
> But the comment about not using a HID for driver autoloading is for the
> PCI_ROOT_HID_STRING only.  Is it in a confusing place on the source code, or
> somesuch?

Sorry, I managed to misread the second hunk of the patch as defining 
PCI_ROOT_HID_STRING as IBM0068 - I'm utterly wrong here, please ignore 
me :)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
