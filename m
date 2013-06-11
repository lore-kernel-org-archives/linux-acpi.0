From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH 0/3] Fix backlight issues on some Windows 8 systems
Date: Tue, 11 Jun 2013 08:08:04 -0500
Message-ID: <20130611130804.GF8943@thinkpad-t410>
References: <1370818899-8595-1-git-send-email-matthew.garrett@nebula.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:52407 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226Ab3FKNII (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jun 2013 09:08:08 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so11575537obc.27
        for <linux-acpi@vger.kernel.org>; Tue, 11 Jun 2013 06:08:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1370818899-8595-1-git-send-email-matthew.garrett@nebula.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: linux-acpi@vger.kernel.org, joeyli.kernel@gmail.com, daniel.vetter@ffwll.ch, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, lenb@kernel.org, rjw@sisk.pl

On Sun, Jun 09, 2013 at 07:01:36PM -0400, Matthew Garrett wrote:
> Windows 8 introduced new policy for backlight control by pushing it out to
> graphics drivers. This appears to have coincided with a range of vendors
> adding Windows 8 checks to their backlight control code which trigger either
> awkward behaviour (Lenovo) or complete brokenness (some Dells). The simplest
> thing to do would be to just disable ACPI backlight control entirely if the
> firmware indicates Windows 8 support, but it's entirely possible that
> individual graphics drivers might still make use of the ACPI functionality in
> preference to native control.
> 
> The first two patches in this series are picked from other patchesets aimed at
> solving similar problems. The last simply unregisters ACPI backlight control
> on Windows 8 systems when using an Intel GPU. Similar code could be added to
> other drivers, but I'm reluctant to do so without further investigation as
> to the behaviour of the vendor drivers under Windows.

I've received some feedback from user testing of these patches (don't
have an affected machine myself) and the feedback is mostly good. One
user reported it didn't work, but I that machine may have discrete
graphics (waiting to hear back from the user).

The main drawback I see with any approach like this one is that the
backlight remains broken for users of proprietary graphics drivers.

Seth
