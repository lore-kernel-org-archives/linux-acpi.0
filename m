From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.27-rc8: throttling broken
Date: Thu, 9 Oct 2008 23:27:25 +0200
Message-ID: <200810092327.26301.rjw@sisk.pl>
References: <20081009171238.GB1370@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:47499 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753565AbYJIVWx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Oct 2008 17:22:53 -0400
In-Reply-To: <20081009171238.GB1370@ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: jikos@suse.cz, kernel list <linux-kernel@vger.kernel.org>, linux-acpi@ucw.cz, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thursday, 9 of October 2008, Pavel Machek wrote:
> Hi!
> 
> On 2.6.27-rc8 on via/fic subnotebook, throttling seems to be broken. I
> can do echo 15 > /proc/acpi/processor/*/throttling, and proc file
> reflects new value, but cpu still runs at same speed.
> 
> It worked on opensuse11/sled10 kernels at least...

Any chance to check 2.6.26.x on that?

Thanks,
Rafael
