From: Andi Kleen <andi@firstfloor.org>
Subject: Re: 2.6.27-rc1: critical thermal shutdown on thinkpad x60
Date: Tue, 12 Aug 2008 12:54:09 +0200
Message-ID: <20080812105409.GA1366@one.firstfloor.org>
References: <20080806090246.GA1572@elf.ucw.cz> <87bq046cht.fsf@basil.nowhere.org> <20080812094135.GA1565@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:53473 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbYHLKw7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Aug 2008 06:52:59 -0400
Content-Disposition: inline
In-Reply-To: <20080812094135.GA1565@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Andi Kleen <andi@firstfloor.org>, kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>

On Tue, Aug 12, 2008 at 11:41:35AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > Aug  6 11:00:10 amd kernel: ACPI: Critical trip point
> > > Aug  6 11:00:10 amd kernel: Critical temperature reached (128 C),
> > > shutting down.
> > > Aug  6 11:00:10 amd shutdown[24414]: shutting down for system halt
> > >
> > > ...and machine went down at that point :-(.
> > 
> > I hope you can easily reproduce it?
> > 
> > So it's new in 2.6.27rc1 and wasn't in 2.6.26? Can you please
> 
> Yes, I'm very sure. It makes machine basically unusable.

Does this mean you can easily reproduce it?  
Please do a bisect then. 

> Not that one :-(. Thinkpad does not even have fan device: it is
> controlled by hardware.

Ok it was just a long shot anyways.

-Andi
