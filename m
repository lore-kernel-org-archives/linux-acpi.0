From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/7] ACPI-APEI-HEST: Fine-tuning for three function implementations
Date: Mon, 5 Sep 2016 23:43:12 +0200
Message-ID: <CAJZ5v0hcD8pi8y+jAtF70cJp8uYyUdOeDJKuR3z=JpB6Z_Qnfw@mail.gmail.com>
References: <566ABCD9.1060404@users.sourceforge.net> <9834b713-2c7b-ad6d-76a5-b1db40f561fc@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36706 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932217AbcIEVnO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Sep 2016 17:43:14 -0400
In-Reply-To: <9834b713-2c7b-ad6d-76a5-b1db40f561fc@users.sourceforge.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, trivial@kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Sep 5, 2016 at 10:12 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 5 Sep 2016 22:05:05 +0200
>
> Some update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (7):
>   Fix a typo in a comment line
>   Use kmalloc_array() in hest_ghes_dev_register()
>   Move an assignment in hest_ghes_dev_register()
>   Rename jump labels in hest_ghes_dev_register()
>   Rename jump labels in acpi_hest_init()
>   Reduce the scope for a variable in acpi_hest_init()
>   Rename jump labels in hest_parse_ghes()

Like in the other patch series I've just commented, please put all
label renames into one patch.

Thanks,
Rafael
