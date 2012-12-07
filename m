From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ACPI: add Haswell LPSS devices to
 acpi_platform_device_ids list
Date: Fri, 7 Dec 2012 11:01:26 +0000
Message-ID: <20121207110126.53cd97e7@pyramind.ukuu.org.uk>
References: <1354874882-1162-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:56290 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109Ab2LGK4J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Dec 2012 05:56:09 -0500
In-Reply-To: <1354874882-1162-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

On Fri,  7 Dec 2012 12:08:02 +0200
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> All devices behind Haswell LPSS (Low Power Subsystem) should be represented
> as platform devices 

What about the bus heirarchy ? What about making sure they appear in the
PCI resource heirarchy so we don't mash them up if we reassign or
allocate other resources on the bus ?

Alan
