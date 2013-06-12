From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 15/16] ACPICA: _CST repair: Handle null package entries
Date: Wed, 12 Jun 2013 14:00:14 -0400
Message-ID: <CAJvTdKm06aCeLvV28=TSrv5wqoapUY0vh2=ppY5p5pFW0pUKFw@mail.gmail.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
	<f941986213920b382a8f43af43caec298cd16a5a.1369274559.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:58175 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924Ab3FLSAQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jun 2013 14:00:16 -0400
Received: by mail-wg0-f47.google.com with SMTP id l18so3653626wgh.26
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jun 2013 11:00:14 -0700 (PDT)
In-Reply-To: <f941986213920b382a8f43af43caec298cd16a5a.1369274559.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Fri, Jun 7, 2013 at 9:01 PM, Lv Zheng <lv.zheng@intel.com> wrote:
> Sort package only after null/bad elements have been removed.
> Lv Zheng.


again, please explain WHY.

Every line of change to the kernel adds risk.
I see no justification in this commit message why any risk should be
added to the kernel.

Nacked-by: Len Brown <len.brown@intel.com>
