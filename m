From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Battery info bogus on Lenovo 3000 N100
Date: Mon, 25 Feb 2008 01:18:35 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802250116550.19024@iabervon.org>
References: <alpine.LNX.1.00.0802221232450.19024@iabervon.org> <47BF467C.9070801@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iabervon.org ([66.92.72.58]:49432 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753055AbYBYGSg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Feb 2008 01:18:36 -0500
In-Reply-To: <47BF467C.9070801@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sat, 23 Feb 2008, Alexey Starikovskiy wrote:

> Please open bug report at bugzilla.kernel.org against ACPI/battery.
> Please attach dmesg and acpidump to that bug.
> Please also attach actual /proc/acpi/battery/*/* files.

Okay, it's bug #10094. I'll try to collect a bogus 
/proc/acpi/battery/*/info file with no battery actually present, but I 
don't have that at the moment.

	-Daniel
*This .sig left intentionally blank*
