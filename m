From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/4] fujitsu-laptop: driver [un]registration fixes
Date: Fri, 28 Aug 2009 14:56:49 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908281455010.23436@localhost.localdomain>
References: <200907310846.n6V8k2nd006757@mercury.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:48593 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719AbZH1S5E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 14:57:04 -0400
In-reply-to: <200907310846.n6V8k2nd006757@mercury.physics.adelaide.edu.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, bzolnier@gmail.com

On Fri, 31 Jul 2009, Jonathan Woithe wrote:

> [PATCH 3/4] fujitsu-laptop: driver [un]registration fixes
> 
> >From Bartlomiej Zolnierkiewicz.

This line needs to be the 1st in the message for the attribution
to work correctly, and it needs to follow this format:

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> * Move led_classdev_unregister() calls from fujitsu_cleanup() to
>   acpi_fujitsu_hotkey_remove().

i fixed it manually and applied for 2.6.32.

thanks,
-Len Brown, Intel Open Source Technology Center

