From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] acpi-video: Add disable_native_backlight quirk for Dell
 XPS15 L521X
Date: Mon, 12 Jan 2015 02:44:11 +0000
Message-ID: <20150112024411.GA6831@srcf.ucam.org>
References: <1420444624-8313-1-git-send-email-hdegoede@redhat.com>
 <20150111061602.GA1677@srcf.ucam.org>
 <54B25280.6010604@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:48007 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbbALCoQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Jan 2015 21:44:16 -0500
Content-Disposition: inline
In-Reply-To: <54B25280.6010604@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

On Sun, Jan 11, 2015 at 11:37:52AM +0100, Hans de Goede wrote:

> Userspace is writing to the intel_backlight device because it is the
> only one present under /sys/class/backlight, as we disable acpi-video
> on win8 ready laptops by default now.

Why is nouveau not providing a backlight device?

> The commit message may not be 100% accurate, although I believe this is
> related to the laptop having nvidia graphics, but the code / fix is correct
> regardless.

I don't think we have enough evidence to know whether this fix is 
correct.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
