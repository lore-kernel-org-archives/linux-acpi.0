From: Thomas Renninger <trenn@suse.de>
Subject: Re: Introduce interface to report BIOS bugs (reworked, FW_BUG simple solution)
Date: Wed, 27 Aug 2008 15:34:18 +0200
Message-ID: <200808271534.19715.trenn@suse.de>
References: <200808210919.07642.bjorn.helgaas@hp.com> <1219843631-26015-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40599 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754319AbYH0NeV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Aug 2008 09:34:21 -0400
In-Reply-To: <1219843631-26015-1-git-send-email-trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org, arjan@linux.intel.com, linux-acpi@vger.kernel.org, ckornacker@suse.de

On Wednesday 27 August 2008 15:27:08 Thomas Renninger wrote:
> Even simplier, using FW_BUG define. I agree that the first implementation
...
Ehh, this is not against ACPI test but latest Linus .27-rcX tree.
I hope/think it should still patch in both.

While this is fairly simple code, be aware that it's only compile tested.

    Thomas
