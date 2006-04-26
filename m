From: Andi Kleen <ak@suse.de>
Subject: Re: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Wed, 26 Apr 2006 13:27:29 +0200
Message-ID: <200604261327.29694.ak@suse.de>
References: <20060425160200.3424.89316.sendpatchset@dhcp83-97.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:23766 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932400AbWDZL3Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Apr 2006 07:29:24 -0400
In-Reply-To: <20060425160200.3424.89316.sendpatchset@dhcp83-97.boston.redhat.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kimball Murray <kimball.murray@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com, kmurray@redhat.com, natalie.protasevich@unisys.com, len.brown@intel.com, linux-acpi@vger.kernel.org

On Tuesday 25 April 2006 18:06, Kimball Murray wrote:
> Per Andi Kleen's request, I have made slight changes to the patch I
> submitted last week.  Look for the "snip" further down if you don't
> want to re-read the original post.  Thanks!

Added to my tree thanks.

But next time please don't paste other patches in the introduction.
It makes the patch merging scripts unhappy. Instead just resend the patch 
with the full initial description again. I fixed it up.

Thanks,

-Ando
