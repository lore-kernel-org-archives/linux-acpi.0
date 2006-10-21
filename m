From: Werner LEMBERG <wl@gnu.org>
Subject: Re: ACPI and CDROM problems
Date: Sat, 21 Oct 2006 17:11:46 +0200 (CEST)
Message-ID: <20061021.171146.173383997.wl@gnu.org>
References: <20061021.065827.78720699.wl@gnu.org>
	<200610211604.57803.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.183]:32205 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S2993102AbWJUPMJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Oct 2006 11:12:09 -0400
In-Reply-To: <200610211604.57803.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-acpi@vger.kernel.org


> > I have an inspiron 6400 (running SuSE 10.0), using kernel 2.6.18
> > (unmodified) together with harddisk suspend.  This laptop showed
> > severe problems at resuming with 2.6.17 (about 1 out of 5 resumes
> > failed).  Now, with 2.6.18, about 1 out of 30 doesn't work.
> >
> > It takes about 20 seconds, then a normal reboot happens.
> 
> I assume this is the suspend to RAM that doesn't work?

I have never tried suspend to RAM.  I only use suspend to disk.

> Have you tried using swsusp (suspend to disk)?

No, and I'm too lazy to try that.  I'm writing to this list so that I
can help in fixing problems.  For example, I could compile and run a
newer kernel in case this is of benefit.  As mentioned before, I just
need advice which kind of data, setup, etc., you need so that I
produce valuable information.


    Werner
