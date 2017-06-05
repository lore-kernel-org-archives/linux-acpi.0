From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [resend RFC 1/6] ACPICA: add HMAT table definitions
Date: Mon, 5 Jun 2017 22:44:11 +0200
Message-ID: <CAJZ5v0iARt8WT+VHt21trSvYqqy6f4ExLEL3UVxJ4vbX_=_bcQ@mail.gmail.com>
References: <20170602205956.28351-1-ross.zwisler@linux.intel.com>
 <20170605195057.31492-1-ross.zwisler@linux.intel.com> <20170605195057.31492-2-ross.zwisler@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34144 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbdFEUoM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2017 16:44:12 -0400
In-Reply-To: <20170605195057.31492-2-ross.zwisler@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Anaczkowski, Lukasz" <lukasz.anaczkowski@intel.com>, "Box, David E" <david.e.box@intel.com>, "Kogut, Jaroslaw" <Jaroslaw.Kogut@intel.com>, "Lahtinen, Joonas" <joonas.lahtinen@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Nachimuthu, Murugasamy" <murugasamy.nachimuthu@intel.com>, "Odzioba, Lukasz" <lukasz.odzioba@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Schmauss, Erik" <erik.schmauss@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>

On Mon, Jun 5, 2017 at 9:50 PM, Ross Zwisler
<ross.zwisler@linux.intel.com> wrote:
> Import HMAT table definitions from the ACPICA codebase.
>
> This kernel patch was generated using an ACPICA patch from "Zheng, Lv"
> <lv.zheng@intel.com>.  The actual upstream patch that adds these table
> definitions will come from the Intel ACPICA team as part of their greater
> ACPI 6.2 update.
>
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>

Can you please hold on util we have integrated all of the pending
ACPICA changes?

Thanks,
Rafael
