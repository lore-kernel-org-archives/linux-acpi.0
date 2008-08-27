From: Andi Kleen <ak@linux.intel.com>
Subject: Re: Introduce interface to report BIOS bugs (reworked, FW_BUG simple
 solution)
Date: Wed, 27 Aug 2008 17:19:16 +0200
Message-ID: <48B57074.40201@linux.intel.com>
References: <200808210919.07642.bjorn.helgaas@hp.com> <1219843631-26015-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:8901 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754516AbYH0PTO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Aug 2008 11:19:14 -0400
In-Reply-To: <1219843631-26015-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org, arjan@linux.intel.com, linux-acpi@vger.kernel.org, ckornacker@suse.de

Thomas Renninger wrote:
> Even simplier, using FW_BUG define. I agree that the first implementation
> was over-designed, I somehow liked the printk_fw_err() and printk_fw_info()
> more, looked somehow more consistent with:

Looks good to me now. The only issue is that the patchkit is cross subsystem
(cpufreq and ACPI). Either the patches go in through Andrew or we need
to figure out how to merge this.
-Andi
