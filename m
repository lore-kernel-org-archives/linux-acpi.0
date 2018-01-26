From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/2] x86/acpi: add retrieval function for rsdp address
Date: Fri, 26 Jan 2018 20:08:24 +0200
Message-ID: <CAHp75VdgdQXH-d9+Fo1DwGdfV1pB0jADMmwAK1BU7oN6dgQs8Q@mail.gmail.com>
References: <20180125143639.9969-1-jgross@suse.com> <20180125143639.9969-2-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40221 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751506AbeAZSI0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jan 2018 13:08:26 -0500
In-Reply-To: <20180125143639.9969-2-jgross@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Juergen Gross <jgross@suse.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, xen-devel@lists.xenproject.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ingo Molnar <mingo@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, stable@vger.kernel.org

On Thu, Jan 25, 2018 at 4:36 PM, Juergen Gross <jgross@suse.com> wrote:
> Add a function to get the address of the RSDP table. Per default use a
> __weak annotated function being a nop.

The problem with weak functions that we can't have more than one
implementation per kernel while we would like to built several code
paths.

I have stumbled on the similar stuff and realize that.

Perhaps, one of the solution is to have an additional struct under
x86_init to alternate ACPI related stuff.

-- 
With Best Regards,
Andy Shevchenko
