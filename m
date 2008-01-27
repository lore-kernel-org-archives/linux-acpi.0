From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 0/5] WMI
Date: Sun, 27 Jan 2008 20:49:21 +0000
Message-ID: <200801272049.22318.carlos@strangeworlds.co.uk>
References: <20080118235818.3123.95800.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from host-240-152.cust.aaawireless.net ([216.23.240.152]:45467 "EHLO
	mail.slackadelic.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754452AbYA0Ut0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Jan 2008 15:49:26 -0500
In-Reply-To: <20080118235818.3123.95800.stgit@pacifica>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Alexey Starikovskiy <aystarik@gmail.com>

On Friday 18 January 2008 23:58:18 Carlos Corbacho wrote:
> ANYWR - Another New Year WMI release
>
> Len,
>
> Can you please review at least the first two patches in this series, as I
> would still really like to try and get them into 2.6.25.

Len,

I have a small update for acer-wmi to add another DMI entry queued up - before 
I submit that and re-submit the whole WMI series, is there anything else I 
can do that would help expedite the review of WMI?

I accept that at this stage, acceptance into 2.6.25 is unlikely - but I don't 
think aiming for 2.6.26 at least is entirely unrealistic (I've been posting 
the WMI patches for 'upstream review' since the end of October now, and 
earlier works-in-progress since the beginning of October). The sooner this 
gets looked at, the sooner I can get any problems addressed and this can be 
in a mergeable state for 2.6.26 (and can hopefully sit in -mm for a bit as 
well that way).

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
