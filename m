From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] ACPI Lid Issue
Date: Thu, 28 Jan 2010 21:11:25 +0100
Message-ID: <201001282111.25276.rjw@sisk.pl>
References: <36d20d7f1001280848taf92485g53bb3f6061ea414e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39398 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433Ab0A1UKt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Jan 2010 15:10:49 -0500
In-Reply-To: <36d20d7f1001280848taf92485g53bb3f6061ea414e@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robin <diilbert.atlantis@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thursday 28 January 2010, Robin wrote:
> The lid/suspend event works on my Toshiba Satellite A205-S4607 50% of
> the time.  I think it is possible it is an ACPI driver clitch.
> 
> After doing a little research I found out that the current lid state
> is stored at:
> /proc/acpi/button/lid/*/state.
> 
> So I ran some simple tests:
> 
> 1)  After a fresh boot:
> cat /proc/acpi/button/lid/*/state gives me:
> State: open
> 
> 2) Close (successful suspend) and Reopen the lid:
> cat /proc/acpi/button/lid/*/state gives me:
> State: closed
> 
> 3) Close the lid (failure to suspend the laptop) and reopen
> cat /proc/acpi/button/lid/*/state gives me:
> State: open
> 
> 4) Close (successful suspend) and Reopen the lid:
> cat /proc/acpi/button/lid/*/state gives me:
> State: closed
> 
> I repeated this several times to make sure the pattern is consistent.
> 
> Any thoughts?

It's better to ask on the linux-acpi list (CC added).

Rafael
