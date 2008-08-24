From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/2] Give ACPI hwmon thermal devices a name if BIOS provides one
Date: Mon, 25 Aug 2008 00:20:41 +0200
Message-ID: <200808250020.41626.trenn@suse.de>
References: <20080821174852.0689681d@hyperion.delvare> <1219615897-21130-3-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:38462 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750909AbYHXWVS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 Aug 2008 18:21:18 -0400
In-Reply-To: <1219615897-21130-3-git-send-email-trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: khali@linux-fr.org
Cc: rui.zhang@intel.com, linux-acpi@vger.kernel.org

On Monday 25 August 2008 12:11:37 am Thomas Renninger wrote:
> On a HP tx2500z laptop one thermal device provides this function:
>             Name (REGN, "Processor Thermal Zone")

I wonder what we can do to get this added to the ACPI spec or to make
vendors use the same function for this.

What about trying for above "REGN" as it already exists on HPs.
Also try for _NAM (or similar), document that we do this and tell vendors
that it's a good thing to provide a sane string/name for thermal_zones on 
Linux.
On ACPI everything that does not start with "_" means unspecified
and the function should only be used internally and not by the OS...

     Thomas
