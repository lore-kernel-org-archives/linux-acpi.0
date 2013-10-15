From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 7/8] ACPI, APEI, CPER: Cleanup CPER memory error output
 format
Date: Tue, 15 Oct 2013 12:13:49 +0200
Message-ID: <20131015101349.GB7908@pd.tnic>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
 <1381473166-29303-8-git-send-email-gong.chen@linux.intel.com>
 <20131011160208.GL5925@pd.tnic>
 <20131014045500.GC12189@gchen.bj.intel.com>
 <20131014103616.GE4009@pd.tnic>
 <CA+8MBbJ9P1GVf3SCh7LMY_LH+pxQg3GWkxKMzni1b1Wyx1o8NQ@mail.gmail.com>
 <20131014184717.GK4009@pd.tnic>
 <CA+8MBbKDhFvRmJv1csMp5At8WfvHvSsDBbCKvOfQhVdgmnwBWg@mail.gmail.com>
 <20131014215047.GL4009@pd.tnic>
 <20131015091835.GA21097@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:51108 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753362Ab3JOKOD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Oct 2013 06:14:03 -0400
Content-Disposition: inline
In-Reply-To: <20131015091835.GA21097@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>
Cc: Tony Luck <tony.luck@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Lance Ortiz <lance.ortiz@hp.com>, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

On Tue, Oct 15, 2013 at 05:18:35AM -0400, Chen Gong wrote:
> Looks fine to me. But a little bit out of current patch series. How
> about adding such interfaces after this patch series is merged?

Ok.

> And from your words, it looks like you prefer to reserve all current
> fields to avoid breaking user space things. IOW, drop patch [7/8]

Well, I was simply wondering whether something is using those. And since
we don't know, apparently, we probably should keep them for now.

> and use another patch with above idea to get the same purpose. This
> is what you want, Boris?

Yeah, let's not break userspace. :-)

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
