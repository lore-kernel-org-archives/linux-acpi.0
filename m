From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: gpe patches vs ACPICA updates
Date: Thu, 8 Jul 2010 00:33:37 +0200
Message-ID: <201007080033.37195.rjw@sisk.pl>
References: <alpine.LFD.2.00.1007062304560.5977@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:32840 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757936Ab0GGWfN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Jul 2010 18:35:13 -0400
In-Reply-To: <alpine.LFD.2.00.1007062304560.5977@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Wednesday, July 07, 2010, Len Brown wrote:
> Rafael,
> Bob and Lin-Ming sucked a bunch of your patches into ACPICA.
> 
> However, there are text changes, so some of your subsequent
> patches, no longer cleanly apply.
> 
> In particular, these no longer apply if ACPICA is underneath:

OK, I'll rebase them on top of your test branch and resend them in a while.

> commit 9227a22eb1dadbc746b9792c26a311f6eb49b86b
> Author: Rafael J. Wysocki <rjw@sisk.pl>
> Date:   Mon Jul 5 00:59:12 2010 +0200
> 
>     ACPI / ACPICA: Do not execute _PRW methods during initialization
> 
> commit be6d74ee134c5c01d8c0537924ab76aefc0b1201
> Author: Rafael J. Wysocki <rjw@sisk.pl>
> Date:   Mon Jul 5 01:00:49 2010 +0200
> 
>     ACPI / ACPICA: Simplify acpi_ev_initialize_gpe_block()
> 
> 
> commit b8baccf5c9728c7c15292d833528302c743e5892
> Author: Rafael J. Wysocki <rjw@sisk.pl>
> Date:   Mon Jul 5 01:01:36 2010 +0200
> 
>     ACPI / ACPICA: Fail acpi_gpe_wakeup() if ACPI_GPE_CAN_WAKE is unset

Rafael
