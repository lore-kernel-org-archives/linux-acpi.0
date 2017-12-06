From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph@boehmwalder.at>
Subject: Re: [PATCH 2/3] battery: Add the ThinkPad "Not Charging" quirk
Date: Thu, 7 Dec 2017 00:55:34 +0100
Message-ID: <20171206235534.5d7vm24u3ofegfwn@localhost>
References: <20171206225301.GA3837@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zimbra.linuxprofi.at ([93.83.54.199]:48716 "EHLO
        zimbra.linuxprofi.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbdLFXze (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Dec 2017 18:55:34 -0500
Content-Disposition: inline
In-Reply-To: <20171206225301.GA3837@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ognjen Galic <smclt30p@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org

On Wed, Dec 06, 2017 at 11:53:01PM +0100, Ognjen Galic wrote:
> The EC/ACPI firmware on Lenovo ThinkPads used to report a status
> of "Unknown" when the battery is between the charge start and
> charge stop thresholds. On Windows, it reports "Not Charging"
> so the quirk has been added to also report correctly.
>
> Now the "status" attribute returns "Not Charging" when the
> battery on ThinkPads is not physicaly charging.

Hi again,

I just tried this patch(set) and it still seems to report "Unknown".  We
can also discuss this on the IRC you mentioned earlier if you want, as I
said I'm open for testing.

--
Regards,
Christoph
