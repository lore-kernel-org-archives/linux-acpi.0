From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH: 000/002] Catch notification of memory add event of ACPI
 via container driver.
Date: Fri, 24 Mar 2006 08:38:00 +0900
Message-ID: <20060324083800.d1bb156f.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060323221810.8A0B.Y-GOTO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:10154 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932567AbWCWXhV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Mar 2006 18:37:21 -0500
In-Reply-To: <20060323221810.8A0B.Y-GOTO@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: akpm@osdl.org, y-goto@jp.fujitsu.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, len.brown@intel.com

On Thu, 23 Mar 2006 22:41:05 +0900
Yasunori Goto <y-goto@jp.fujitsu.com> wrote:

>These 2 patches are to catch notification of new node's hot-add event via ACPI.



One more thing, this patch works for the case that memory device "PNP0C80" appears
in container device"ACPI0004,PNP0A05,PNP0A06". In this case, ACPI's notify just comes
to container device (not to memory device in it). This patch is necessary to deal with it.

I heared  that some of firmwares (will?) use this kind of design, memory in a container,
even if it's not NUMA.

-- Kame.

