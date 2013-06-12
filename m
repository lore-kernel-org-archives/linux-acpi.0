From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 06/16] ACPICA: Do not use extended sleep registers unless
 HW-reduced bit is set
Date: Wed, 12 Jun 2013 13:11:42 -0400
Message-ID: <CAJvTdKm3VUbW89sO9qSmJBj-XcZa2=UHjm6TsH83KXH2Z-AAeg@mail.gmail.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
	<bc6233f5a24ca6175c1b3414c9662d6b4f63db25.1369274559.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:43798 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757637Ab3FLRLn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jun 2013 13:11:43 -0400
Received: by mail-wi0-f179.google.com with SMTP id hj3so706329wib.12
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jun 2013 10:11:42 -0700 (PDT)
In-Reply-To: <bc6233f5a24ca6175c1b3414c9662d6b4f63db25.1369274559.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

This commit message should state when this regression started in Linux,
so that people reading the messages know how far back to port the fix.

Likely this patch should also be marked for -stable

until then...

Nacked-by: Len Brown <len.brown@intel.com>
