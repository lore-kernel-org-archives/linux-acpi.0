From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [Bugme-new] [Bug 12235] New:
	/sys/devices/virtual/backlight/acpi_video0/brightness has it backwards
Date: Wed, 17 Dec 2008 08:57:36 +0800
Message-ID: <1229475456.562.5.camel@rzhang-dt>
References: <bug-12235-10286@http.bugzilla.kernel.org/>
	 <20081216100023.2e437c8c.akpm@linux-foundation.org>
	 <20081216205532.GB14332@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:5238 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767AbYLQA6v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Dec 2008 19:58:51 -0500
In-Reply-To: <20081216205532.GB14332@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "bugme-daemon@bugzilla.kernel.org" <bugme-daemon@bugzilla.kernel.org>, "khashayar.lists@gmail.com" <khashayar.lists@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wed, 2008-12-17 at 04:55 +0800, Matthew Garrett wrote:
> On Tue, Dec 16, 2008 at 10:00:23AM -0800, Andrew Morton wrote:
> 
> > OK, that's weird.  I have a suspicion that we're about to find out that
> > this is intentional, but I don't know what the fix is..
> 
> My recollection is that some BIOSes provide the list of brightness 
> values in reverse order - someone posted a patch to sort them in-kernel, 
> but I can't remember what happened to it. xbacklight will work because 
> it triggers a direct write to the hardware if the acpi driver isn't 
> loaded.
> 
right, this seems to be a duplicate of
http://bugzilla.kernel.org/show_bug.cgi?id=12037

khashayar,
please attach the result of "grep . /proc/acpi/video/*/*/*".
please try the patch in
http://bugzilla.kernel.org/show_bug.cgi?id=12037#c5
and see if it helps.

thanks,
rui


