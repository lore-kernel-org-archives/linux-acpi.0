From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ACPI: add Haswell LPSS devices to
 acpi_platform_device_ids list
Date: Fri, 7 Dec 2012 11:29:43 +0000
Message-ID: <20121207112943.031df929@pyramind.ukuu.org.uk>
References: <1354874882-1162-1-git-send-email-mika.westerberg@linux.intel.com>
	<20121207110126.53cd97e7@pyramind.ukuu.org.uk>
	<20121207111415.GH23611@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:56329 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932732Ab2LGLYc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Dec 2012 06:24:32 -0500
In-Reply-To: <20121207111415.GH23611@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

> I'm not sure if I understand what you mean here.
> 
> We put them in hierarchy if the parent ACPI node has also a physical device
> bound to it (like PCIe root port).

Ok
