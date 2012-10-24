From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: Simplify conditional that has the same effect no matter what.
Date: Wed, 24 Oct 2012 23:23:16 +0200
Message-ID: <6462005.8SNo4NKuVs@vostro.rjw.lan>
References: <alpine.DEB.2.02.1210221738310.5975@oneiric> <20121023022727.GA13880@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:35474 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161209Ab2JXVTV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Oct 2012 17:19:21 -0400
In-Reply-To: <20121023022727.GA13880@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Tuesday 23 of October 2012 03:27:27 Matthew Garrett wrote:
> On Mon, Oct 22, 2012 at 05:40:36PM -0400, Robert P. J. Day wrote:
> 
> >   not sure if there's something weirdly subtle happening here, but
> > this looks like a straightforward simplification.
> 
> There is - it provides a hint to lockdep, but it should probably have a 
> comment explaining it. See 
> https://bugzilla.kernel.org/show_bug.cgi?id=14553 

I wonder if it still is needed, though?  The way it worked was by providing
a different key for the work item depending on which workqueue was to be
used, but now we don't do anything like this any more.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
