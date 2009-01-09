From: Thomas Renninger <trenn@suse.de>
Subject: Blacklist known broken machines to use the rsdt and enabled Cstates on R40e
Date: Fri,  9 Jan 2009 11:58:56 +0100
Message-ID: <1231498738-32714-1-git-send-email-trenn@suse.de>
References: <1229504118.3991.63.camel@yakui_zhao.sh.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:59796 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859AbZAIK67 (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Fri, 9 Jan 2009 05:58:59 -0500
In-Reply-To: <1229504118.3991.63.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, yakui.zhao@intel.com, Linux-acpi@vger.kernel.org, me@markdoughty.co.uk, ibm-acpi-devel@lists.sourceforge.net

Compile tested.
R40e has been tested to have working C-states when the rsdt is used with another
patchset some time ago.
The R50e has been tested to boot much faster when using the rsdt.
Lenovo confirmed that this is due to BIOS bugs (wrong 64 bit addresses in a FADT pointed to
by the XSDT) which will not be fixed, because the machines are too old.

    Thomas


