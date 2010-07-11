From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Add intel drm blacklist to intel_opregion_present
	detect
Date: Sun, 11 Jul 2010 15:27:45 +0100
Message-ID: <20100711142745.GA27197@srcf.ucam.org>
References: <1278808157-6441-1-git-send-email-jlee@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:39127 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020Ab0GKO1w (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Jul 2010 10:27:52 -0400
Content-Disposition: inline
In-Reply-To: <1278808157-6441-1-git-send-email-jlee@novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: linux-acpi@vger.kernel.org, "Lee, Chun-Yi" <jlee@novell.com>

On Sun, Jul 11, 2010 at 08:29:17AM +0800, Lee, Chun-Yi wrote:
> There have some machines not support by i915 drm driver, e.g. MSI U110/U150,
> there are use poulsbo chip and drm driver not support it because legal issue.
> Those machines's acpi backlight control actually work fine and don't need apply
> the intel opregion support.
> So, add intel drm blacklist to intel_opregion_present, it can enable the acpi
> brightness interface but not use intel opregion.

The correct fix is for a native Poulsbo driver that impleents the 
opregion spec. If people are running vesa on these machines then I think 
backlight control is really the least of their concerns.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
