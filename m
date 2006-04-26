From: Andi Kleen <ak@suse.de>
Subject: Re: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Wed, 26 Apr 2006 15:17:05 +0200
Message-ID: <200604261517.06505.ak@suse.de>
References: <CFF307C98FEABE47A452B27C06B85BB6466487@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:38578 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932428AbWDZNRZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Apr 2006 09:17:25 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6466487@hdsmsx411.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Kimball Murray <kimball.murray@gmail.com>, linux-kernel@vger.kernel.org, akpm@digeo.com, kmurray@redhat.com, natalie.protasevich@unisys.com, linux-acpi@vger.kernel.org

On Tuesday 25 April 2006 21:53, Brown, Len wrote:
> I'd rather see the original irq-renaming patch
> and its subsequent multiple via workaround patches
> reverted than to further complicate what is becoming
> a fragile mess.

Sorry rechecking - i already got the patch now. You want me to drop it again?

I guess we could drop it all, but VIA must still work afterwards.
How would we do that?

-Andi
