From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v11 1/1] Mailbox: Add support for Platform Communication Channel
Date: Tue, 18 Nov 2014 14:39:06 +0100
Message-ID: <1946980.r78SuCoQbW@wuerfel>
References: <1415840378-1973-1-git-send-email-ashwin.chaugule@linaro.org> <1415840378-1973-2-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:58745 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511AbaKRNjY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Nov 2014 08:39:24 -0500
In-Reply-To: <1415840378-1973-2-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: jaswinder.singh@linaro.org, broonie@kernel.org, lv.zheng@intel.com, linaro-acpi@lists.linaro.org, patches@linaro.org, linux-acpi@vger.kernel.org, rjw@rjwysocki.net

On Wednesday 12 November 2014 19:59:38 Ashwin Chaugule wrote:
> ACPI 5.0+ spec defines a generic mode of communication
> between the OS and a platform such as the BMC. This medium
> (PCC) is typically used by CPPC (ACPI CPU Performance management),
> RAS (ACPI reliability protocol) and MPST (ACPI Memory power
> states).
> 
> This patch adds PCC support as a Mailbox Controller. As of
> ACPI v5.1 there is no provision for clients to lookup mailbox
> controllers in a way that Linux expects. e.g. in DT the clients
> can list the mailboxes they can associate with in the DT binding
> and then provide a unique index to lookup a channel within a mailbox.
> Since the ACPI spec doesn't have anything similar, we introduce a
> mailbox controller specific API so that when the client calls it,
> we know to lookup in the context of a specific controller. This
> also helps in keeping a consistent interface across DT and ACPI
> for such drivers.
> 
> This patch implements basic PCC support using the ACPI v5.1
> structures. IRQ mode support will be provided as follow up patches.
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> 

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
