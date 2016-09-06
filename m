From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: ACPI-video: Fine-tuning for several function implementations
Date: Tue, 6 Sep 2016 05:28:01 +0200
Message-ID: <3e0cdc5b-fd15-515a-82f2-2f44792664ed@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
 <CAJZ5v0hug9QfZHQosCFFXEcFMsDd=YvXkqMmQya3RSqmOnY4dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:62090 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753565AbcIFD2i (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Sep 2016 23:28:38 -0400
In-Reply-To: <CAJZ5v0hug9QfZHQosCFFXEcFMsDd=YvXkqMmQya3RSqmOnY4dg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

> I'd prefer this to be combined into fewer patches
> that each will address several issues of one type,

I understand your concern a bit in principle.


> ie. put all label renames into one patch,

Are any of my update suggestions controversial here?


> all size determination improvements into another one and so on.

I am unsure about the acceptance for the selected software change opportunities.
So I chose a very specific patch granularity intentionally.

I tend to provide some change ideas for each affected function
implementation individually. I imagine that this way should support
the recombination of update steps to some degree already, shouldn't it?

Regards,
Markus
