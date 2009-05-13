From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC] why do we need run disk sync before entering
 S3
Date: Tue, 12 May 2009 22:01:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0905122155550.7989-100000@netrider.rowland.org>
References: <1242177651.16529.26.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:46601 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751371AbZEMCBJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 May 2009 22:01:09 -0400
In-Reply-To: <1242177651.16529.26.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Wed, 13 May 2009, Zhang Rui wrote:

> Hi, all,
> 
> I did some S3 tests on an eeepc901, the total suspend time(from issue
> the suspend command to power down) is about 2.5s~3s.
> something interesting is that kernel runs disk sync before entering S3
> state, and this takes about 0.7~1.2s.
> my question is that, why do we need this for s2ram?
> can we remove this and run sys_sync for S4 only?

At the risk of sounding foolish, I'd guess that a system in S3 (or more
generally, suspend-to-RAM) is a lot more at risk of losing power or
failing to restore than a normally running system.  (A normally running
system is trivially not at risk of failing to restore!)  Consequently
it makes sense to flush the I/O buffers before entering this state, to
minimize the potential for loss of data.

When you think about it, a system in S4 is actually _less_ likely to 
run into trouble than one in S3, since it can't fail because of loss of 
power.  So if anything, we should remove the disk sync from hibernation 
and leave it in system suspend.

Alan Stern

