From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [v4.14-rc8 ghes_copy_tofrom_phys] BUG: sleeping function called
 from invalid context at lib/ioremap.c:165
Date: Tue, 7 Nov 2017 07:20:15 +0800
Message-ID: <20171106232015.yw6co4m63f64lrmh@wfg-t540p.sh.intel.com>
References: <CA+55aFxSJGeN=2X-uX-on1Uq2Nb8+v1aiMDz5H1+tKW_N5Q+6g@mail.gmail.com>
 <20171029225155.qcum5i75awrt5tzm@wfg-t540p.sh.intel.com>
 <20171029231835.3725fnd5yehlmqob@wfg-t540p.sh.intel.com>
 <20171030110511.scfrdtlnf5lbdhu5@pd.tnic>
 <CA+55aFy2c88wKndjRAds-3MZ+MsArGBySOog+Rxmd2AciGFGkA@mail.gmail.com>
 <CA+55aFwW7sbguREtVzKAUkNGb4cGh_eADqkEYcUurX5xS60_ww@mail.gmail.com>
 <526e7cf2-0672-e44b-c32f-26128a2dfd37@codeaurora.org>
 <20171106224635.qopgsszwxzuitkpf@wfg-t540p.sh.intel.com>
 <CA+55aFzvuFK3X9xwanyE=4DAuHnjHF9YNB2q2c2r1z+c9aWO_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:30782 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751434AbdKFXUV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Nov 2017 18:20:21 -0500
Content-Disposition: inline
In-Reply-To: <CA+55aFzvuFK3X9xwanyE=4DAuHnjHF9YNB2q2c2r1z+c9aWO_A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: James Morse <james.morse@arm.com>, Tyler Baicar <tbaicar@codeaurora.org>, Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Huang Ying <ying.huang@intel.com>, Chen Gong <gong.chen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>

On Mon, Nov 06, 2017 at 02:57:20PM -0800, Linus Torvalds wrote:
>On Mon, Nov 6, 2017 at 2:46 PM, Fengguang Wu <fengguang.wu@intel.com> wrote:
>>
>> I can see that in RC8, too:
>
>James Morse posted a new version of his series to fix this, and it's
>gotten a few tests, but not a lot. Since you clearly have GHES support
>on at least some of your machines, it might be worth adding that
>series from James to 0day testing.

Sure. I'll test Rafael's git tree including James' patches.

I can see the GHES warnings in a number of 0day machines:

- ivb44: Ivytown Ivy Bridge-EP, E5-2697 v2

  HW details can be found in
  https://git.kernel.org/pub/scm/linux/kernel/git/wfg/lkp-tests.git/tree/hosts/ivb44

- lkp-bdw-ep6: Broadwell-EP, E5-2699 v4
- lkp-bdw-ex2: Broadwell-EX, E7-8890 v4
- lkp-skl-2sp3: Skylake
- lkp-skl-4sp1: Skylake
- lkp-avoton2: Atom

Regards,
Fengguang
