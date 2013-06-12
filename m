From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: OT: Best practices for indenting ASL files
Date: Wed, 12 Jun 2013 13:29:30 +0200
Message-ID: <3060231.iXCZhdCYAv@vostro.rjw.lan>
References: <1370595194.21257.9.camel@mattotaupa> <228515949.LdhQTLUpvh@vostro.rjw.lan> <1371020459.5500.33.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:34880 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756642Ab3FLLUS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Jun 2013 07:20:18 -0400
In-Reply-To: <1371020459.5500.33.camel@mattotaupa>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: linux-acpi@vger.kernel.org

On Wednesday, June 12, 2013 09:00:59 AM Paul Menzel wrote:
> Am Mittwoch, den 12.06.2013, 00:53 +0200 schrieb Rafael J. Wysocki:
> > On Friday, June 07, 2013 10:53:14 AM Paul Menzel wrote:
> 
> > > we have a lot of ASL files in coreboot [1], a free firmware for hardware
> > > initialization.
> > > 
> > > As you can see in [2] for example, we struggle with whitespace issues.
> > > 
> > > Could you recommend best practices how to indent ASL files?
> > 
> > Well, why don't you adopt the convention used by 'iasl -d'?  People are
> > quite accustomed to that.
> 
> Yes, that is what I want to achieve. But how? Sorry for being unclear.
> Is there a utility for ASL files like `indent -linux` for C files?

That I don't know, sorry.  I guess you can always compile, disassemble and
compare the result with the original code ...

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
