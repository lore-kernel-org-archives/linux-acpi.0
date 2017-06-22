From: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Subject: Re: [PATCH 5/7] platform/x86: fujitsu-laptop: do not update ACPI
 device power status
Date: Thu, 22 Jun 2017 23:02:35 +0200
Message-ID: <20170622210235.GC4194@kmp-mobile.hq.kempniu.pl>
References: <20170616044058.30443-1-kernel@kempniu.pl>
 <20170616044058.30443-6-kernel@kempniu.pl>
 <20170621201727.GC25900@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:36315 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752128AbdFVVCj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Jun 2017 17:02:39 -0400
Received: by mail-wr0-f171.google.com with SMTP id c11so39599945wrc.3
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jun 2017 14:02:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170621201727.GC25900@fury>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Jonathan Woithe <jwoithe@just42.net>, Andy Shevchenko <andy@infradead.org>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

> On Fri, Jun 16, 2017 at 06:40:56AM +0200, Michał Kępień wrote:
> > Calling acpi_bus_update_power() for ACPI devices FUJ02B1 and FUJ02E3 is
> > pointless as they are not power manageable (neither _PS0 nor _PR0 is
> > defined for any of them), which causes their power state to be inherited
> > from their parent devices.  Given the ACPI paths of these two devices
> > (\_SB.PCI0.LPCB.FJEX, \_SB.FEXT), their parent devices are also not
> > power manageable.  These parent devices will thus have their power state
> > initialized to ACPI_STATE_D0, which in turn causes the power state for
> > both FUJ02B1 and FUJ02E3 to always be ACPI_STATE_D0 ("on").
> > 
> 
> How confident are we that all implementations of these two ACPI devices lack
> _PS0 and _PR0 ?

I looked at DSDT dumps of four different Fujitsu laptops released in the
past ten years or so for which at least one of these two ACPI devices is
present and found no traces of either of these methods being defined for
them.  I do not think we have a way of ensuring that the above holds
true for every other model out there, but I will point out that
fujitsu-laptop is the only user of acpi_bus_update_power() outside of
drivers/acpi.

-- 
Best regards,
Michał Kępień
