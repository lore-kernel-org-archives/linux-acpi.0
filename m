From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Bugme-new] [Bug 17802] New: touchpad become crazy: disable irq
 21
Date: Wed, 8 Sep 2010 15:58:46 -0700
Message-ID: <20100908225846.GA9405@core.coreip.homeip.net>
References: <bug-17802-10286@https.bugzilla.kernel.org/>
 <20100908153201.91dc03d2.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36021 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756597Ab0IHW6z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Sep 2010 18:58:55 -0400
Received: by gxk23 with SMTP id 23so345518gxk.19
        for <linux-acpi@vger.kernel.org>; Wed, 08 Sep 2010 15:58:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100908153201.91dc03d2.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, x86@kernel.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, polhallen@fuckaround.org

On Wed, Sep 08, 2010 at 03:32:01PM -0700, Andrew Morton wrote:
> 
> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).
> 
> On Sun, 5 Sep 2010 11:47:41 GMT
> bugzilla-daemon@bugzilla.kernel.org wrote:
> 
> > https://bugzilla.kernel.org/show_bug.cgi?id=17802
> > 
> >            Summary: touchpad become crazy: disable irq 21
> >            Product: Other
> >            Version: 2.5
> >           Platform: All
> >         OS/Version: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: high
> >           Priority: P1
> >          Component: Other
> >         AssignedTo: other_other@kernel-bugs.osdl.org
> >         ReportedBy: polhallen@fuckaround.org
> 
> heh.
> 
> >         Regression: No
> > 
> > 
> > Hi
> > on macbook 4.1 (kernel 2.6.31.12) often the touchpad become crazy and irq 21 is
> > disable, in syslog I see:

Hmm, by touchpad being crazy you mean the pointer jumps around in X? Does
the touchpad driver use IRQ 21?

-- 
Dmitry
