From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 14/16] ACPICA: Add several repairs for _CST predefined name
Date: Wed, 12 Jun 2013 13:58:59 -0400
Message-ID: <CAJvTdKk9i+qcmKhuoCzqoL_hDUgv8Y3qZrs=j=onUb46kZWZGQ@mail.gmail.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
	<b2c18e07f4c9e59179c273d051924417053cd774.1369274559.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:59558 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754886Ab3FLR7A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jun 2013 13:59:00 -0400
Received: by mail-wg0-f50.google.com with SMTP id k13so7143042wgh.17
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jun 2013 10:58:59 -0700 (PDT)
In-Reply-To: <b2c18e07f4c9e59179c273d051924417053cd774.1369274559.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Fri, Jun 7, 2013 at 9:01 PM, Lv Zheng <lv.zheng@intel.com> wrote:
> Sort list based on the C-state, remove invalid/zero entries.
> ACPICA BZ 890. Lv Zheng.

The commit message should not just say what the code does,
it should more importantly answer WHY the change was made,
and why anybody should care about the patch.

I think the answer here is that we are adding _CST sanity checking --
presumably to deal with buggy AML?

What will we see happen after this patch that we did not see before it?

Nacked-by: Len Brown <len.brown@intel.com>
