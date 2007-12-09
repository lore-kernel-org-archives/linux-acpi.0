From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend to RAM failure on t61p
Date: Sun, 9 Dec 2007 14:53:38 +0100
Message-ID: <200712091453.38635.rjw@sisk.pl>
References: <20071209011928.c9873c66.akpm@linux-foundation.org> <475BE227.2040003@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42788 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905AbXLINel (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 9 Dec 2007 08:34:41 -0500
In-Reply-To: <475BE227.2040003@dbservice.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org

On Sunday, 9 of December 2007, Tomas Carnecky wrote:
> Andrew Morton wrote:
> > 2.6.24-rc4 on a Lenovo t61p, using FC8 config.
> > 
> > echo mem > /sys/power/state while running X.
> > 
> > It appears to suspend OK but then it instantly resumes and runs
> > OK except the display is blank.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=9258

Yeah.

If you have a box on which the issue is visible, please add a comment in there.

> I have a X61 tablet, and the screen is blank after resume, too, but
> pressing ctrl+alt+F1/F7 usually fixes it. It seems a problem with the X
> video driver. I'm not sure though.

s2ram has a chance to work around this.

Greetings,
Rafael
