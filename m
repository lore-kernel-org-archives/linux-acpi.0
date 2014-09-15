From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v4 10/18] ACPI / table: Print GIC information when MADT
 is parsed
Date: Mon, 15 Sep 2014 10:52:50 -0700
Message-ID: <20140915175250.8177DC40A42@trevor.secretlab.ca>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
	<1410530416-30200-11-git-send-email-hanjun.guo@linaro.org>
	<20140915064010.GD26649@localhost>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:50056 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbaIORww (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Sep 2014 13:52:52 -0400
Received: by mail-pa0-f50.google.com with SMTP id bj1so6876362pad.9
        for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2014 10:52:52 -0700 (PDT)
In-Reply-To: <20140915064010.GD26649@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-a

On Sun, 14 Sep 2014 23:40:10 -0700, Olof Johansson <olof@lixom.net> wrote:
> On Fri, Sep 12, 2014 at 10:00:08PM +0800, Hanjun Guo wrote:
> > When MADT is parsed, print GIC information to make the boot
> > log look pretty.
> 
> If you do this for prettiness, having an example output in the commit
> message would be a nice touch.

Agreed.

> The question is why it's needed though? Do we really need all this verbose
> information in dmesg when it could be found out in other ways instead?
> 
> x86 is notoriously verbose in some of these aspects, I'm not sure it's
> something we need to mimic here?

For consistency, it does make sense to have the common x86 and ARM64
code outputing information in the same way, so I think the patch still
makes sense. All of them could be moved to KERN_DEBUG as a separate
patch if we want to cull early boot output. I would split that off and
discuss it separately.

g.
