From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [RFC] EC registers - Adding sysfs interface?
Date: Tue, 13 Nov 2007 18:49:56 +0000
Message-ID: <200711131849.56964.carlos@strangeworlds.co.uk>
References: <200711131724.31868.carlos@strangeworlds.co.uk> <4739EFB0.7080507@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:58482 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759308AbXKMSu3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Nov 2007 13:50:29 -0500
In-Reply-To: <4739EFB0.7080507@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: linux-acpi@vger.kernel.org

Alexey,

On Tuesday 13 November 2007 18:40:48 Alexey Starikovskiy wrote:
> I think it is better to do it in file system that allows seek(). So you
> could do with 1 file instead of 256 of them.

Fair enough.

> Carlos, I don't like the idea of 256 files. This will consume too many
> resources and will not bring much value. If you want to have something
> permanent, it should be slim and fast. If we talk about some
> debug/research/RE, do it as you like, but don't ask for submission into
> kernel :)

Two reasons:

1) Yes, the obvious reverse engineering (being well behaved when reading EC 
registers, without doing strange things to ACPI when it also wants to call 
the EC - I've had at least one report where going through /dev/ports on an 
Acer laptop managed to cause the keyboard to lockup, until the system was 
reset).

2) I'm toying with the idea of re-implementing acer_acpi as a userspace 
application (which also requires EC access for certain functions - I don't 
mind poking /dev/ports for the odd bit of reverse engineering, but for any 
other kind of normal usage access to the EC, I really wouldn't want to be 
poking in /dev/ports and tripping over the EC kernel driver).

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
