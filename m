From: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Subject: Re: [PATCH 1/7] platform/x86: fujitsu-laptop: do not use kfifo for
 storing hotkey scancodes
Date: Thu, 22 Jun 2017 22:08:56 +0200
Message-ID: <20170622200856.GA4194@kmp-mobile.hq.kempniu.pl>
References: <20170616044058.30443-1-kernel@kempniu.pl>
 <20170616044058.30443-2-kernel@kempniu.pl>
 <20170621181543.GB25900@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:36247 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751202AbdFVUJB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Jun 2017 16:09:01 -0400
Received: by mail-wr0-f172.google.com with SMTP id c11so37887686wrc.3
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jun 2017 13:09:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170621181543.GB25900@fury>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Jonathan Woithe <jwoithe@just42.net>, Andy Shevchenko <andy@infradead.org>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

> On Fri, Jun 16, 2017 at 06:40:52AM +0200, Michał Kępień wrote:
> > All ACPI device notify callbacks are invoked using acpi_os_execute(),
> > which causes the supplied callback to be queued to a static workqueue
> > which always executes on CPU 0.  This means that there is no possibility
> > for any ACPI device notify callback to be concurrently executed on
> > multiple CPUs, which in the case of fujitsu-laptop means that using a
> > locked kfifo for handling hotkeys is redundant: as hotkey scancodes are
> > only pushed and popped from within acpi_fujitsu_laptop_notify(), no risk
> > of concurrent pushing and popping exists.
> 
> Was the kfifo causing a problem currently or for the migration to separate
> modules? Is this purely a simplification?

It is just another step in stripping fujitsu-laptop down to its bare
essentials.  If my reasoning quoted above is correct, using a locked
kfifo needlessly suggests potential concurrency issues, but it is
definitely not an error.

-- 
Best regards,
Michał Kępień
