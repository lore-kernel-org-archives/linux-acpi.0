From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v9] ACPI / init: Invoke early ACPI initialization
 earlier
Date: Wed, 27 Sep 2017 09:19:49 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1709270917590.1945@nanos>
References: <1505293975-26005-1-git-send-email-douly.fnst@cn.fujitsu.com> <1505294274-441-1-git-send-email-douly.fnst@cn.fujitsu.com> <e4eadcbc-fe58-2d2c-818d-34e2f545db16@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:50882 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbdI0HUu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Sep 2017 03:20:50 -0400
In-Reply-To: <e4eadcbc-fe58-2d2c-818d-34e2f545db16@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Zheng, Lv" <lv.zheng@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org, yinghai@kernel.org, bhe@redhat.com, bp@alien8.de, fengguang.wu@intel.com

On Wed, 27 Sep 2017, Dou Liyang wrote:

> Hi Rafael, Zheng,
> 
> Welcome any comments!
> 
> Now, our patches are in tip tree, they are based on this
> independent patch, we hope it can be merged earlier than our
> patches to avoid ACPI Error. we need your advice and confirmation.

You should have included that patch into your APIC series so I would have
been aware that it's required for the APIC changes to work on all
platforms.

But not a big problem. I merge it through tip/x86/apic so the stuff works
as expected.

Thanks,

	tglx
