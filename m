From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 3/4] drm/i915: use ACPI LID status for LVDS ->detect
	hook
Date: Wed, 15 Jul 2009 23:55:58 +0100
Message-ID: <20090715225558.GC31194@srcf.ucam.org>
References: <1247695886-18432-1-git-send-email-jbarnes@virtuousgeek.org> <1247695886-18432-4-git-send-email-jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:57224 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117AbZGOW4A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jul 2009 18:56:00 -0400
Content-Disposition: inline
In-Reply-To: <1247695886-18432-4-git-send-email-jbarnes@virtuousgeek.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org

On Wed, Jul 15, 2009 at 03:11:25PM -0700, Jesse Barnes wrote:
> We can't load or hotplug detect LVDS like we can other outputs, but if
> there's a lid device present we can use it as a proxy.  This allows the
> LFP state to be determined at ->detect time, making configurations
> requiring manual intervention today "just work" assuming the lid device
> status is correct.

I'm a bit unhappy with this appearing to be generic functionality but 
ending up implemented in the driver rather than in the KMS core. If this 
is going in then can we at least document this behaviour and that other 
KMS drivers are expected to implement it?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
