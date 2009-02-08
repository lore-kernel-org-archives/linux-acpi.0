From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Problems with Toshiba Satellite L355
Date: Sun, 8 Feb 2009 20:09:38 +0100
Message-ID: <200902082009.38666.rjw@sisk.pl>
References: <200902052311.31794.adam@piggz.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39016 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753096AbZBHTKN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 8 Feb 2009 14:10:13 -0500
In-Reply-To: <200902052311.31794.adam@piggz.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: adam@piggz.co.uk
Cc: linux-acpi@vger.kernel.org

On Friday 06 February 2009, Adam Pigg wrote:
> Hi
> 
> i have 2 acpi related (i think) problems with my satellite l355 which i hope 
> someone can help with.
> 
> 1. /proc/acpi/ac_adapter.../state always show the correct state, but 
> acpi_listen and lshal --monitor dont see any un/plug events.
> 
> 2. The machine will suspend to ram, resume, but after a second suspend, wont 
> resume.
> 
> I think i saw a similar sounding problem on an R500, but it was fixed.

In fact, the problem with the R500 was different and indeed it was fixed.

The problem you're seeing has been reported for a few systems out there, but
we haven't been able to identify the root cause yet.

Still, since quite a few suspend fixes are going to be included into .29-rc4,
please test this kernel when it's out (that should be really soon now).

Thanks,
Rafael
