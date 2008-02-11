From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 2/5] Provide acpi_check_{mem_}region.
Date: Mon, 11 Feb 2008 22:18:29 +0100
Message-ID: <20080211221829.7fcf749e@hyperion.delvare>
References: <1193236379.4590.229.camel@queen.suse.de>
	<20080207234002.e31563be.akpm@linux-foundation.org>
	<20080210132536.7c4d1cb1@hyperion.delvare>
	<20080211115546.87a738b1.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:3742 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751112AbYBKVSd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Feb 2008 16:18:33 -0500
In-Reply-To: <20080211115546.87a738b1.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: trenn@suse.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org, mhoffman@lightlink.com

On Mon, 11 Feb 2008 11:55:46 -0800, Andrew Morton wrote:
> On Sun, 10 Feb 2008 13:25:36 +0100 Jean Delvare wrote:
> > Andrew, both patches are
> > 
> > Acked-by: Jean Delvare <khali@linux-fr.org>
> 
> We already have Signed-off-by:you, which I figure outranks acked-by: ;)

Yeah but that wasn't the same me. That was me-developer-at-suse,
who doesn't yet have the same aura as
me-maintainer-of-i2c-and-former-maintainer-of-hwmon ;)

> > and I am totally fine with you pushing them to Linus now. But of course
> > having Mark's ack would be good too.
> 
> That would be nice.  But I'll merge them mid-week anyway unless Mark actually
> nacks them:
> 
> http://userweb.kernel.org/~akpm/mmotm/broken-out/check-for-acpi-resource-conflicts-in-hwmon-drivers.patch
> 
> http://userweb.kernel.org/~akpm/mmotm/broken-out/check-for-acpi-resource-conflicts-in-i2c-bus-drivers.patch

Yeah, sounds like a good plan, thanks for taking care.

-- 
Jean Delvare
