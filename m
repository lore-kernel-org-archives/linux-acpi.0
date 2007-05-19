From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.21-mm2: ACPI exception on resume
Date: Sat, 19 May 2007 20:24:16 +0200
Message-ID: <200705192024.16812.rjw@sisk.pl>
References: <20070519165738.GK11115@waste.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40161 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758208AbXESSTH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 May 2007 14:19:07 -0400
In-Reply-To: <20070519165738.GK11115@waste.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org

Hi,

On Saturday, 19 May 2007 18:57, Matt Mackall wrote:
> Starting with 2.6.21-mm2, I'm seeing occassional failures to resume
> from suspend-to-ram on my Thinkpad R51. The screen will flash as it
> usually does, then go black and the machine will become totally
> unresponsive, even to holding down the power button for 30+ seconds.
> But the hard drive light will occassionally flash, so the machine is
> clearly not completely dead at this point.

Does the mainline (as of 2.6.22-rc2) do this?

Rafael
