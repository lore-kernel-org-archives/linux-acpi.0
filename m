From: David Brownell <david-b@pacbell.net>
Subject: Re: 2.6.25 regression: powertop says 120K wakeups/sec
Date: Fri, 28 Mar 2008 12:44:26 -0700
Message-ID: <200803281244.27012.david-b@pacbell.net>
References: <20080322202454.9D69DCC0EF@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <200803281201.54380.david-b@pacbell.net> <924EFEDD5F540B4284297C4DC59F3DEEC83CDD@orsmsx423.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:26987 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753931AbYC1Toc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Mar 2008 15:44:32 -0400
In-Reply-To: <924EFEDD5F540B4284297C4DC59F3DEEC83CDD@orsmsx423.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Friday 28 March 2008, Pallipadi, Venkatesh wrote:

> >> > I noticed this with 2.6.25-rc2 (if not before), and the problem
> >> > is still there with 2.6.25-rc6-git (as of this AM).
> >
> >A 2.6.24 kernel I still had stashed away didn't act odd; the
> >problem joined us before 2.6.25-rc1 was tagged.
> >
> 
> There was a fix that went in recently (one or two days back) that should
> have fixed this.
> Commit 8e92b6605da989
> 
> Can you check with latest git to see whether this is still a problem?

The problem is still there in GIT as of this morning, which
includes 8e92b6605da989 ...

Comments on why bc71bec91f9875ef825d12104acf3bf4ca215fa4 seems
to be causing this?  I think it's just bad reports getting to
userspace, rather than an actual 120K wakeups/second.  (The
report is of course not always 120K, but it's usually in that
range.)

- Dave
