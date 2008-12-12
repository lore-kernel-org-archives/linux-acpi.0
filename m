From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: rc8 didn't include patch (was Re: 2.6.28-rc7 acpi error messages)
Date: Fri, 12 Dec 2008 21:02:10 +0000
Message-ID: <20081212210210.GA28575@srcf.ucam.org>
References: <E92FAF79A8BBC642A36EEE3AA7F152D82A17319337@GVW1089EXB.americas.hpqcorp.net> <alpine.LFD.2.00.0812120137440.27968@localhost.localdomain> <E92FAF79A8BBC642A36EEE3AA7F152D82A17319841@GVW1089EXB.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:60750 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990AbYLLVCU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Dec 2008 16:02:20 -0500
Content-Disposition: inline
In-Reply-To: <E92FAF79A8BBC642A36EEE3AA7F152D82A17319841@GVW1089EXB.americas.hpqcorp.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Koornstra, Reinoud" <koornstra@hp.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, Dec 12, 2008 at 07:22:47PM +0000, Koornstra, Reinoud wrote:
> What can I do to help out in this?
> I could install windows on this machine as well, but I guess you'd be more interested in how this is supported under windows and just seeing that it's supported well under windows doesn't give the info that's needed.
> Since it's HP hardware, HP must have provided detailed specs to MS to be able to do this well, that is ......
> IF it's being supported well.

We need to know the precise behaviour of Windows in this case. It's 
clearly using the 32-bit values by default, but we are currently unsure 
whether it's taking them from the FADT pointed to by the RSDT or the 
XSDT. My patch assumes the latter. I suspect that this is better than 
Linux's current behaviour and so I think we should push it anyway 
(though perhaps not until the 2.6.29 timeframe), but confirmation as to 
its correctness would be helpful.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
