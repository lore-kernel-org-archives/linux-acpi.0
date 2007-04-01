From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: 2.6.21-rc5: Thinkpad X60 gets critical thermal shutdowns
Date: Sun, 01 Apr 2007 14:13:00 -0700
Message-ID: <4610205C.5060708@goop.org>
References: <460E0158.7090705@goop.org> <8393D4C0-57C5-4CD2-8CA4-E4241E74FB4E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:56362 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964873AbXDAVNJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 1 Apr 2007 17:13:09 -0400
In-Reply-To: <8393D4C0-57C5-4CD2-8CA4-E4241E74FB4E@mac.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Andi Kleen <ak@suse.de>, "Brown, Len" <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Kyle Moffett wrote:
> Well, 128C is more than hot enough to boil water and well above the
> thermal tolerances of most CPUs, so I would imagine that were your CPU
> actually that hot it wouldn't be capable of printing the "Critical
> temperature reached" messages, let alone properly rebooting.

Yes, its probably a bad reading, but its not complete absurd - chips can
operate up to ~100C, but they're definitely unhappy at that point.  In
fact, I typically get 85-95 degrees from those sensors in normal
operation, but I have no idea whether that's a real measurement or not.

    J
