From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/2] Export a func to find the corresponding PCI bus:seg.func of an ACPI device
Date: Mon, 15 Oct 2007 17:48:17 +0100
Message-ID: <20071015164816.GA5021@srcf.ucam.org>
References: <1192465985.9847.585.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:58214 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756531AbXJOQsc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Oct 2007 12:48:32 -0400
Content-Disposition: inline
In-Reply-To: <1192465985.9847.585.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Christian Birchinger <joker@netswarm.net>, "Li, Shaohua" <shaohua.li@intel.com>, Len Brown <lenb@kernel.org>, ibm-acpi-devel <ibm-acpi-devel@lists.sourceforge.net>

Why not just call acpi_get_pyhsical_device() on the appropriate handle 
and look at the struct device you get back? Remember to put_device() it 
once you're done.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
