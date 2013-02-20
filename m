From: "Mika Westerberg (mika.westerberg@linux.intel.com)"
	<mika.westerberg@linux.intel.com>
Subject: Re: Linux ACPI DSDT table editing tools
Date: Wed, 20 Feb 2013 11:30:59 +0200
Message-ID: <20130220093059.GP2439@intel.com>
References: <D854C92F57B1B347B57E531E78D05EAD24663596@BGSMSX102.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:9292 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757754Ab3BTJ05 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Feb 2013 04:26:57 -0500
Content-Disposition: inline
In-Reply-To: <D854C92F57B1B347B57E531E78D05EAD24663596@BGSMSX102.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, Feb 20, 2013 at 07:36:32AM +0000, Pallala, Ramakrishna wrote:
> I am looking for tools(Linux or w*****s) for editing ACPI tables.
> Can you advise me some good tools. Also I would like to know how BIOS
> engineers populate the ACPI tables? Which tools they use?

Dunno about the BIOS engineers but I use tools from acpica (acpica.org).
There is ASL (dis)assembler and other useful tools in that.

In addition there is tools/power/acpi/acpidump.c in the kernel source tree
which is extremely useful.
