From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: New: After Hibernation the battery charging information is not working any more.
Date: Mon, 28 Jan 2008 23:19:13 +0100
Message-ID: <200801282319.13950.rjw@sisk.pl>
References: <bug-9835-10286@http.bugzilla.kernel.org/> <200801281834.36823.rjw@sisk.pl> <20080128182935.GA7136@vzsze.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37149 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763754AbYA1WV2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Jan 2008 17:21:28 -0500
In-Reply-To: <20080128182935.GA7136@vzsze.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rolf Kutz <rk@vzsze.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, bugme-daemon@bugzilla.kernel.org

On Monday, 28 of January 2008, Rolf Kutz wrote:
> On 28/01/08 18:34 +0100, Rafael J. Wysocki wrote:
> >On Monday, 28 of January 2008, Rolf Kutz wrote:
> >> On 28/01/08 17:34 +0100, Rafael J. Wysocki wrote:
> >> >On Monday, 28 of January 2008, Rolf Kutz wrote:
> >> >> On 28/01/08 17:06 +0100, Rafael J. Wysocki wrote:
> >> >> >On Monday, 28 of January 2008, Rolf Kutz wrote:
> >> >> >> On 28/01/08 16:16 +0100, Rafael J. Wysocki wrote:
> >> >> >> >On Monday, 28 of January 2008, Rolf Kutz wrote:
> >> >> >
> >> >> >Would you be able to install git and use it for downloading kernel sources?
> >> >> 
> >> >> Yes, I can install it, but I'm not familiar with it.
> >> >
> >> >No problem.  http://linux.yyz.us/git-howto.html#getting_started should be
> >> >sufficient for starters and I'll tell you what to do next.
> >> 
> >> Installed git and pulled Linus tree, like described in the howto.
> >
> >OK, thanks.
> >
> >We're going to carry out a bisection over several commits.
> >
> >Please go to the linux-2.6 directory and do:
> >
> >$ git checkout 88fb61e4ba263685a0d5b82c7e9cd6f22a9e6a9d
> >
> >Then, compile the kernel and test it.
> 
> Done, the regression is still there.

Hm, there are no ACPI patches between -rc7 and this one ...

(in the linux-2.6 directory) please do

$ git checkout 3ce54450461bad18bbe1f9f5aa3ecd2f8e8d1235

(this should be 2.6.24-rc7, actually) and try to build and test this kernel.

Thanks,
Rafael
