From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH 1/2] suspend: Move NVS save/restore code to generic
 suspend functionality
Date: Wed, 02 Jun 2010 01:46:50 +0300
Message-ID: <1275432410.6733.4.camel@maxim-laptop>
References: <1275416390.3778.7.camel@maxim-laptop>
	 <201006012331.59747.rjw@sisk.pl> <1275429125.5573.7.camel@maxim-laptop>
	 <201006020040.22429.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:64411 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755791Ab0FAWqy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Jun 2010 18:46:54 -0400
Received: by fg-out-1718.google.com with SMTP id l26so1413293fgb.1
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jun 2010 15:46:52 -0700 (PDT)
In-Reply-To: <201006020040.22429.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Alan Stern <stern@rowland.harvard.edu>

On Wed, 2010-06-02 at 00:40 +0200, Rafael J. Wysocki wrote: 
> On Tuesday 01 June 2010, Maxim Levitsky wrote:
> > On Tue, 2010-06-01 at 23:31 +0200, Rafael J. Wysocki wrote: 
> > > On Tuesday 01 June 2010, Maxim Levitsky wrote:
> > > > Saving platform non-volatile state may be required for suspend to RAM as
> > > > well as hibernation. Move it to more generic code.
> > > > 
> > > > Signed-off-by: Matthew Garrett <mjg@redhat.com>
> > > > Signed-off-by: Matthew Garrett <maximlevitsky@gmail.com>
> > > 
> > > You made a mistake here.
> > > 
> > > Also, why are you resending the Matthews patches?  I think Len has seen them
> > > already.
> > Yea, a copypaste.
> > 
> > (I was told that if one submits modified patch, it adds his
> > Signed-off-by.)
> > 
> > I rebased these on top of 
> > ACPI / EC / PM: Fix race between EC transactions and system suspend'
> > 
> > To be honest, I just want to get some feedback on this.
> > This was major issue that kept me from using otherwise prefect suspend
> > to ram.
> 
> I think this is a change we should try, but there is a chance it will break
> some systems.
I doubt that. BIOSes are tested against windows, and since it has this
behavior, all systems this patch could break wouldn't work in windows
ether.

I was doing all kinds of attempts to fix this bug, and finally I found
the cause for it.

Best regards,
Maxim Levitsky

