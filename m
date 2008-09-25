From: "Yinghai Lu" <yinghai@kernel.org>
Subject: Re: [PATCH 7/7] x86: print out irq nr for msi/ht -v2
Date: Thu, 25 Sep 2008 10:03:09 -0700
Message-ID: <86802c440809251003hb71a6c4vcf51ff018f27f56c@mail.gmail.com>
References: <1222323223-23529-1-git-send-email-yhlu.kernel@gmail.com>
	 <20080925084212.GE4519@elte.hu> <20080925091211.GA4922@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:22997 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034AbYIYRDK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Sep 2008 13:03:10 -0400
Received: by rv-out-0506.google.com with SMTP id k40so527803rvb.1
        for <linux-acpi@vger.kernel.org>; Thu, 25 Sep 2008 10:03:09 -0700 (PDT)
In-Reply-To: <20080925091211.GA4922@elte.hu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, Sep 25, 2008 at 2:12 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
>> > v2: fix hpet compiling
>
> still bad:
>
> arch/x86/kernel/hpet.c: In function 'hpet_late_init':
> arch/x86/kernel/hpet.c:828: error: 'dev' undeclared (first use in this function)
> arch/x86/kernel/hpet.c:828: error: (Each undeclared identifier is reported only once
> arch/x86/kernel/hpet.c:828: error: for each function it appears in.)
>
> we've got some changes in this area (per cpu hpet).

will check it.

YH
