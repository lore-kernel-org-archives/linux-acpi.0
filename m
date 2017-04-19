From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 1/2] ACPI: video: get rid of magic numbers and use enum instead
Date: Wed, 19 Apr 2017 21:36:27 +0200
Message-ID: <CAJZ5v0gZ95Np7gPidaAO2D7oEmDyE_O8RVuLOnoTsKC5o=QwFQ@mail.gmail.com>
References: <20170418123558.12436-1-mail@dmitryfrank.com> <20170419103618.20939-1-mail@dmitryfrank.com>
 <20170419103618.20939-2-mail@dmitryfrank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yb0-f193.google.com ([209.85.213.193]:35447 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934549AbdDSTg2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2017 15:36:28 -0400
Received: by mail-yb0-f193.google.com with SMTP id 19so2082474ybl.2
        for <linux-acpi@vger.kernel.org>; Wed, 19 Apr 2017 12:36:28 -0700 (PDT)
In-Reply-To: <20170419103618.20939-2-mail@dmitryfrank.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Frank <mail@dmitryfrank.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Felipe Contreras <felipe.contreras@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, Apr 19, 2017 at 12:36 PM, Dmitry Frank <mail@dmitryfrank.com> wrote:
> The first two items in the _BCL method response are special:
>
>   - Level when machine has full power
>   - Level when machine is on batteries
>   - .... actual supported levels go there ....
>
> So this commits adds an enum and uses its descriptive elements
> throughout the code, instead of magic numbers.
>
> Signed-off-by: Dmitry Frank <mail@dmitryfrank.com>

Are there any differences between this and the previous version of the
patch you posted?

Thanks,
Rafael
