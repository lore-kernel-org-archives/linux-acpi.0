From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v4 0/9] PM / Domains: Generic OF-based support
Date: Tue, 09 Sep 2014 13:43:10 +0200
Message-ID: <540EE7CE.9000400@gmail.com>
References: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org> <1410262570-22785-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:58771 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585AbaIILnO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Sep 2014 07:43:14 -0400
In-Reply-To: <1410262570-22785-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>

Hi Ulf,

On 09.09.2014 13:36, Ulf Hansson wrote:
> Changes in v4:
> 	- Rebased patch "PM / Domains: Add generic OF-based PM domain look-up" -
> 	  and updated the author and the commit message.
> 	- Adopted review comments for "PM / Domains: Add APIs to attach/detach
> 	  a PM domain for a device".
> 	- Updated author and commit message for "ARM: exynos: Move to generic
> 	  PM domain DT bindings".
> 	- Added some acks and reviewed by tags.
> 	- Started to use the "--in-reply-to" option to git-send-email. It should
> 	  provide the option to show a better diffstat per patch.
> 

I guess this series doesn't need more tags, but, anyway, it looks good
to me. Thanks a lot for taking care of it.

Best regards,
Tomasz
