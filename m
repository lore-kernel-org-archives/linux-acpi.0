From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [PATCH] ACPI: EC: do transaction from interrupt context
Date: Fri, 26 Sep 2008 12:17:45 +0100
Message-ID: <48DCC4D9.9070004@tuffmail.co.uk>
References: <20080925170030.15311.27823.stgit@thinkpad>	 <48DBCFE0.8050905@yahoo.com> <1222391199.4023.125.camel@yakui_zhao.sh.intel.com> <48DC763B.7080203@yahoo.com> <48DC7AA0.8030204@suse.de> <48DCA570.2070707@tuffmail.co.uk> <48DCBCA0.20005@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:46042 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbYIZLRu (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 26 Sep 2008 07:17:50 -0400
Received: by ey-out-2122.google.com with SMTP id 6so287713eyi.37
        for <Linux-acpi@vger.kernel.org>; Fri, 26 Sep 2008 04:17:49 -0700 (PDT)
In-Reply-To: <48DCBCA0.20005@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Zhao Yakui <yakui.zhao@intel.com>, Sitsofe Wheeler <sitsofe@yahoo.com>, LenBrown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

Alexey Starikovskiy wrote:
> Alan,
>
> Could you please uncomment DEBUG and send dmesg after application of
> the patch.
> I put the "storm detected" message under debug, so it is not visible
> in normal situation.
> I think, that interrupt storm is still detected on your machine, and
> workaround works.
>
> Regards,
> Alex.
>
Nope.  IIRC, the first version of this patch I tested uncommented DEBUG
anyway.

"dmesg|grep -i storm" doesn't show anything.

Since the entire boot log weighs 100k, I'm sending it to Alex privately.

Alan
