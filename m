From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.21
Date: Sat, 10 Feb 2007 10:27:14 +0200
Message-ID: <200702101027.25372.ismail@pardus.org.tr>
References: <200702071418.51058.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.uludag.org.tr ([193.140.100.220]:59288 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753023AbXBJI1k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 10 Feb 2007 03:27:40 -0500
In-Reply-To: <200702071418.51058.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, tony.luck@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, "Accardi, Kristen" <kristen.c.accardi@intel.com>

On Wednesday 07 February 2007 21:18:50 Len Brown wrote:
> Hi Linus,
>
> please pull from:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git
> release
>
> ACPICA Core version 2070126 simplifies the ACPI table manager
> code by consolidating multiple table definitions into one.
> It also saves memory by mapping the tables where the BIOS provides them
> rather than copying them into the kernel.

This breaks kpowersave, now it always says laptop is plugged in and does not 
show any battery status. Any /proc changes in this release?

Regards,
ismail
