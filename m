From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: Unwanted delayed execution of _Qxx EC methods
Date: Fri, 06 Mar 2015 13:42:21 +0100
Message-ID: <2027555.2ZAulqKXKg@xps13>
References: <1734806.SfTNVcaUUz@xps13> <CAC=cRTM=F38k7m5y6OjSLaxwit_rRLeRSHO8W-BzgD9bLUzztw@mail.gmail.com> <1AE640813FDE7649BE1B193DEA596E88026D986B@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:39013 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755575AbbCFMmY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Mar 2015 07:42:24 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88026D986B@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mario Limonciello <Mario_Limonciello@dell.com>

On Friday 06 March 2015 01:52:48 Zheng, Lv wrote:
> Hi, Gabriele
> 
> 
> I couldn't find this in my mail box, but saw it in the spinics.net.
> 
> For EC query, there is no spec definitions around its behavior.
> Some EC firmware will have events queued (like edge triggering) while the others will keeps on reporting events when a condition is set (like level triggering).
> I think this case is a "level triggering like events", it is very useful for us to learn.
> We should be able to handle both firmware variations using one software architecture.
> Supporting this becomes possible now because we are able to switch EC handling between polling/interrupt modes using enhanced ACPICA GPE APIs.
> So we are able to switch EC into polling mode when SCI_EVT is detected and blocks further events and handles all transactions in polling mode.
> After completing the _Qxx evaluation we then can switch back to the interrupt mode and unblock further events.
> 
> Could you please open a kernel Bugzilla entry at: https://bugzilla.kernel.org
> So we can discuss there with more test cases considered.
> 
> Thanks and best regards
> -Lv

Hi,

thanks for the explanation.

I opened a bug report as requested, here the address:
https://bugzilla.kernel.org/show_bug.cgi?id=94411

Regards,
Gabriele

