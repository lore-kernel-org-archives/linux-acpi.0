From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH] Add support for the generic backlight device to the
	IBM ACPI driver
Date: Wed, 11 Oct 2006 13:54:17 +0100
Message-ID: <1160571257.4936.7.camel@hughsie-laptop>
References: <20061009113235.GA4444@homac.suse.de>
	 <20061011113042.GA4725@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.235]:53831 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161046AbWJKMyV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Oct 2006 08:54:21 -0400
Received: by hu-out-0506.google.com with SMTP id 28so791744hub
        for <linux-acpi@vger.kernel.org>; Wed, 11 Oct 2006 05:54:19 -0700 (PDT)
In-Reply-To: <20061011113042.GA4725@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, len.brown@intel.com

On Wed, 2006-10-11 at 11:30 +0000, Pavel Machek wrote:
> Looks okay to me. It would be nice to get this in, so that we teach
> people to use generic interface, and so that we can remove crappy
> interfaces in future...

What about needing a module parameter "enable-old-interface" so by
default be only support the new interface but can support the legacy one
if the user is running old userspace stuff? Insane?

Richard.


