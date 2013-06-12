From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 07/16] ACPICA: New: Portable acpidump utility (get system
 ACPI tables)
Date: Wed, 12 Jun 2013 13:07:50 -0400
Message-ID: <CAJvTdKkx6hfT8M3SOoMYmrwcC0ODGkGYvVaynS6KNXKPoKJFEg@mail.gmail.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
	<de987440373d946b6c672cd796aedc93f9390059.1369274559.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:41457 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757410Ab3FLRHv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jun 2013 13:07:51 -0400
Received: by mail-wi0-f180.google.com with SMTP id c10so703568wiw.7
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jun 2013 10:07:50 -0700 (PDT)
In-Reply-To: <de987440373d946b6c672cd796aedc93f9390059.1369274559.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

> This utility dumps the system ACPI tables in an ascii format
> suitable for extraction via the acpixtract utility.

This commit message does not match the contents of the patch,
or explain how this patch is related (or not) to the acpidump utility
already in the kernel tree under
tools/power/acpi/acpidump/

Naked-by: Len Brown <len.brown@intel.com>
