From: Kyle McMartin <kmcmartin@redhat.com>
Subject: Re: [PATCH 35/42] ACPI battery: fribble sysfs files from a resume
 notifier
Date: Wed, 23 Mar 2011 09:40:04 -0400
Message-ID: <20110323134004.GL25396@ihatethathostname.lab.bos.redhat.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
 <25be5821521640eb00b7eb219ffe59664510d073.1300862481.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53196 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755154Ab1CWNkc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Mar 2011 09:40:32 -0400
Content-Disposition: inline
In-Reply-To: <25be5821521640eb00b7eb219ffe59664510d073.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Wed, Mar 23, 2011 at 02:42:48AM -0400, Len Brown wrote:
> With this in place, I haven't noticed the units going nutty on my
> gnome-power-manager across a dozen suspends or so...
> 
> Signed-off-by: Kyle McMartin <kyle@redhat.com>
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Len Brown <len.brown@intel.com>

Oops, I probably should have added a Cc: stable@kernel.org for this. :/

--Kyle
