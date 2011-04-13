From: Kyle McMartin <kmcmartin@redhat.com>
Subject: Re: [PATCH 35/42] ACPI battery: fribble sysfs files from a resume
 notifier
Date: Wed, 13 Apr 2011 06:37:51 -0400
Message-ID: <20110413103750.GA8884@ihatethathostname.lab.bos.redhat.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
 <25be5821521640eb00b7eb219ffe59664510d073.1300862481.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1057 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756763Ab1DMPiZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Apr 2011 11:38:25 -0400
Content-Disposition: inline
In-Reply-To: <25be5821521640eb00b7eb219ffe59664510d073.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

Len,

Do we think this has baked enough for stable 2.6.38.3? I'd like to drop
the patch from Fedora when we pull the next stable update in.

Greg -- this is upstream commit
25be5821521640eb00b7eb219ffe59664510d073.

regards, Kyle

On Wed, Mar 23, 2011 at 02:42:48AM -0400, Len Brown wrote:
> From: Kyle McMartin <kyle@redhat.com>
> 
> Commit da8aeb92 re-poked the battery on resume, but Linus reports that
> it broke his eee and partially reverted it in b23fffd7. Unfortunately
> this also results in my x201s giving crack values until the sysfs files
> are poked again. In the revert message, it was suggested that we poke it
> from a PM notifier, so let's do that.
> 
> With this in place, I haven't noticed the units going nutty on my
> gnome-power-manager across a dozen suspends or so...
> 
> Signed-off-by: Kyle McMartin <kyle@redhat.com>
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Len Brown <len.brown@intel.com>

