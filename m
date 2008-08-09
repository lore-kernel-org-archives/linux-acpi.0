From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: disk problem at resume on 2.6.27-rc
Date: Sat, 9 Aug 2008 13:47:31 +0200
Message-ID: <200808091347.31661.rjw@sisk.pl>
References: <1218277099.5571.4.camel@hidalgo> <1218278487.5571.6.camel@hidalgo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:45124 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466AbYHILpO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 9 Aug 2008 07:45:14 -0400
In-Reply-To: <1218278487.5571.6.camel@hidalgo>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: linux-acpi@vger.kernel.org

On Saturday, 9 of August 2008, Yves-Alexis Perez wrote:
> On sam, 2008-08-09 at 12:18 +0200, Yves-Alexis Perez wrote:
> > At resume, first it takes some time before anything appears on the
> > screen, then I guess some scary errors about sda.
> 
> Maybe the right thing to do (tm) would be to open a bug report on kernel
> bugzilla, but I'm not sure against what? ACPI or SATA stuff?

Please first check if the patch from
http://bugzilla.kernel.org/show_bug.cgi?id=11178#c10
fixes the problem for you.

Thanks,
Rafael
