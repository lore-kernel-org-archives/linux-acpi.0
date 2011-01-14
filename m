From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 28/48] thermal: Add event notification to thermal framework
Date: Thu, 13 Jan 2011 22:35:16 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101132232130.9760@x980>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
 <4cb18728709683c91a5f6f8d5f337bfb498b089a.1294827492.git.len.brown@intel.com>
 <201101131207.01290.trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:33236 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757499Ab1ANDfW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Jan 2011 22:35:22 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEZ00J1ATYWATU4@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 13 Jan 2011 21:35:21 -0600 (CST)
In-reply-to: <201101131207.01290.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, "R.Durgadoss" <durgadoss.r@intel.com>

> A dependency from the thermal driver to CONFIG_NET should
> be avoided if possible.

Who is using CONFIG_THERMAL without CONFIG_NET today?

Frankly, I'm tempted to make ACPI (falsely) depend on NET
just to reduce the number of configs we have to test.

I completely agree with your rename patch,
the name exported shouldn't be so generic.
Durgadoss, as Thomas suggests, please update that
and the dependent driver at the same time.

thanks,
Len Brown, Intel Open Source Technology Center

