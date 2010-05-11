From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH] acpi: fix early DSDT dmi check warnings on ia64
Date: Tue, 11 May 2010 16:01:31 -0700
Message-ID: <987664A83D2D224EAE907B061CE93D53C5D446C0@orsmsx505.amr.corp.intel.com>
References: <1272505354.9950.16.camel@minggr.sh.intel.com>
	 <201004290956.26922.bjorn.helgaas@hp.com>
	 <987664A83D2D224EAE907B061CE93D53B91F9656@orsmsx505.amr.corp.intel.com>
	 <1273111119.9950.41.camel@minggr.sh.intel.com>
 <1273543767.30322.2.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:65433 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752391Ab0EKXBd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 May 2010 19:01:33 -0400
In-Reply-To: <1273543767.30322.2.camel@minggr.sh.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lin, Ming M" <ming.m.lin@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

+#ifdef CONFIG_X86
 static struct dmi_system_id dsdt_dmi_table[] __initdata = {

This #ifdef needs to be a few lines earlier to avoid getting a
warning:

drivers/acpi/bus.c:73: 'set_copy_dsdt' defined but not used

But otherwise this patch does work and fixes the problem.

Tested-by: Tony Luck <tony.luck@intel.com>

Insyde are now writing BIOS for ia64 systems (I have two in
my lab). I hope they don't copy this bug from their laptop
BIOS to my systems.  If they do, we'd have to revisit this :-)

-Tony
