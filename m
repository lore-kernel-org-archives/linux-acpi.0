From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 19/37] ACPI: Hibernate erroneously disabled Suspend wakeup devices
Date: Thu, 11 Oct 2007 12:12:19 +0200
Message-ID: <200710111212.20305.rjw@sisk.pl>
References: <1191992804-14965-1-git-send-email-lenb@kernel.org> <1191992804-14965-20-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42742 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529AbXJKJ5J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Oct 2007 05:57:09 -0400
In-Reply-To: <1191992804-14965-20-git-send-email-lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Renninger <trenn@suse.de>

On Wednesday, 10 October 2007 07:06, Len Brown wrote:
> From: Alexey Starikovskiy <astarikovskiy@suse.de>
> 
> S4 suspend to disk will disable GPE's permanently
> because acpi_gpe_sleep_prepare() does not have
> a counterpart at resume time.  Thus, those devices
> became unavailable for wakeup from subsequent
> S3 suspend-to-ram.
> 
> Here acpi_gpe_sleep_prepare() is removed, and upon suspend
> acpi_enable_wakeup_device() gets its functionality.
> Upon resume, acpi_disable_wakeup_device() restores the state.
> 
> https://bugzilla.novell.com/show_bug.cgi?id=292300

This patch apparently causes problems to appear on some Acer boxes:

https://bugzilla.novell.com/show_bug.cgi?id=299882

Greetings,
Rafael
