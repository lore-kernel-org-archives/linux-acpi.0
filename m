From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 13/16] ACPICA: Move _PRT repair into the standard complex
 repair module
Date: Wed, 12 Jun 2013 13:52:17 -0400
Message-ID: <CAJvTdKnYif42oaWnP4MBQbi6XYg3AchJnxZPrTr1XPct=uS+6g@mail.gmail.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
	<f2c59ef61be4cf02903c633ad38592121db86419.1369274559.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:62019 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070Ab3FLRwT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jun 2013 13:52:19 -0400
Received: by mail-wg0-f42.google.com with SMTP id x12so19515wgg.1
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jun 2013 10:52:17 -0700 (PDT)
In-Reply-To: <f2c59ef61be4cf02903c633ad38592121db86419.1369274559.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

Please re-send this patch with a commit message that clarifies
whether any logical change in operation should result from this patch or not.

It looks like the answer is no, that this a clean-up of the implementation
of a AML workaround -- but I shouldn't have to read the code to figure that out,
and neither should anybody else.

Nacked-by: Len Brown <len.brown@intel.com>
