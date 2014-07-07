From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [UPDATE PATCH v2 0/6] ACPI/EC: Critical race fixes.
Date: Mon, 07 Jul 2014 13:18:04 +0200
Message-ID: <39044838.0k25m70bcR@vostro.rjw.lan>
References: <cover.1402792240.git.lv.zheng@intel.com> <cover.1404700569.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1404700569.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Monday, July 07, 2014 11:09:49 AM Lv Zheng wrote:
> History:
> v1:
>  The collection of bug-fixes from kernel bugzilla bug 70891.
> v2:
>  1. Improves the patch descriptions to make the root cause of the 70891 bug
>     more correct.
>  2. Improves a race fix to make it more robust.
> v2 UPDATE:
>  Added "Reported-by" and "Tested-by" from kernel bugzilla bug 59911/63931
>  as a result of EC bug triage. Only patch descriptions are updated.

OK, I've updated the commits in my tree in accordance with this.

>  Removed the GPE fix, it is included by another GPE API fix series.

I've applied it separately already, so please don't resend it.

Thanks,
Rafael
