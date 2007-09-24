From: Andrew Morton <akpm@linux-foundation.org>
Subject: cpuidle
Date: Sun, 23 Sep 2007 17:57:06 -0700
Message-ID: <20070923175706.74afa5bf.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43249 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754099AbXIXA6Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Sep 2007 20:58:24 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>


Whaaaaa?  Seems that the cpuidle patches all got dropped, but the x86_64
dynticks patches were fairly heavily dependent upon them.  (iow: I'm
screwed).

I can go back to the old version of git-acpi and retain the dynticks
patches or I can drop the dynticks patches.  (Either way I remain screwed).

What's happening?
