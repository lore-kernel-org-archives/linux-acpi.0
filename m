From: Andi Kleen <ak@suse.de>
Subject: Re: Freeing ACPI tables after parsing
Date: Mon, 21 Aug 2006 22:03:51 +0200
Message-ID: <20060821220351.233815d0.ak@suse.de>
References: <200608211146.53379.ak@suse.de>
	<44E9E68D.2020505@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:34708 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750913AbWHUUED (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Aug 2006 16:04:03 -0400
In-Reply-To: <44E9E68D.2020505@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com, Natalie.Protasevich@unisys.com

On Mon, 21 Aug 2006 20:59:57 +0400
Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com> wrote:

> Andy,
> We are about to release new table code, which will not allocate memory for any tables,
> but just map them from their physical location, does it solve the problem you describe?

No. In fact it makes it worse. My point was to allocate memory for the tables,
copy them and then free the physical location after it is read.

-Andi
