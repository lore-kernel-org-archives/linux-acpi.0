From: Henrique de Moraes Holschuh <hmh@debian.org>
Subject: Re: ACPI 20060623 patches do not apply cleanly to 2.6.17
Date: Wed, 5 Jul 2006 15:25:37 -0300
Message-ID: <20060705182537.GE8452@khazad-dum.debian.net>
References: <CFF307C98FEABE47A452B27C06B85BB6E59120@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:26038 "EHLO
	out3.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S964973AbWGESZm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 5 Jul 2006 14:25:42 -0400
Content-Disposition: inline
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6E59120@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

On Wed, 05 Jul 2006, Brown, Len wrote:
> We asked Linus to change the name in the Makefile during this period,
> but he declined.  I'm open to suggestions.

A simple README.txt in the release/ directory which explains this would be
enough, I suppose.  Renaming these patches to -2.6.17-git would also give us
the hint, but that might not be desireable since the Linus tree it applies
to is still called 2.6.17.

> But in any case, these patches are not really for the purpose of
> "gee, I'm running old rlease X, so lets look for the latest patch
> that is named X-acpi".  These patches are snapshots of the release
> and test patches vs. Linus tree of that name on the date the patch
> was published.

I see.   I wanted the patches for bug reporting.  I am right now at least
testing every bug I find that is ACPI related with stock 2.6.17, and
2.6.17+20060608 so that I can provide information on whether a bug was fixed
in 20060608 or not when reporting it to bugzilla.

Given the ammount of trouble debugging ACPI and S3 suspend is (especially
when the bug is subtly hosing the running kernel instead of making it go up
in flames with a noticeable bang), I am not really too fond of the idea of
trying to run something that isn't even a -rc kernel yet... we shall see.

Thanks for the quick reply.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
