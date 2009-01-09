From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 2/6] acpi: check _PSS invalidation when BIOS report _PSS
 with 0x80000000
Date: Fri, 9 Jan 2009 13:23:55 -0800
Message-ID: <20090109132355.b3a3c4dc.akpm@linux-foundation.org>
References: <200901092017.n09KH9OP014905@imap1.linux-foundation.org>
	<alpine.LFD.2.00.0901091559120.16697@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41509 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757491AbZAIVYb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 16:24:31 -0500
In-Reply-To: <alpine.LFD.2.00.0901091559120.16697@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, youquan.song@intel.com, venkatesh.pallipadi@intel.com

On Fri, 09 Jan 2009 16:01:47 -0500 (EST)
Len Brown <lenb@kernel.org> wrote:

> I recall nacking this one some time ago.

Well please treat it as a bug report then.  "the kernel will boot 
crash when load cpufreq govenors".  Bad!

