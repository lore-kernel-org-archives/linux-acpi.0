From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Fwd: [Bug 92111] Power regression from 3.17 to 3.18 and 3.19
Date: Wed, 11 Feb 2015 00:48:04 +0000
Message-ID: <20150211004804.GA14264@srcf.ucam.org>
References: <1790277.SYbcblnshn@vostro.rjw.lan>
 <3544719.NIea3H3XJ4@vostro.rjw.lan>
 <20150211004212.GA14030@srcf.ucam.org>
 <1849097.2kV6tt7Itu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41530 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbbBKAsH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Feb 2015 19:48:07 -0500
Content-Disposition: inline
In-Reply-To: <1849097.2kV6tt7Itu@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andreas Noever <andreas.noever@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, attila.jakosa@gmail.com, Len Brown <len.brown@intel.com>

On Wed, Feb 11, 2015 at 02:09:17AM +0100, Rafael J. Wysocki wrote:

> We may be able to get that feedback, but what do you suggest we do in the
> meantime?  Nothing, I suppose?

We have the choice between increased power consumption or broken 
Thunderbolt - either choice is going to upset somebody. My gut feeling 
is that leaving us at increased power consumption might encourage 
someone at Intel to try to fix things, whereas nobody at Intel is going 
to care about Thunderbolt hotplug.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
