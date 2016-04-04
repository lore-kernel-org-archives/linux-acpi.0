From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v7 5/5] serial: pl011: add console matching function
Date: Mon, 4 Apr 2016 14:08:46 -0700
Message-ID: <5702D7DE.50406@hurleysoftware.com>
References: <1459431629-27934-1-git-send-email-aleksey.makarov@linaro.org>
 <1459431629-27934-6-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35021 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbcDDVIs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Apr 2016 17:08:48 -0400
Received: by mail-pa0-f53.google.com with SMTP id td3so151040606pab.2
        for <linux-acpi@vger.kernel.org>; Mon, 04 Apr 2016 14:08:48 -0700 (PDT)
In-Reply-To: <1459431629-27934-6-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, Jiri Slaby <jslaby@suse.com>

On 03/31/2016 06:40 AM, Aleksey Makarov wrote:
> This patch adds function pl011_console_match() that implements
> method match of struct console.  It allows to match consoles against
> data specified in a string, for example taken from command line or
> compiled by ACPI SPCR table handler.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
