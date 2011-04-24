From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH 35/42] ACPI battery: fribble sysfs files from a
 resume notifier
Date: Sun, 24 Apr 2011 16:55:03 -0700
Message-ID: <20110424235503.GC23014@kroah.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
 <25be5821521640eb00b7eb219ffe59664510d073.1300862481.git.len.brown@intel.com>
 <20110413103750.GA8884@ihatethathostname.lab.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:41633 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757791Ab1DYACj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 Apr 2011 20:02:39 -0400
Content-Disposition: inline
In-Reply-To: <20110413103750.GA8884@ihatethathostname.lab.bos.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kyle McMartin <kmcmartin@redhat.com>
Cc: stable@kernel.org, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Wed, Apr 13, 2011 at 06:37:51AM -0400, Kyle McMartin wrote:
> Len,
> 
> Do we think this has baked enough for stable 2.6.38.3? I'd like to drop
> the patch from Fedora when we pull the next stable update in.
> 
> Greg -- this is upstream commit
> 25be5821521640eb00b7eb219ffe59664510d073.

Ok, now queued up, thanks.

greg k-h
