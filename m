From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: boot regression from rc1 to rc2
Date: Thu, 22 Jan 2009 23:48:22 +0300
Message-ID: <4978DB96.1090104@suse.de>
References: <200901222128.20865.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:39350 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752077AbZAVUsR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Jan 2009 15:48:17 -0500
In-Reply-To: <200901222128.20865.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

Oliver Neukum wrote:
> Hi,
> 
> 2.6.29-rc2 crashes hard during boot on my laptop.
> I've bisected it down to commit c6cb0e878446c79f42e7833d7bb69ed6bfbb381f
> ACPI: EC: Don't trust ECDT tables from ASUS
> 
> The laptop boots with "acpi=off".
> 
> 	Regards
> 		Oliver
Hi,
Mea culpa, patch is here:
http://bugzilla.kernel.org/show_bug.cgi?id=12493

Regards,
Alex.

