From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] acpi: handle the acpi hotplug schedule error
Date: Wed, 7 Jun 2017 19:55:15 +0300
Message-ID: <CAHp75Vd+kqgwiJxGbGg3abFgez6Af8j5Qnr0-VAWtayx+vTmYg@mail.gmail.com>
References: <20170607060527.23407-1-jlee@suse.com> <CAHp75Vdeagae37PHoD4yw4dncFQJ2tmuxRu0zzbH_b+SnY4pEQ@mail.gmail.com>
 <20170607101832.GW30622@linux-l9pv.suse> <CAHp75VcBG-gHEOPkPBHMXzpY7G3hJxtXKKAjPesjBHVW-gx6qA@mail.gmail.com>
 <20170607153933.GY30622@linux-l9pv.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34511 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbdFGQzR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Jun 2017 12:55:17 -0400
In-Reply-To: <20170607153933.GY30622@linux-l9pv.suse>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Wed, Jun 7, 2017 at 6:39 PM, joeyli <jlee@suse.com> wrote:
> On Wed, Jun 07, 2017 at 01:46:37PM +0300, Andy Shevchenko wrote:
>> On Wed, Jun 7, 2017 at 1:18 PM, joeyli <jlee@suse.com> wrote:
>> > On Wed, Jun 07, 2017 at 11:36:55AM +0300, Andy Shevchenko wrote:
>> >> On Wed, Jun 7, 2017 at 9:05 AM, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:

> I think normally it should be success. So how about:
>
>         if (hotplug_event) {
>                 if (ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
>                         return;
>                 goto err_put_device;
>         }

Fine by me.

-- 
With Best Regards,
Andy Shevchenko
