From: Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: Re: [RFC:PATCH(003/003)] Memory add to onlined node. (ver. 2) (For x86_64)
Date: Thu, 09 Feb 2006 18:50:35 +0900
Message-ID: <20060209164036.6CFC.Y-GOTO@jp.fujitsu.com>
References: <20060209153803.6CF4.Y-GOTO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:54216 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030345AbWBIJwE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Feb 2006 04:52:04 -0500
In-Reply-To: <20060209153803.6CF4.Y-GOTO@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>, Andi Kleen <ak@suse.de>
Cc: "Brown, Len" <len.brown@intel.com>, naveen.b.s@intel.com, Bjorn Helgaas <bjorn.helgaas@hp.com>, Linux Kernel ML <linux-kernel@vger.kernel.org>, ACPI-ML <linux-acpi@vger.kernel.org>, x86-64 Discuss <discuss@x86-64.org>, Linux Hotplug Memory Support <lhms-devel@lists.sourceforge.net>


BTW, I have 2 question about x86_64's memory hot-add.

Q1) 
>  int add_memory(u64 start, u64 size)
>  {
> -	struct pglist_data *pgdat = NODE_DATA(0);
> -	struct zone *zone = pgdat->node_zones + MAX_NR_ZONES-2;

Current code adds memory to ZONE_NORMAL like this.
But, ZONE_DMA32 is available on 2.6.15. So, I'm afraid there are
2 types trouble.

  a) When new memory is added to < 4GB, this should be added to 
     Zone_DMA32.
     Are there any real machine which allow to add memory under
     4GB?
  b) If machine boots up with under 4GB memory, and new memory 
     is added to over 4GB, then kernel might panic due to Zone Normal's
     initialization is imcomplete.
  
Q2) 
  Are there any real machine which can add memory with NUMA feature?
  Or will be there?
  In my patch, I assume that DSDT is defined well for NUMA by firmware.
  (Container device, Memory device...). 
  But, if firmware doesn't define it, my patch is nonsense..
  (Oh, I'm silly.....)


-- 
Yasunori Goto 


