From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.24: (ACPI AC adapter) sending {proc,netlink,kobject}_event from -> resume method?
Date: Tue, 30 Oct 2007 22:28:24 +0100
Message-ID: <200710302228.25650.rjw@sisk.pl>
References: <200710302233.31791.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42155 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753657AbXJ3VLe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2007 17:11:34 -0400
In-Reply-To: <200710302233.31791.arvidjaar@mail.ru>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>

On Tuesday, 30 October 2007 20:33, Andrey Borzenkov wrote:
> Is it valid to send events from within ->resume device method?

It is or at least it should be.  The GPEs are supposed to be fully functional
at this point.

> If not, what is the proper way to notify user space about hardware changes
> during suspension?  
> Specifically it seems that new sysfs ACPI power supply interface sometimes 
> missing plugged in AC cord during suspend. I suspect that no event is 
> generated for this; I am not sure whether ACPI is required to generate such 
> events at all in this case.
> 
> I'll need some time to get reproducible case so I do not categorize this yet 
> as regression.

Is the "[2.6.24-rc1 regression] AC adapter state does not change after resume"
message a follow-up to this one?

Rafael
