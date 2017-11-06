From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [v4.14-rc8 ghes_copy_tofrom_phys] BUG: sleeping function called
 from invalid context at lib/ioremap.c:165
Date: Mon, 6 Nov 2017 14:57:20 -0800
Message-ID: <CA+55aFzvuFK3X9xwanyE=4DAuHnjHF9YNB2q2c2r1z+c9aWO_A@mail.gmail.com>
References: <CA+55aFxSJGeN=2X-uX-on1Uq2Nb8+v1aiMDz5H1+tKW_N5Q+6g@mail.gmail.com>
 <20171029225155.qcum5i75awrt5tzm@wfg-t540p.sh.intel.com> <20171029231835.3725fnd5yehlmqob@wfg-t540p.sh.intel.com>
 <20171030110511.scfrdtlnf5lbdhu5@pd.tnic> <CA+55aFy2c88wKndjRAds-3MZ+MsArGBySOog+Rxmd2AciGFGkA@mail.gmail.com>
 <CA+55aFwW7sbguREtVzKAUkNGb4cGh_eADqkEYcUurX5xS60_ww@mail.gmail.com>
 <526e7cf2-0672-e44b-c32f-26128a2dfd37@codeaurora.org> <20171106224635.qopgsszwxzuitkpf@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:55922 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbdKFW5V (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Nov 2017 17:57:21 -0500
In-Reply-To: <20171106224635.qopgsszwxzuitkpf@wfg-t540p.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>, James Morse <james.morse@arm.com>
Cc: Tyler Baicar <tbaicar@codeaurora.org>, Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Huang Ying <ying.huang@intel.com>, Chen Gong <gong.chen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>

On Mon, Nov 6, 2017 at 2:46 PM, Fengguang Wu <fengguang.wu@intel.com> wrote:
>
> I can see that in RC8, too:

James Morse posted a new version of his series to fix this, and it's
gotten a few tests, but not a lot. Since you clearly have GHES support
on at least some of your machines, it might be worth adding that
series from James to 0day testing.

The patches look good to me, and I assume I'll be be getting it
through Rafael from the ACPI tree (which is how the other ghes code
reaches me), but maybe by now for 4.15 with a stable backport.

The actual problem is definitely not new. Only the warning message.

So the code should work as well as it ever has, which may or may not
be saying a lot. It might be worth fixing for 4.14 just to not scare
people too much with messages, but at the same time it's not a
_functional_ regression.

            Linus
