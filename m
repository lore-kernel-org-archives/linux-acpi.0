From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [RFC]cpuidle: disable menu governor if nohz is disabled
Date: Wed, 31 Aug 2011 12:50:24 +0800
Message-ID: <1314766224.29510.61.camel@sli10-conroe>
References: <1314755767.29510.57.camel@sli10-conroe>
	 <20110830193555.5f832351@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:62232 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366Ab1HaEsL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 31 Aug 2011 00:48:11 -0400
In-Reply-To: <20110830193555.5f832351@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Len Brown <lenb@kernel.org>, "Li, Aubrey" <aubrey.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Wed, 2011-08-31 at 10:35 +0800, Arjan van de Ven wrote:
> On Wed, 31 Aug 2011 09:56:07 +0800
> Shaohua Li <shaohua.li@intel.com> wrote:
> 
> > Lenb,
> > Aubrey is asking me to fix the issue. So either we delete disable nohz
> > code or fix cpuidle. if you want to fix cpuidle, here it is.
> > 
> > Thanks,
> > SHaohua
> > 
> > Subject: cpuidle: disable menu governor if nohz is disabled
> > 
> > Aubrey is asking why nohz disables C-state. nohz has no dependency
> > with idle, but menu governor does. If nohz is disabled, using menu
> > governor is pointless, because we never get correct sleep length, so
> > let's use ladder governor just like nohz isn't compiled in.
> > 
> 
> 
> I would prefer to not allow nohz.......
is there any risk to do this? maybe lenb can answer why previous attempt
to do this failed.


