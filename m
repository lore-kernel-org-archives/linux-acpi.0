From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] More ACPI updates for v4.10-rc1
Date: Wed, 4 Jan 2017 15:19:52 -0800
Message-ID: <CA+55aFw3e_L-H=B6svoBK8234xNEws254VCKhedg4o+eF9+5dg@mail.gmail.com>
References: <CAJZ5v0iq8z-cdja46o2z__Pfs9M+j2q4SXFu=7cS4LHY3XqL4g@mail.gmail.com>
 <CA+55aFxB_vuENriLFT6S+HMfWouKvrOaaM3NYgeYGnmTYsKU=g@mail.gmail.com> <CAJZ5v0hqsoFXvhhyzFAcoi238-dDPesm1-HkGuogJgxLfy2d3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:36610 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969664AbdADXTx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Jan 2017 18:19:53 -0500
In-Reply-To: <CAJZ5v0hqsoFXvhhyzFAcoi238-dDPesm1-HkGuogJgxLfy2d3g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, Jan 4, 2017 at 3:15 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> Is this on HW or emulation?

This is my normal desktop, so pretty plain HW.

It doesn't happen on my laptop, so it's obviously hw-related or
possibly config-related.

I'll send my acpidump output in a separate off-list email in case that
might help make sense of what triggers it.

                Linus
