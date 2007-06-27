From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC/RFT][PATCH -mm 8/8] PM: Rename hibernation_ops to platform_hibernation_operations
Date: Wed, 27 Jun 2007 17:19:56 +0200
Message-ID: <200706271719.57337.rjw@sisk.pl>
References: <200706242239.05678.rjw@sisk.pl> <200706260052.28206.rjw@sisk.pl> <20070626085423.GC4594@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:49856 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759114AbXF0PM4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Jun 2007 11:12:56 -0400
In-Reply-To: <20070626085423.GC4594@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Johannes Berg <johannes@sipsolutions.net>, Igor Stoppa <igor.stoppa@nokia.com>

On Tuesday, 26 June 2007 10:54, Pavel Machek wrote:
> Hi!
> 
> > Rename 'struct hibernation_ops' to 'struct platform_hibernation_operations' in
> > analogy with 'struct platform_suspend_operations'.
> 
> Can I NAK it because it gets too long? platform_hibernation_ops /
> platform_suspend_ops is long but maybe acceptable, 'struct
> platform_hibernation_operations' is too long.

Okay, I can change both to platform_suspend_ops and platform_hibernation_ops
(should be mutually consistent IMO).

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
