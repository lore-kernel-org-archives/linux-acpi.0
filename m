From: Len Brown <lenb@kernel.org>
Subject: Re: HP Compaq nc6320 - Booting on battery power causes softlock
Date: Tue, 16 Jan 2007 22:15:34 -0500
Message-ID: <200701162215.34627.lenb@kernel.org>
References: <1169002596.29755.5.camel@localhost> <3877989d0701161904u6ef2b931t99b79d92dd974f2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50040 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751990AbXAQDQ5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jan 2007 22:16:57 -0500
In-Reply-To: <3877989d0701161904u6ef2b931t99b79d92dd974f2a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luming Yu <luming.yu@gmail.com>
Cc: Peter Clifton <pcjc2@cam.ac.uk>, linux-acpi@vger.kernel.org

try also "apm=off" -- since the ACPI/APM dependency checking
is currently broken in some configs.

On Tuesday 16 January 2007 22:04, Luming Yu wrote:
> The first thing is to make sure you are running the latest bios, kernel.
> Then, you need to sort out the kernel component/modules/drivers that
> cause the problem.
> If you guess it is ACPI issue, pleas test boot option acpi=off to see
> if the problem goes away. If you guess it is battery issue, please
> remove battery module, etc.
> Please don't forget to enter a bug in bugzilla.kernel.org.
> 
> Thanks,
> Luming
> 
> On 1/17/07, Peter Clifton <pcjc2@cam.ac.uk> wrote:
> > Hi, I've got an issue with my HP Compaq nc6320, where it won't boot off
> > its battery without softlocking on CPU#0. I remember it booting ok off
> > battery occasionally in the past, but once I've seen the fault - the
> > only way I can get it to boot is off AC. (I usually boot off AC anyway).
> >
> > I'm presuming ACPI as a good starting point, since that is an area where
> > AC / Battery may make a difference.
> >
> > Can anyone suggest a debugging procedure to identify the cause of a
> > softlock, and where would be appropriate (which category) to file a
> > kernel bug for this?
> >
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
