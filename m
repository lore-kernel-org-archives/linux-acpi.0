From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Refcounting GPEs
Date: Tue, 18 Aug 2009 23:32:28 +0100
Message-ID: <20090818223228.GA2773@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56254 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbZHRWce (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Aug 2009 18:32:34 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Implementing runtime PM for PCI requires ensuring that device GPEs are 
enabled for runtime. This is made awkward by the fact that multiple PCI 
and ACPI devices may use the same GPE, so it's necessary to track how 
many devices currently want the GPE to be enabled. This would seem to 
imply some sort of refcounting, but I can't see an especially clean way 
to implement this in the current code. Does anyone have any preferences 
for what this interface should look like?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
