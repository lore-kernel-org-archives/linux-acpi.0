From: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Subject: Re: [PATCH 09/16] platform/x86: wmi: Instantiate all devices before
 adding them
Date: Thu, 1 Jun 2017 22:43:39 +0200
Message-ID: <20170601204339.GA1842@kmp-mobile.hq.kempniu.pl>
References: <cover.1495862272.git.dvhart@infradead.org>
 <a25645295f6aaf80407ff851baa14ec039c885aa.1495862272.git.dvhart@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33026 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdFAUnn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2017 16:43:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id b84so14218596wmh.0
        for <linux-acpi@vger.kernel.org>; Thu, 01 Jun 2017 13:43:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <a25645295f6aaf80407ff851baa14ec039c885aa.1495862272.git.dvhart@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Mario Limonciello <mario_limonciello@dell.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

I know I have probably started sounding like a broken record by now, but
I still have not seen any response (apart from the typos getting fixed)
to my comments on this patch which I posted in January 2016 [1].

None of the issues I found back then are really critical, but I did
point out a potential memory leak (granted, an unlikely one), so it
might be a good idea to at least take a second look before merging.

[1] https://www.spinics.net/lists/platform-driver-x86/msg08201.html

-- 
Best regards,
Michał Kępień
