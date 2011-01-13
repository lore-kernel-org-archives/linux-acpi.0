From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 28/48] thermal: Add event notification to thermal framework
Date: Thu, 13 Jan 2011 12:21:43 +0100
Message-ID: <201101131221.43797.trenn@suse.de>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org> <201101131207.01290.trenn@suse.de> <201101131214.14677.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41460 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756571Ab1AMLVp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Jan 2011 06:21:45 -0500
In-Reply-To: <201101131214.14677.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, "R.Durgadoss" <durgadoss.r@intel.com>

On Thursday 13 January 2011 12:14:14 Thomas Renninger wrote:
> thermal: Rename exported func generate_netlink_event to thermal_netlink_event

I wonder why this one got exported at all.
It's only used in thermal_sys.c for now?
I hope I didn't oversee a follow up patch in another
driver which already makes use of it.

   Thomas
