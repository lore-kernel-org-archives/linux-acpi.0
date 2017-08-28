From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH V3] acpi: apei: clear error status before acknowledging
 the error
Date: Mon, 28 Aug 2017 20:20:37 +0300
Message-ID: <CAHp75Vdx2NG8yd-cr14hxQzEjy-V29de4nbiq0v9tWpXVxt+2w@mail.gmail.com>
References: <1503939221-27732-1-git-send-email-tbaicar@codeaurora.org>
 <1503939660.25945.127.camel@linux.intel.com> <20170828171405.2s4rlebloi5lyhga@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:37127 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdH1RUi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Aug 2017 13:20:38 -0400
In-Reply-To: <20170828171405.2s4rlebloi5lyhga@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Will Deacon <will.deacon@arm.com>, james.morse@arm.com, shiju.jose@huawei.com, Geliang Tang <geliangtang@gmail.com>, Tony Luck <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Aug 28, 2017 at 8:14 PM, Borislav Petkov <bp@suse.de> wrote:
> On Mon, Aug 28, 2017 at 08:01:00PM +0300, Andy Shevchenko wrote:
>> You can also do this here, like
>>       if (is_hest_type_generic_v2(ghes) && rc != -ENOENT)
>
> https://lkml.kernel.org/r/20170824081408.iwg7qyyr226btivo@pd.tnic

       if (rc != -ENOENT && is_hest_type_generic_v2(ghes))
 :-)

But again, your call to choose :-)

-- 
With Best Regards,
Andy Shevchenko
