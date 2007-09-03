From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: always enable input layer, add hotkey_report_mode
Date: Mon, 3 Sep 2007 17:15:05 -0400
Message-ID: <200709031715.06269.lenb@kernel.org>
References: <1188789388345-git-send-email-hmh@hmh.eng.br> <1188789388452-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40527 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753477AbXICVL1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Sep 2007 17:11:27 -0400
In-Reply-To: <1188789388452-git-send-email-hmh@hmh.eng.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, "Michael S. Tsirkin" <mst@dev.mellanox.co.il>, Hugh Dickins <hugh@veritas.com>, Richard Hughes <hughsient@gmail.com>

Henrique,
I may be seriously jet-lagged right now,
but I'm having trouble parsing this check-in comment
and the the Documentation update, so I'm not
clear on what you're trying to do with this code.

It should basically say:

hotkeys are reported through the input layer,
and /proc/acpi/event when CONFIG_ACPI_PROC_EVENT=y

all other events are reported via netlink,
and /proc/acpi/event when CONFIG_ACPI_PROC_EVENT=y

And if you need to add a flag to eliminate duplicate
reporting, so be it.

But I'm totally confused why there is any mention of netlink
in any of this text -- for if this patch is really
specific to hotkey events, then no version of any
kernel should send hotkey events via netlink,
and no version of HAL should listen for hotkey
events on netlink.

thanks,
-Len

ps.
For me to apply a patch post -rc5,
it really has to be a bug fix -- preferably fixing a regression.
ie. "revert new 2.6.23 CONFIG_THINKPAD_ACPI_INPUT_ENABLED option
because it would create a legacy we don't want to support"
would be a suitable synopsis -- "always enable input layer"
sort of gives the impression that this is a new feature, not a fix...

pps. 
On Sunday 02 September 2007 23:16, Henrique de Moraes Holschuh wrote:
> Now that ACPICA can send events over netlink, we can use a different

Note that ACPICA doesn't know anything about how events are sent
to user-space -- is it Linux specific ACPI code that does this.
