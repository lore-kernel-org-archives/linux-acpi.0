From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 083/105] ACPI: prevent ACPI quirk warning mass spamming in logs
Date: Sun, 29 Apr 2007 11:58:53 +0200
Message-ID: <200704291158.54049.ak@suse.de>
References: <11778223052751-git-send-email-len.brown@intel.com> <11778223802796-git-send-email-len.brown@intel.com> <11778223812071-git-send-email-len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49381 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753066AbXD2KEQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 06:04:16 -0400
In-Reply-To: <11778223812071-git-send-email-len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Thierry Vignaud <tvignaud@mandriva.com>, Andrew Morton <akpm@linux-foundation.org>

On Sunday 29 April 2007 06:51:23 Len Brown wrote:
> From: Thierry Vignaud <tvignaud@mandriva.com>
> 
> The following patch prevent this warning to be displayed again & again (eg:
> nine times on my NForce2 motherboard) and thus improve signal to noise
> ratio in logs.

I already got that in my tree. Better let me submit it.

-Andi
