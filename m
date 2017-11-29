From: Len Brown <lenb@kernel.org>
Subject: Re: Dell XPS13 9360 - 1,000ms acpi_pm_finish()
Date: Wed, 29 Nov 2017 11:11:17 -0500
Message-ID: <CAJvTdKmxRbpZ=xexXEOgs_JpvFdRdstZMuPQ5zWG9y36tEb62g@mail.gmail.com>
References: <CAJvTdK=gJk3N+75G97QpXiTnw9FDJPQiuR66sGgyc6e_zcesHQ@mail.gmail.com>
 <CAJZ5v0iii=ZSnz8NwiA_TN0Uk0=dUcw2CH_0VO+_UsipO3i+3w@mail.gmail.com> <744357E9AAD1214791ACBA4B0B9092636BE57FFD@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33886 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753153AbdK2QLS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Nov 2017 11:11:18 -0500
Received: by mail-qk0-f181.google.com with SMTP id d66so5071194qkg.1
        for <linux-acpi@vger.kernel.org>; Wed, 29 Nov 2017 08:11:18 -0800 (PST)
In-Reply-To: <744357E9AAD1214791ACBA4B0B9092636BE57FFD@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux acpi <linux-acpi@vger.kernel.org>

> How long does acpi_pm_finish() take in 4.12 kernel?
> It's good to know how much the reverted EC busy_polling mechanism can improve on this case.

4.12.0 acpi_pm_finish() takes on the order of 40ms (it varies somewhat),
which is about the same speed as when this hack patch is applied.

This is compared to over 1,100ms in current 4.14.
