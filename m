From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] fujitsu-laptop: support led-class as module
Date: Wed, 26 Aug 2009 11:08:26 +0930 (CST)
Message-ID: <200908260138.n7Q1cQxW008893@turbo.physics.adelaide.edu.au>
References: <9b2b86520908250412j61a355aax55110f467c2ec61f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:43114 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932810AbZHZBji (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Aug 2009 21:39:38 -0400
In-Reply-To: <9b2b86520908250412j61a355aax55110f467c2ec61f@mail.gmail.com> from "Alan Jenkins" at Aug 25, 2009 12:12:17 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org, lenb@kernel.org

Hi

> > Please consider slipping this in to 2.6.31-rc since it's a fairly trivial
> > bug fix to ensure that fujitsu-laptop uses the LEDS class even when the LEDS
> > class been compiled as a module.  If that's not possible or viewed as
> > inappropriate then let's go for 2.6.32.
> > :
>
> Don't you need to exclude
> 
> CONFIG_LEDS_CLASS=m
> CONFIG_FUJITSU_LAPTOP=y

Hmm, good point.  Admittedly this would be a rare case since most
distributors would ship with both CONFIG_LEDS_CLASS and
CONFIG_FUJITSU_LAPTOP set to "m" - a situation which the proposed patch
at least makes workable.

> I think the Kconfig-fu is "depends on LEDS_CLASS || LEDS_CLASS=n".

So, basically something like this should do the trick:

signed-off-by: Alan Jenkins <sourcejedi.lkml@googlemail.com>
signed-off-by: Joathan Woithe <jwoithe@physics.adelaide.edu.au>

--- a/drivers/platform/x86/Kconfig	2009-08-26 11:03:20.000000000 +0930
+++ b/drivers/platform/x86/Kconfig	2009-08-26 11:04:28.000000000 +0930
@@ -82,6 +82,7 @@
 	depends on ACPI
 	depends on INPUT
 	depends on BACKLIGHT_CLASS_DEVICE
+	depends on LEDS_CLASS || LEDS_CLASS=n
 	---help---
 	  This is a driver for laptops built by Fujitsu:

Regards
  jonathan
