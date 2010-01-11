From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bugme-new] [Bug 14997] New: Closing and re-opening the lid does not reactivate the backlight
Date: Mon, 11 Jan 2010 23:41:12 +0100
Message-ID: <201001112341.12518.rjw@sisk.pl>
References: <bug-14997-10286@http.bugzilla.kernel.org/> <20100111143648.7a6232a9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:35683 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752292Ab0AKWks (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Jan 2010 17:40:48 -0500
In-Reply-To: <20100111143648.7a6232a9.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: yakui.zhao@intel.com, dri-devel@lists.sourceforge.net, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Monday 11 January 2010, Andrew Morton wrote:
> On Wed, 6 Jan 2010 15:38:46 GMT
> bugzilla-daemon@bugzilla.kernel.org wrote:
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id=14997
> 
> Seems to be a 2.6.31 -> 2.6.32 regression.  I don't know if the
> assignment to DRI was appropriate?

I'm not sure either.  Might be ACPI just as well.

Rafael
