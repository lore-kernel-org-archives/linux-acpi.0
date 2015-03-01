From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: ACPI regression with 3.19+
Date: Sun, 01 Mar 2015 01:00:35 +0100
Message-ID: <1674953.ShOInfAyGW@vostro.rjw.lan>
References: <54F18BD9.8040200@punnoor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56202 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751434AbbB1XhG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Feb 2015 18:37:06 -0500
In-Reply-To: <54F18BD9.8040200@punnoor.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prakash Punnoor <prakash@punnoor.de>
Cc: jiang.liu@linux.intel.com, rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday, February 28, 2015 10:35:21 AM Prakash Punnoor wrote:
> This is a multi-part message in MIME format.
> --------------080704070901080904040008
> Content-Type: text/plain; charset=utf-8
> Content-Transfer-Encoding: 7bit
> 
> Hallo,
> 
> my system won't boot with current GIT kernel (see attached screenshot).
> The system seems somewhat frozen (cannot ssh into it), but magic sysrq
> still works. I bisected the problem to commit
> 593669c2ac0fe18baee04a3cd5539a148aa48574.

Thanks for reporting, we're working on it.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
