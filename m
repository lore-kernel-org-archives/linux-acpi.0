From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] acpi-video: Add disable_native_backlight quirk for Dell
 XPS15 L521X
Date: Sun, 11 Jan 2015 06:16:02 +0000
Message-ID: <20150111061602.GA1677@srcf.ucam.org>
References: <1420444624-8313-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41919 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbbAKGQM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Jan 2015 01:16:12 -0500
Content-Disposition: inline
In-Reply-To: <1420444624-8313-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

On Mon, Jan 05, 2015 at 08:57:04AM +0100, Hans de Goede wrote:
> The L521X variant of the Dell XPS15 has integrated nvidia graphics, and
> backlight control does not work properly when using the native interfaces.

I'm not convinced that the assessment of this bug is correct. Is the 
system using the nvidia graphics device? If so, why is userspace writing 
to the intel backlight device?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
