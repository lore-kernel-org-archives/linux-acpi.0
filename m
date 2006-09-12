From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] - restore i8259A eoi status on resume
Date: Tue, 12 Sep 2006 14:11:36 +0200
Message-ID: <200609121411.36913.ak@suse.de>
References: <20060910141533.GA6594@srcf.ucam.org> <20060912091906.GB19482@elf.ucw.cz> <20060912124742.GB31344@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:59801 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030237AbWILNgd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Sep 2006 09:36:33 -0400
In-Reply-To: <20060912124742.GB31344@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tuesday 12 September 2006 14:47, Matthew Garrett wrote:
> On Tue, Sep 12, 2006 at 11:19:06AM +0200, Pavel Machek wrote:
> > Hi!
> >
> > > Got it. i8259A_resume calls init_8259A(0) unconditionally, even if
> > > auto_eoi has been set. Keep track of the current status and restore
> > > that on resume. This fixes it for AMD64 and i386.
> >
> > Patch looks okay to me...
>
> Cool. Andi, does it look sane to you? I'm not really sure who to wave
> 8259 code at...

Yes. I already have it queued for .19 at least. Not sure it's critical enough 
for .18, especially since it doesn't seem to be a regression.

-Andi
