From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Runtime GPEs not saved over suspend/resume if type != "platform"
Date: Wed, 25 Oct 2006 17:07:45 +0200
Message-ID: <200610251707.46333.rjw@sisk.pl>
References: <453F77D4.2080706@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:1749 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932457AbWJYPJF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Oct 2006 11:09:05 -0400
In-Reply-To: <453F77D4.2080706@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, "Brown, Len" <len.brown@intel.com>

Hi,

On Wednesday, 25 October 2006 16:42, Alexey Starikovskiy wrote:
> Hi,
> 
> There is a problem with swsuspend and GPE events.
> Now they are restored from acpi_pm_finish(), which is called only if we
> suspend with "platform" option, what means that if we suspended to disk
> with the default "shutdown" option after resume all the GPEs will be disabled.
> This presents us with the overheating problem after resume at very least.
> I see two solutions: one is to make "platform" to be default option if ACPI is enabled,
> and second -- enable GPE events from some other function, which will be called in any case.
> 
> What do you think?

Obviously we can "fix" that in the short run by causing "platform" to be the
default.  Still, I think swsusp should work regardless of whether "platform"
or "shutdown" is used.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
