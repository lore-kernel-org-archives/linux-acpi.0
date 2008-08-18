From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] ACPI : Avoid twice read access to EC data I/O port
Date: Mon, 18 Aug 2008 05:28:15 +0200
Message-ID: <20080818032815.GB9807@one.firstfloor.org>
References: <1219029274.3998.66.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:43715 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbYHRD0g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Aug 2008 23:26:36 -0400
Content-Disposition: inline
In-Reply-To: <1219029274.3998.66.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, lenb@kernel.org, astarikovskiy@suse.de

On Mon, Aug 18, 2008 at 11:14:34AM +0800, Zhao Yakui wrote:
> Subject: ACPI: Avoid twice read access to EC data I/O port 
> >From : Zhao Yakui <yakui.zhao@intel.com>
> 
> In current kernel when OS reads the data returned by the EC controller, the 
> EC data I/O port is accessed twice. In fact is is meaningless.
> Only once access to EC data I/O port is enough to get data returned by EC 
> controller.
> 
> Signed-off-by : Zhao Yakui <yakui.zhao@intel.com>
> Acked-by      : Alexey Starikovskiy <astarikovskiy@suse.de>

Added to test for 2.6.28 thanks.

-Andi
