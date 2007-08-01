From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] CONFIG_PM_LEGACY = compiler warnings for deprecation ... solution?
Date: Wed, 1 Aug 2007 12:57:25 +0200
Message-ID: <200708011257.25835.rjw@sisk.pl>
References: <20070801050806.4A8BEDA820@mailserver8.hushmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:34576 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185AbXHAKsh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Aug 2007 06:48:37 -0400
In-Reply-To: <20070801050806.4A8BEDA820@mailserver8.hushmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: postfail@hushmail.com
Cc: linux-acpi@vger.kernel.org, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>

On Wednesday, 1 August 2007 07:08, Scott Thompson wrote:
> w/ CONFIG_PM_LEGACY .config option set, you get following batch of
> compile errors because it marks the functions as 'deprecated'. w/o 
> it set, it just uses stubs. compiler warnings for refernece (from 
> 2.6.23-1, though appears to have been around since at least 2.6.11 
> from another mail list post).
> 
> However, since these functions are required if you have
> CONFIG_PM_LEGACY option marked...
> 
> I propose that within the include/linux/pm_legacy.h file, functions
> in the CONFIG_PM_LEGACY aren't marked 'deprecated' and functions
> outside the #if are marked deprecated.  Then the handful of calls
> (12 or so) that actually call the pm_legacy apis can get wrapped in
> the CONFIG_PM_LEGACY flag.
> 
> This is basically already being done in one case since as of
> 2.6.20.1 the pm_register function is only used in
> drivers/serial/68328serial.c.
> 
> The pm_send_all is not wrapped around all uses yet, but that is
> pretty easy to patch.  Then the compile will actually complain
> should someone try to call it and not wrap w/ the CONFIG_PM_LEGACY
> ifdef.
> 
> Happy to hear thoughts or other solutions.

We are going to remove the legacy PM altogether, AFAICS, although there still
are some obstacles.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
