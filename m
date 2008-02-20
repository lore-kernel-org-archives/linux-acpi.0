From: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: 2.6.25-rc2 System no longer powers off after suspend-to-disk. Screen becomes green.
Date: Thu, 21 Feb 2008 01:37:53 +0800
Message-ID: <b6a2187b0802200937q3ff8f470k235b5d1e00eab59e@mail.gmail.com>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	 <alpine.LFD.1.00.0802200922590.7833@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:20400 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878AbYBTRhz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Feb 2008 12:37:55 -0500
Received: by wr-out-0506.google.com with SMTP id c48so2703834wra.23
        for <linux-acpi@vger.kernel.org>; Wed, 20 Feb 2008 09:37:54 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0802200922590.7833@woody.linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jesse Barnes <jesse.barnes@intel.com>, lkml <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, suspend-devel List <suspend-devel@lists.sourceforge.net>, Greg KH <gregkh@suse.de>

On Feb 21, 2008 1:28 AM, Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Try suspend-and-resume without X.

Works without those two functions.

> Also, try it on one of the more modern laptops - even *with* X.

Again, still works. Tested on Lenovo X60s.

> Basically, the kernel wants to be able to do what X does, because it means
> that when it works, it works _so_ much better than doing it in X. So
> getting it working is definitely worth it.

> That said, before you do anything else, try if suspend-to-RAM works.

Yes, still works.

> That's the primary goal for this code anyway, and if it works that gives a
> good hint.

Ok, what's next?

Thanks,
Jeff.
