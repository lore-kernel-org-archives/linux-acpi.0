From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 07/14] ACPICA: Add support for host-installed SCI handlers.
Date: Mon, 16 Sep 2013 20:48:01 -0400
Message-ID: <CAJvTdKm2bpvofU8tiZGBFjY7cKn0vQgC==3K=QgPXwDnE14SjA@mail.gmail.com>
References: <cover.1377844863.git.lv.zheng@intel.com>
	<685cb618c64dcf124eb49058472299d3da3d1894.1377844863.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36870 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195Ab3IQAsC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Sep 2013 20:48:02 -0400
Received: by mail-wi0-f182.google.com with SMTP id ez12so4247375wid.9
        for <linux-acpi@vger.kernel.org>; Mon, 16 Sep 2013 17:48:01 -0700 (PDT)
In-Reply-To: <685cb618c64dcf124eb49058472299d3da3d1894.1377844863.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Thu, Sep 12, 2013 at 4:55 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> This change adds support to allow hosts to install System Control
> Interrupt handlers. Certain ACPI functionality requires the host
> to handle raw SCIs. For example, the "SCI Doorbell" that is defined
> for memory power state support requires the host device driver to
> handle SCIs to examine if the doorbell has been activated. Multiple
> SCI handlers can be installed to allow for future expansion.
> Debugger support is included.
> Lv Zheng, Bob Moore. ACPICA BZ 1032.
>
> Buglink: http://bugs.acpica.org/show_bug.cgi?id=1032
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Signed-off-by: Bob Moore <robert.moore@intel.com>


The bug report references PCC -- is that _PCC events, or Processor
Clocking Control?
We think we support both of those before this patch -- so how can PCC
require this change?

thanks,
-Len
