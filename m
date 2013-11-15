From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [v3.11][3.12][Regression]  ACPI / processor: Use common hotplug infrastructure
Date: Fri, 15 Nov 2013 23:55:10 +0100
Message-ID: <19794987.1PROc0XFg1@vostro.rjw.lan>
References: <52865D6B.1080902@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51797 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752930Ab3KOWmh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Nov 2013 17:42:37 -0500
In-Reply-To: <52865D6B.1080902@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joseph Salisbury <joseph.salisbury@canonical.com>
Cc: rafael.j.wysocki@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Friday, November 15, 2013 12:44:11 PM Joseph Salisbury wrote:
> Hi Rafael,
> 
> A kernel bug affecting several users was opened against Ubuntu[0]. 
> After a bisect, it was found the following commit introduced the regression:
> 
> commit ac212b6980d8d5eda705864fc5a8ecddc6d6eacc
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date: Fri May 3 00:26:22 2013 +0200
> 
>     ACPI / processor: Use common hotplug infrastructure
> 
> The regression was introduced as of v3.11-rc1.
> 
> This commit doesn't revert cleanly in 3.12, and requires the revert of
> other commits as well.  I wanted to get your feedback since you are the
> author.

Well, that commit has nothing to do with PCMCIA, so I'm not sure how the
breakage is related to it.

Moreover, comment #8 reports 3.11.0-11.17 as working and the change you're
asking about should be in that kernel as well.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
