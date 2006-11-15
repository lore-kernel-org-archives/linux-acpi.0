From: Thomas Renninger <trenn@suse.de>
Subject: Re: 2.6.19-rc4 shutting down with overheat
Date: Wed, 15 Nov 2006 19:09:42 +0100
Message-ID: <1163614183.4035.471.camel@queen.suse.de>
References: <200611071530.03919.oliver@neukum.name>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:725 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030795AbWKOSJo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Nov 2006 13:09:44 -0500
In-Reply-To: <200611071530.03919.oliver@neukum.name>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.name>
Cc: linux-acpi@vger.kernel.org

On Tue, 2006-11-07 at 15:29 +0100, Oliver Neukum wrote:
> Hi,
> 
> with 2.6.19-rc4 my laptop reports an overheat during boot and shuts right back down.
> I am using the fixed DSDT for the Ferrari 4000 from sourceforge. The fan stays at the
> lowest setting all the time.

Why do you use an own DSDT? Better get rid of that one first.
There was a battery reading problem that could get fixed by a custom
DSDT for the Ferrari, but this has been solved in kernel long ago.

   Thomas

