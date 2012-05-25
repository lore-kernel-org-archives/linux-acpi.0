From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] ACPI / PCI: Make _SxD/_SxW check follow ACPI 4.0a spec
Date: Fri, 25 May 2012 15:15:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1205251511170.1907-100000@iolanthe.rowland.org>
References: <4FA0B3BB.1020005@fisher-privat.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:58002 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932226Ab2EYTPN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 May 2012 15:15:13 -0400
In-Reply-To: <4FA0B3BB.1020005@fisher-privat.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Oleksij Rempel (fishor)" <bug-track@fisher-privat.net>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

Oleksij:

Please take a look at this bug report:

	https://bugzilla.kernel.org/show_bug.cgi?id=43278

Apparently your patch breaks wakeup on this machine by preventing the 
USB host controllers from being put into D3.

Alan Stern

