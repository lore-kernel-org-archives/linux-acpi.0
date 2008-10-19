From: Thomas Renninger <trenn@suse.de>
Subject: [RESEND] [PATCH 0/3] Blacklist broken ThinkPads to use 32 bit FADT addresses
Date: Sun, 19 Oct 2008 23:49:31 +0200
Message-ID: <200810192349.32949.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:40035 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270AbYJSVtb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 19 Oct 2008 17:49:31 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "devel@acpica.org" <devel@acpica.org>

Hi,

can this be taken into .28 if it works out with acpica integration.

Patches are in OpenSUSE for quite a while now (also 11.0) and the
issue has been evaluate to the ground now.

Lenovo confirmed that some rare models which got Vista support added
late through BIOS upgrades could have wrong 64 bit addresses.

Vista also takes the broken 64 bit addresses like Linux does (spec conform).
XP does take the correct 32 bit addresses.

A generic approach (e.g. check through _OSI) does not work, because:
  - the affected models support Vista (there the wrong addresses are also 
taken, but
    the symptoms seem not to happen or are also workarounded)
  - Those IO addresses are touched before the DSDT is parsed -> no OSI
    OS feature support check possible.

Be aware that one patch makes changes in ACPICA code.

Thanks,

     Thomas
