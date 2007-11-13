From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [RFC] EC registers - Adding sysfs interface?
Date: Tue, 13 Nov 2007 21:54:51 +0300
Message-ID: <4739F2FB.9080800@suse.de>
References: <200711131724.31868.carlos@strangeworlds.co.uk> <4739EFB0.7080507@suse.de> <200711131849.56964.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:57605 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753389AbXKMSyy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Nov 2007 13:54:54 -0500
In-Reply-To: <200711131849.56964.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org

Carlos Corbacho wrote:
> Alexey,
> 
> 2) I'm toying with the idea of re-implementing acer_acpi as a userspace 
> application (which also requires EC access for certain functions - I don't 
> mind poking /dev/ports for the odd bit of reverse engineering, but for any 
> other kind of normal usage access to the EC, I really wouldn't want to be 
> poking in /dev/ports and tripping over the EC kernel driver).
What is the benefit of having acer_acpi in userspace, rather than one more 
*-laptop in /devices/misc?
