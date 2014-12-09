From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 6/6] pci, acpi: Share ACPI PCI config space accessors.
Date: Tue, 9 Dec 2014 14:50:05 -0700
Message-ID: <CAErSpo6cUuEK41wD33Uyzb5Y5yFp+jKVVvWLrZ0dO1iuYv8GjQ@mail.gmail.com>
References: <1416413091-13452-1-git-send-email-tomasz.nowicki@linaro.org>
 <3957412.IooRKpIXjW@wuerfel> <20141121180825.GD6578@google.com>
 <2178540.dTppAIY2rE@wuerfel> <54854FB2.8080206@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:43740 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbaLIVu0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Dec 2014 16:50:26 -0500
Received: by mail-qg0-f51.google.com with SMTP id e89so1154931qgf.24
        for <linux-acpi@vger.kernel.org>; Tue, 09 Dec 2014 13:50:26 -0800 (PST)
In-Reply-To: <54854FB2.8080206@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm <linux-arm-kernel@lists.infradead.org>, Myron Stowe <myron.stowe@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linaro-acpi@lists.linaro.org, linux-pci <linux-pci@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, x86 <x86@kernel.org>, Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Hanjun Guo <hanjun.guo@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, Yijing Wang <wangyijing@huawei.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Thomas Gleixner <tglx@linutronix.de>

On Mon, Dec 8, 2014 at 12:13 AM, Tomasz Nowicki
<tomasz.nowicki@linaro.org> wrote:

> What would be next steps regarding this patch set? I am not sure we have
> reached a consensus on weak vs #ifdef choice.

I work through the list at
https://patchwork.ozlabs.org/project/linux-pci/list/ in FIFO order, so
you don't need to do anything else except poke me to move faster :)

The weak/ifdef question is relatively minor and easily changed, so I
wouldn't worry about it yet.

Bjorn
