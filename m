From: Len Brown <lenb@kernel.org>
Subject: Re: git-acpi breaks resume-from-ram on the Vaio
Date: Tue, 18 Sep 2007 15:58:18 -0400
Message-ID: <200709181558.19063.lenb@kernel.org>
References: <20070917211213.8e0372d6.akpm@linux-foundation.org> <200709181121.41368.lenb@kernel.org> <20070918100718.3d510356.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37881 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755385AbXIRT7I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Sep 2007 15:59:08 -0400
In-Reply-To: <20070918100718.3d510356.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Tuesday 18 September 2007 13:07, Andrew Morton wrote:

> This breakage in git-acpi is new, I think.  Four or five days ago, git-acpi
> _fixed_ suspend/resume on Linus's tree.  Now it breaks it.
> 
> But I don't think there have been changes in got-acpi since then, so
> perhaps the breakage is due to interaction with Thomas's recent merge.

hmmm, maybe.

Perhaps if you are including sony-laptop, you can try excluding it --
since these reverse engineered things are always fraught with peril....

I think the next thing to test is to revert cpuidle --
let me make sure that my cpuidle branch produces a patch
that will revert cleanly...

-Len
