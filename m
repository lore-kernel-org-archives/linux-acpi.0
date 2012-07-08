From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [3.4-rc5 -> 3.4-rc6 regression] Asus P5NSLI: lockup on resume
 from suspend
Date: Sat, 7 Jul 2012 23:30:20 -0500
Message-ID: <20120708043020.GB3986@burratino>
References: <op.wg3en6ij6g6bxc@localhost.localdomain>
 <Pine.LNX.4.44L0.1207072208270.508-100000@netrider.rowland.org>
 <20120708025730.GE2961@burratino>
 <op.wg30yabp6g6bxc@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38499 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab2GHEaZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Jul 2012 00:30:25 -0400
Received: by obbuo13 with SMTP id uo13so18122132obb.19
        for <linux-acpi@vger.kernel.org>; Sat, 07 Jul 2012 21:30:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <op.wg30yabp6g6bxc@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Octavio Alvarez <alvarezp@alvarezp.com>
Cc: Bob Moore <robert.moore@intel.com>, 680707@bugs.debian.org, linux-acpi@vger.kernel.org

Hi Octavio,

Octavio Alvarez wrote:

> The problem is a full system lock-up on resume. The HD led stays on.
> The 5-sec power-button cycle isn't enough to get the system back.
> It requires a full mechanical power cycle from the power supply.
>
> I bisected the problem as requested by Alan Stern, and tracked it
> down to the following commit:
>
> commit 2feec47d4c5f80b05f1650f5a24865718978eea4
> Author: Bob Moore <robert.moore@intel.com>
> Date:   Tue Feb 14 15:00:53 2012 +0800
>
>     ACPICA: ACPI 5: Support for new FADT SleepStatus, SleepControl registers

Please attach "acpidump" output.

Thanks and hope that helps,
Jonathan
