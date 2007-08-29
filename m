From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [Bugme-new] [Bug 8958] New: regression: fan doesn't work anymore
Date: Thu, 30 Aug 2007 01:37:28 +0200
Message-ID: <6bffcb0e0708291637p22c4e9bej74ed69f3a0e93cb3@mail.gmail.com>
References: <bug-8958-10286@http.bugzilla.kernel.org/>
	 <20070829163321.25f5f32d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:43633 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754934AbXH2Xh3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Aug 2007 19:37:29 -0400
Received: by wa-out-1112.google.com with SMTP id v27so386610wah
        for <linux-acpi@vger.kernel.org>; Wed, 29 Aug 2007 16:37:28 -0700 (PDT)
In-Reply-To: <20070829163321.25f5f32d.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>, bugme-daemon@bugzilla.kernel.org, linux-acpi@vger.kernel.org

On 30/08/2007, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Wed, 29 Aug 2007 13:47:36 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:
>
> > http://bugzilla.kernel.org/show_bug.cgi?id=8958
> >
> >            Summary: regression: fan doesn't work anymore
> >            Product: ACPI
> >            Version: 2.5
> >      KernelVersion: 2.6.23-rc4
> >           Platform: All
> >         OS/Version: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: blocking
> >           Priority: P1
> >          Component: Other
> >         AssignedTo: acpi_other@kernel-bugs.osdl.org
> >         ReportedBy: daniel.ritz@gmx.ch
> >
> >
> > Most recent kernel where this bug did not occur: 2.6.23-rc2 (maybe rc3)
> > Distribution: ubuntu
> > Hardware Environment: Toshiba Tecra 8000 Laptop (P3)
> > Software Environment:
> > Problem Description:
> > the fan doesn't work any more...isected it to that one:
> >
> > cd8c93a4e04dce8f00d1ef3a476aac8bd65ae40b is first bad commit
> > commit cd8c93a4e04dce8f00d1ef3a476aac8bd65ae40b
> > Author: Alexey Starikovskiy <astarikovskiy@suse.de>
> > Date:   Fri Aug 3 17:52:48 2007 -0400
> >
> >     ACPI: EC: If ECDT is not found, look up EC in DSDT.
> >
> >     Some ASUS laptops access EC space from device _INI methods, but do not
> >     provide ECDT for early EC setup. In order to make them function properly,
> >     there is a need to find EC is DSDT before any _INI is called.
> >
> >     Similar functionality was turned on by acpi_fake_ecdt=1 command line
> >     before. Now it is on all the time.
> >
> >     http://bugzilla.kernel.org/show_bug.cgi?id=8598
> >
> >     Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> >     Signed-off-by: Len Brown <len.brown@intel.com>
> > Steps to reproduce: boot (or try to)
> >
>
> I'm not sure that I understand this report ;)
>
> Michal, pleas track it as a post-2.6.22 regression.

I'm tracking this already

Subject         : the fan doesn't work any more
References      : http://lkml.org/lkml/2007/8/28/359
Last known good : ?
Submitter       : Daniel Ritz <daniel.ritz-ml@swissonline.ch>
Caused-By       : Alexey Starikovskiy <astarikovskiy@suse.de>
                  commit cd8c93a4e04dce8f00d1ef3a476aac8bd65ae40b
Handled-By      : Alexey Starikovskiy <astarikovskiy@suse.de>
Patch           : http://lkml.org/lkml/2007/8/29/15
Status          : patch was suggested

>
> Daniel, if you have a patch which you think is needed for 2.6.23 can
> you please send it?
>

Status          : patch was suggested

Regards,
Michal

-- 
LOG
http://www.stardust.webpages.pl/log/
