From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 11/16] ACPICA: Clear events initialized flag upon event
 component termination
Date: Wed, 12 Jun 2013 13:47:48 -0400
Message-ID: <CAJvTdKkuQfOYZ49h4psmE7VJKVw3XWswSuLjL2m+hovRY6OSkw@mail.gmail.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
	<17a5d121655fce6e2438b10adaf8271dd05b454c.1369274559.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:65393 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757631Ab3FLRrt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jun 2013 13:47:49 -0400
Received: by mail-wg0-f52.google.com with SMTP id b12so776135wgh.19
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jun 2013 10:47:48 -0700 (PDT)
In-Reply-To: <17a5d121655fce6e2438b10adaf8271dd05b454c.1369274559.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>

On Fri, Jun 7, 2013 at 9:00 PM, Lv Zheng <lv.zheng@intel.com> wrote:
> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>
> Clear this flag to allow clean startup and even double termination.
> ACPICA BZ 1013. Tomasz Nowicki <tomasz.nowicki@linaro.org>

The patch looks logically correct, but I'm wondering what use-case
made it necessary.  Do you have a system where you disable ACPI
and then disable ACPI again?

BTW. it looks like we don't check for this flag being FALSE
when we initialize, so I suppose if you had the case where
you enable, disable, and then re-enable ACPI mode, that
would already work -- though I don't know if anybody
has ever done that.

Reviewed-by: Len Brown <len.brown@intel.com>
