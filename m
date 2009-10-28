From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: Please review power management abstract for LF End User Summit
Date: Wed, 28 Oct 2009 10:06:25 -0700
Message-ID: <20091028100625.015283f9.rdunlap@xenotime.net>
References: <E87738D94A6AD54789B5B8D1BAEB06CC6EED79B299@azsmsx503.amr.corp.intel.com>
	<2E9E6F5F5978EF44A8590E339E888CF90144294DEC@irsmsx503.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([72.52.64.118]:60588 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752316AbZJ1RKp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Oct 2009 13:10:45 -0400
Received: from chimera.site ([96.253.169.185]) by xenotime.net for <linux-acpi@vger.kernel.org>; Wed, 28 Oct 2009 10:10:45 -0700
In-Reply-To: <2E9E6F5F5978EF44A8590E339E888CF90144294DEC@irsmsx503.ger.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kleen, Andi" <andi.kleen@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, "Mallick, Asit K" <asit.k.mallick@intel.com>, "'linux-power-mgmt@linux.intel.com'" <linux-power-mgmt@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, 28 Oct 2009 17:07:14 +0000 Kleen, Andi wrote:

> I would start with a power break down on a typical server.
> 
> Also at least mention things like power saving by not enabling ethernet
> links.

and avoid ipmi (usually polling instead of interrupt-driven)
unless it is actively being used.

---
~Randy
