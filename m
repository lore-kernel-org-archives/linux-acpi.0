From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 053/112] the generic thermal sysfs driver
Date: Thu, 7 Feb 2008 20:09:01 +0000
Message-ID: <20080207200900.GA2082@srcf.ucam.org>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com> <203d3d4aa482339b4816f131f713e1b8ee37f6dd.1202376824.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:46374 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933734AbYBGUJR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 15:09:17 -0500
Content-Disposition: inline
In-Reply-To: <203d3d4aa482339b4816f131f713e1b8ee37f6dd.1202376824.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Thomas Sujith <sujith.thomas@intel.com>, Len Brown <len.brown@intel.com>

On Thu, Feb 07, 2008 at 04:34:15AM -0500, Len Brown wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> The Generic Thermal sysfs driver for thermal management.

There's still ongoing discussion about what the interface should look 
like (and I certainly agree that the difference in units between this 
class and hwmon should be a showstopper) - can we skip pushing this 
until those are resolved?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
