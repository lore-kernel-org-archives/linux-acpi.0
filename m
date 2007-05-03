From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] swsusp: Do not use pm_ops
Date: Thu, 3 May 2007 14:54:25 +0200
Message-ID: <200705031454.25877.rjw@sisk.pl>
References: <200705022213.35831.rjw@sisk.pl> <1178194429.13233.100.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53181 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161884AbXECMts (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 May 2007 08:49:48 -0400
In-Reply-To: <1178194429.13233.100.camel@johannes.berg>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>, Pekka Enberg <penberg@cs.helsinki.fi>

On Thursday, 3 May 2007 14:13, Johannes Berg wrote:
> On Wed, 2007-05-02 at 22:13 +0200, Rafael J. Wysocki wrote:
> 
> > +extern inline int hibernate(void) { return -ENOSYS; }
> 
> and I don't think that will compile :)

It will, but this is a mistake.  It should be 'static', not 'extern'.  Will fix, thanks.

Rafael
