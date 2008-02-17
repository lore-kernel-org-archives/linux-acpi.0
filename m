From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bugme-new] [Bug 9957] New: Battery gives me now two batterys, but only one is present
Date: Sun, 17 Feb 2008 23:18:23 +0100
Message-ID: <200802172318.24334.rjw@sisk.pl>
References: <bug-9957-10286@http.bugzilla.kernel.org/> <20080213123112.5df7fea3.akpm@linux-foundation.org> <20080214140513.GA12412@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39751 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753832AbYBQWUF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 Feb 2008 17:20:05 -0500
In-Reply-To: <20080214140513.GA12412@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, patrick.matthaei@web.de, bugme-daemon@bugzilla.kernel.org, linux-acpi@vger.kernel.org

On Thursday, 14 of February 2008, Matthew Garrett wrote:
> On Wed, Feb 13, 2008 at 12:31:12PM -0800, Andrew Morton wrote:
> 
> > And it's a regression.
> 
> No, it's a feature. You've configured in both the legacy and the sysfs 
> interfaces for the battery, and hal is picking up both of them. There's 
> a patch upstream to make hal realise that they're the same device, but 
> the alternative is just to disable one of the options.

Can you point me to the patch, please?

I'm running the current mainline and seeing this as well.

Thanks,
Rafael
