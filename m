From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/3 v5] battery: Add the battery hooking API
Date: Tue, 12 Dec 2017 20:38:45 +0200
Message-ID: <CAHp75Vd-fGXMFMmODsf=4XCNQb4fRNB=CaZLey0qCfk1rrifWg@mail.gmail.com>
References: <20171210180131.GA1865@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:45518 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752379AbdLLSiq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Dec 2017 13:38:46 -0500
In-Reply-To: <20171210180131.GA1865@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ognjen Galic <smclt30p@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net

On Sun, Dec 10, 2017 at 8:01 PM, Ognjen Galic <smclt30p@gmail.com> wrote:

>  drivers/acpi/battery.h |  11 ----
>  include/acpi/battery.h |  21 ++++++++

Just a hint to the future: use -M -C (with perhaps some non-default
thresholds in some cases) to avoid above.


-- 
With Best Regards,
Andy Shevchenko
