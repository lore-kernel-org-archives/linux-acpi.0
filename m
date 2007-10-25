From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 0/5] Detect hwmon and i2c bus drivers interfering with
 ACPI Operation Region resources
Date: Thu, 25 Oct 2007 15:51:35 +0200
Message-ID: <20071025155135.019baca3@hyperion.delvare>
References: <1193236319.4590.225.camel@queen.suse.de>
	<20071024205723.458fab97.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:52853 "EHLO
	kraid.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754621AbXJYNvh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Oct 2007 09:51:37 -0400
In-Reply-To: <20071024205723.458fab97.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Wed, 24 Oct 2007 20:57:23 -0700, Andrew Morton wrote:
> On Wed, 24 Oct 2007 16:31:59 +0200 Thomas Renninger <trenn@suse.de> wrote:
> 
> > it seems Len's test tree and Linus tree diverged a bit, at least with
> > this patch set things do not apply cleanly.
> > 
> > Therefore I post these for discussion whether and in which kernel tree
> > they should end up before doing work for nothing.
> > If they are still a candidate for 2.6.24 (rather unintrusive), pls tell
> > me whether and when I should base them against Len's test/release branch
> > or whatever other tree.
> > If not, it would be great if they can be included into the -mm tree and
> > I can rebase them against this one.
> 
> I staged the three acpi patches against Len's tree and I staged the hwmon
> patch against Mark's tree and I staged the I2C patch against Jean's tree.
> 
> This means that if/when the ACPI patches have gone me->Len->Linus, I can
> send the I2C patch to Jean and the hwmon patch to Mark and we're all good.

Thanks for picking these patches, having them in -mm for some time is
exactly what we need. Let's see how many systems are affected by the
resource conflicts and how we can fix them

-- 
Jean Delvare
