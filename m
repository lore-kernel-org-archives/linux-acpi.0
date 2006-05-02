From: Andi Kleen <ak@suse.de>
Subject: Re: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Tue, 2 May 2006 09:46:45 +0200
Message-ID: <200605020946.46050.ak@suse.de>
References: <CFF307C98FEABE47A452B27C06B85BB652DF16@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:59614 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932250AbWEBHrE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 May 2006 03:47:04 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB652DF16@hdsmsx411.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>, sergio@sergiomb.no-ip.org, Kimball Murray <kimball.murray@gmail.com>, linux-kernel@vger.kernel.org, akpm@digeo.com, kmurray@redhat.com, linux-acpi@vger.kernel.org

On Tuesday 02 May 2006 09:41, Brown, Len wrote:

> You are right.  This code is wrong.
> It makes absolutely no sense to reserve vectors in advance
> for every RTE in the IOAPIC when we don't even know if they
> are going to be used.
> 
> This is clearly a holdover from the early IOAPIC/MPS days
> when we were talking about 4 to 8 non-legacy RTEs.

Yes I agree. A lot of the IO-APIC code could probably
need some renovation.
 
> This is where the big system vector shortage problem
> should be addressed.

If we go to per CPU IDTs it will be much less pressing, but
still a good idea.

-Andi

P.S.: There seems to be a lot of confusion about all this.
Maybe it would make sense to do a write up defining all the terms
and stick it into Documentation/* ? 
