From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: 2.6.25 regression: powertop says 120K wakeups/sec
Date: Fri, 28 Mar 2008 12:13:22 -0700
Message-ID: <924EFEDD5F540B4284297C4DC59F3DEEC83CDD@orsmsx423.amr.corp.intel.com>
References: <20080322202454.9D69DCC0EF@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <20080322173500.7b8b6751.akpm@linux-foundation.org> <200803281201.54380.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:25916 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753037AbYC1TTW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Mar 2008 15:19:22 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200803281201.54380.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

>-----Original Message-----
>From: David Brownell [mailto:david-b@pacbell.net] 
>Sent: Friday, March 28, 2008 12:02 PM
>To: Andrew Morton; Pallipadi, Venkatesh
>Cc: linux-kernel@vger.kernel.org; Rafael J. Wysocki; 
>linux-acpi@vger.kernel.org
>Subject: Re: 2.6.25 regression: powertop says 120K wakeups/sec
>
>On Saturday 22 March 2008, Andrew Morton wrote:
>> On Sat, 22 Mar 2008 13:24:54 -0700 David Brownell 
><david-b@pacbell.net> wrote:
>> 
>> > I noticed this with 2.6.25-rc2 (if not before), and the problem
>> > is still there with 2.6.25-rc6-git (as of this AM).
>
>A 2.6.24 kernel I still had stashed away didn't act odd; the
>problem joined us before 2.6.25-rc1 was tagged.
>

There was a fix that went in recently (one or two days back) that should
have fixed this.
Commit 8e92b6605da989

Can you check with latest git to see whether this is still a problem?

Thanks,
Venki
