From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/5] Detect hwmon and i2c bus drivers interfering with
 ACPI Operation Region resources
Date: Wed, 24 Oct 2007 20:57:23 -0700
Message-ID: <20071024205723.458fab97.akpm@linux-foundation.org>
References: <1193236319.4590.225.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36932 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758638AbXJYD5r (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Oct 2007 23:57:47 -0400
In-Reply-To: <1193236319.4590.225.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Jean Delvare <khali@linux-fr.org>

On Wed, 24 Oct 2007 16:31:59 +0200 Thomas Renninger <trenn@suse.de> wrote:

> it seems Len's test tree and Linus tree diverged a bit, at least with
> this patch set things do not apply cleanly.
> 
> Therefore I post these for discussion whether and in which kernel tree
> they should end up before doing work for nothing.
> If they are still a candidate for 2.6.24 (rather unintrusive), pls tell
> me whether and when I should base them against Len's test/release branch
> or whatever other tree.
> If not, it would be great if they can be included into the -mm tree and
> I can rebase them against this one.

I staged the three acpi patches against Len's tree and I staged the hwmon
patch against Mark's tree and I staged the I2C patch against Jean's tree.

This means that if/when the ACPI patches have gone me->Len->Linus, I can
send the I2C patch to Jean and the hwmon patch to Mark and we're all good.

