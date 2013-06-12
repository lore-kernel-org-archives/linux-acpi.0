From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 03/16] ACPICA: Standardize all switch() blocks
Date: Wed, 12 Jun 2013 11:58:43 -0400
Message-ID: <CAJvTdK=y7Zkwbkp18xo405HGKNh2uiHd0-zP5t1qHVD4eEfK=w@mail.gmail.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
	<91d82cf071b27d24ec8a43da281fc7e1c3d542a9.1369274559.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:56050 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab3FLP6p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jun 2013 11:58:45 -0400
Received: by mail-wi0-f182.google.com with SMTP id m6so635749wiv.15
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jun 2013 08:58:44 -0700 (PDT)
In-Reply-To: <91d82cf071b27d24ec8a43da281fc7e1c3d542a9.1369274559.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Chao Guan <chao.guan@intel.com>

> After many years, different formatting for switch() has crept in.
> This change makes every switch block identical. Chao Guan.
> ACPICA bugzilla 997.

So what is the new format?
Looks like a blank line after every "case", except no blank line if comment?

That would be a good thing to say in the commit message...

Also, for patches such as this, please note in the commit message
that it is white-space only (indeed, in this case looks like blank lines only)
and no functionality changes.

That would help optimize precious reviewer time,
and also make it clear to those doing a bisect who
read only the commit message and not the patch.

thanks,
Len Brown
Intel Open Source Technology Center
