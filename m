From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 05/16] ACPICA: Split table print utilities to a new a
 separate file
Date: Wed, 12 Jun 2013 13:03:43 -0400
Message-ID: <CAJvTdK=R+rsCX_LBUNenDO4rd1JN+FGfo9BGwf9Rt2ppovaW2A@mail.gmail.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
	<98af6637d808d7c3072853b37f4502e5cf56000e.1369274559.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:47570 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755538Ab3FLRDo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jun 2013 13:03:44 -0400
Received: by mail-wg0-f43.google.com with SMTP id x12so7025381wgg.34
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jun 2013 10:03:43 -0700 (PDT)
In-Reply-To: <98af6637d808d7c3072853b37f4502e5cf56000e.1369274559.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Fri, Jun 7, 2013 at 8:59 PM, Lv Zheng <lv.zheng@intel.com> wrote:
> From: Bob Moore <robert.moore@intel.com>
>
> Improves configurability of ACPICA.


Just code movement, no logic changes or even any code changes, yes?
If so, please state that in the commit message.

thanks,
Len Brown, Intel Open Source Technology Center
