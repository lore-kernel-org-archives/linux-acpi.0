From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] ACPI: nfit: constify *_attribute_group.
Date: Tue, 27 Jun 2017 21:42:39 -0700
Message-ID: <CAPcyv4jYtx-TcUqqFm4UUbEixmmMkOKWJtkFK_7XRDxp3Y64qA@mail.gmail.com>
References: <4c4644aea76ce2f098719c333125ceb6a3244145.1498126084.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yb0-f179.google.com ([209.85.213.179]:33322 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbdF1Emk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Jun 2017 00:42:40 -0400
Received: by mail-yb0-f179.google.com with SMTP id 84so15602609ybe.0
        for <linux-acpi@vger.kernel.org>; Tue, 27 Jun 2017 21:42:40 -0700 (PDT)
In-Reply-To: <4c4644aea76ce2f098719c333125ceb6a3244145.1498126084.git.arvind.yadav.cs@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Jun 22, 2017 at 3:14 AM, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> File size before:
>    text    data     bss     dec     hex filename
>   20792    1580     994   23366    5b46 drivers/acpi/nfit/core.o
>
> File size After adding 'const':
>    text    data     bss     dec     hex filename
>   20968    1388     994   23350    5b36 drivers/acpi/nfit/core.o
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/acpi/nfit/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Looks good to me, applied.
