From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 08/16] ACPICA: Update interface to AcpiUtValidAcpiName
Date: Wed, 12 Jun 2013 13:15:16 -0400
Message-ID: <CAJvTdK=dE5-e_Fr8kQ7V+mOEDuO09E5UMDYamZgAsXdxkfMw-A@mail.gmail.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
	<7443abecbf977754957f6c8af61add225a9f09a6.1369274559.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:61689 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756612Ab3FLRPR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jun 2013 13:15:17 -0400
Received: by mail-wi0-f177.google.com with SMTP id ey16so710387wid.16
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jun 2013 10:15:16 -0700 (PDT)
In-Reply-To: <7443abecbf977754957f6c8af61add225a9f09a6.1369274559.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

I'm okay w/ the content of this patch, but the Subject: was not converted
from ACPICA syntax to Linux syntax

AcpiUtValidAcpiName() should be acpi_ut_valid_acpi_char()

Nacked-by: Len Brown <len.brown@intel.com>
