From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [Bugme-new] [Bug 8886] New: No more battery info with 2.6.23 kernels
Date: Tue, 14 Aug 2007 08:39:45 +0200
Message-ID: <6bffcb0e0708132339j7e25fd3bibbd20a33e8f90ff4@mail.gmail.com>
References: <bug-8886-10286@http.bugzilla.kernel.org/>
	 <20070813201753.90481089.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:65288 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757691AbXHNGjq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Aug 2007 02:39:46 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2080272wah
        for <linux-acpi@vger.kernel.org>; Mon, 13 Aug 2007 23:39:46 -0700 (PDT)
In-Reply-To: <20070813201753.90481089.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, casteyde.christian@free.fr

On 14/08/07, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Mon, 13 Aug 2007 09:14:11 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:
>
> > http://bugzilla.kernel.org/show_bug.cgi?id=8886
> >
> >            Summary: No more battery info with 2.6.23 kernels
> >            Product: ACPI
> >            Version: 2.5
> >      KernelVersion: 2.6.23-rc3
> >           Platform: All
> >         OS/Version: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: Power-Battery
> >         AssignedTo: acpi_power-battery@kernel-bugs.osdl.org
> >         ReportedBy: casteyde.christian@free.fr
> >
> >
> > Most recent kernel where this bug did not occur: 2.6.22.x
> > Distribution: Slackware 12
> > Hardware Environment: Athlon64 3000 + nForce3 150 on Aspire 1511 LMi
> > Software Environment: none
> > Problem Description:
> > With recent kernels (2.6.23-rc3, maybe 2.6.23-rc2 but I'm not sure), the
> > battery information is not available anymore on some laptops.
> > Dmesg info for different kernel versions appended.
> >
> > Steps to reproduce:
> > Maybe specific to my hardware. It used to have a DSDT replacement for old
> > kernels (2.6.16 for instance), but since 2.6.19 up to 2.6.22 it was not
> > necessary. Now, it does work with neither original nor fixed DSDT.
> >
>
> Michal, please track this as a post-2.6.22 regression, thanks.
>

Seems to be the same as

Subject         : regression from 2.6.23-rc2 to -rc3 BAT missing
References      : http://lkml.org/lkml/2007/8/13/661
Last known good : ?
Submitter       : Norbert Preining <preining@logic.at>
Caused-By       : ?
Handled-By      : ?
Status          : unknown

Regards,
Michal

-- 
LOG
http://www.stardust.webpages.pl/log/
