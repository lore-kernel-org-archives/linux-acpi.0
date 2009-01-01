From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH, resend] misc: Add dell-wmi driver for hotkey control
Date: Wed, 31 Dec 2008 19:14:04 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812311912390.3854@localhost.localdomain>
References: <20081228153128.GC13424@srcf.ucam.org>
 <20081230155035.8224ca86.akpm@linux-foundation.org>
 <20081231001445.GA23563@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:60044 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141AbZAAAOJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Dec 2008 19:14:09 -0500
In-reply-to: <20081231001445.GA23563@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org


> > One wonders whether this driver should really live in drivers/input/?

It will live in drivers/platform/x86, per the earlier patch series
that moved the platform drivers out of drivers/misc.

thanks,
-- Len Brown, Intel Open Source Technology Center


