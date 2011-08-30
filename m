From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 0/2] Implement overriding of arbitrary ACPI tables via initrd
Date: Tue, 30 Aug 2011 13:41:33 +0200
Message-ID: <201108301341.33452.trenn@suse.de>
References: <1314179290-31526-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42559 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753254Ab1H3Llf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Aug 2011 07:41:35 -0400
In-Reply-To: <1314179290-31526-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, hpa@zytor.com, Lin Ming <ming.m.lin@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: eric.piel@tremplin-utc.net, jnelson-suse@jamponi.net, devel@acpica.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org

Hi Len, Hi Robert, hi Lin,

what's your opinion about these patches?
I just sent a tiny bug fix which slipped in when I did
last minute cleanups.

Is the additional acpi_os_phys_table_override() function which
would be needed in ACPICA sources acceptable?

I'd appreciate if the acpica adoption can be made by
acpica people, but if you give green light, I can also
re-write the first patch against acpica sources.

As this needs syncing with acpica it would be great if the first
steps can be made, so that this can show up in 3.2 release.

Thanks,

   Thomas

On Wednesday, August 24, 2011 11:48:08 AM Thomas Renninger wrote:
> This patch series got some basic testing already (see patch 2 changelog) and
> is based on latest 3.1-rc2 Linus kernel.
> 
> The patches are separated into ACPICA parts (patch 1) and kernel parts (patch 2).
> 
> They are ready for integeration (if now objections should show up in a review
> discussion) and it would be great if they can be added in Len's latest acpi-test
> tree for broader testing.
> 
> Thanks,
> 
>    Thomas
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

