From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 1/7] platform/x86: fujitsu-laptop: do not use kfifo for
 storing hotkey scancodes
Date: Thu, 22 Jun 2017 16:58:09 -0700
Message-ID: <20170622235809.GB27213@fury>
References: <20170616044058.30443-1-kernel@kempniu.pl>
 <20170616044058.30443-2-kernel@kempniu.pl>
 <20170621181543.GB25900@fury>
 <20170621235021.GA32131@marvin.atrad.com.au>
 <20170622024413.GE25900@fury>
 <20170622030120.GF32131@marvin.atrad.com.au>
 <20170622204619.GB4194@kmp-mobile.hq.kempniu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:56689 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754010AbdFVX6O (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Jun 2017 19:58:14 -0400
Content-Disposition: inline
In-Reply-To: <20170622204619.GB4194@kmp-mobile.hq.kempniu.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: Jonathan Woithe <jwoithe@just42.net>, Rafael Wysocki <rjw@rjwysocki.net>, Andy Shevchenko <andy@infradead.org>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jun 22, 2017 at 10:46:19PM +0200, Michał Kępień wrote:
> > The events seen by userspace with the original code would be "A-press",
> > "B-press", "A-release", "B-release".  With the revised code the order of the
> > release events would be reversed compared to the previous behaviour.  That
> > is, unless I've misunderstood how sparse_keymap_report_event() works.
> 
> All you wrote above is correct and this patch does change the order of
> release events sent to userspace when multiple hotkeys are pressed
> simultaneously.  The question is: is it relevant for any practical
> scenario?
> 
> Anyway, I find this matter to be of secondary importance.  The primary
> objective of this patch is to get rid of the kfifo.  If anyone has
> strong feelings about the change in event ordering, I will be happy to
> revert to FIFO in v2.

This all looks reasonable to me, I don't see anything requiring a respin.

-- 
Darren Hart
VMware Open Source Technology Center
