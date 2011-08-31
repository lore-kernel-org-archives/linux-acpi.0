From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC]cpuidle: disable menu governor if nohz is disabled
Date: Tue, 30 Aug 2011 19:35:55 -0700
Message-ID: <20110830193555.5f832351@infradead.org>
References: <1314755767.29510.57.camel@sli10-conroe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:48904 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754856Ab1HaCct (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Aug 2011 22:32:49 -0400
In-Reply-To: <1314755767.29510.57.camel@sli10-conroe>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Li, Aubrey" <aubrey.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Wed, 31 Aug 2011 09:56:07 +0800
Shaohua Li <shaohua.li@intel.com> wrote:

> Lenb,
> Aubrey is asking me to fix the issue. So either we delete disable nohz
> code or fix cpuidle. if you want to fix cpuidle, here it is.
> 
> Thanks,
> SHaohua
> 
> Subject: cpuidle: disable menu governor if nohz is disabled
> 
> Aubrey is asking why nohz disables C-state. nohz has no dependency
> with idle, but menu governor does. If nohz is disabled, using menu
> governor is pointless, because we never get correct sleep length, so
> let's use ladder governor just like nohz isn't compiled in.
> 


I would prefer to not allow nohz.......



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
