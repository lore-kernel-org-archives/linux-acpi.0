From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] acpi: Fix format string type mistakes
Date: Fri, 16 Dec 2016 23:36:39 +0100
Message-ID: <CAJZ5v0h-xUXNHgr5x4ZYRAvsUZDip65aYCPVPeZ3E9=djcpQnA@mail.gmail.com>
References: <20161216215137.GA96800@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wj0-f193.google.com ([209.85.210.193]:35069 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932146AbcLPWgl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Dec 2016 17:36:41 -0500
In-Reply-To: <20161216215137.GA96800@beast>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Robert Moore <robert.moore@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Emese Revfy <re.emese@gmail.com>, "devel@acpica.org" <devel@acpica.org>

On Fri, Dec 16, 2016 at 10:51 PM, Kees Cook <keescook@chromium.org> wrote:
> From: Emese Revfy <re.emese@gmail.com>
>
> This adds the missing __printf attribute which allows compile time
> format string checking (and will be used by the coming initify gcc
> plugin). Additionally, this fixes the warnings exposed by the attribute.
>
> Signed-off-by: Emese Revfy <re.emese@gmail.com>
> [kees: split scsi/acpi, merged attr and fix, new commit messages]
> Signed-off-by: Kees Cook <keescook@chromium.org>

This modifies code that we get from an external projiect (ACPICA) and
the bugs should be fixed in there in the first place.

Moreover, I'm not sure if adding __printf in acpiosxf.h is a good idea.

Thanks,
Rafael
