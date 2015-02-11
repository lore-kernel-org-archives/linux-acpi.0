From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Fwd: [Bug 92111] Power regression from 3.17 to 3.18 and 3.19
Date: Wed, 11 Feb 2015 02:05:05 +0000
Message-ID: <20150211020505.GA16398@srcf.ucam.org>
References: <1790277.SYbcblnshn@vostro.rjw.lan>
 <3901843.GxiEPZOTU6@vostro.rjw.lan>
 <20150211014306.GA15848@srcf.ucam.org>
 <1910334.cCyQdZ49eW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:42018 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbbBKCFJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Feb 2015 21:05:09 -0500
Content-Disposition: inline
In-Reply-To: <1910334.cCyQdZ49eW@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andreas Noever <andreas.noever@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, attila.jakosa@gmail.com, Len Brown <len.brown@intel.com>

On Wed, Feb 11, 2015 at 03:26:35AM +0100, Rafael J. Wysocki wrote:

> In order to "identify the root cause" it is pretty much necessary to know
> what _OSI("Darwin") causes the firmware to actually do and the only party
> knowing that is Apple.  The only question I can ask hardware people is what
> it *theoretically* may be doing to trigger the observed behavior and
> honestly I doubt I'll get a useful answer to that.

The hardware has a fixed set of inputs that influence whether it enters 
PC6. If we know what those are then we can identify which is actually at 
play here, which gives us a high probability of identifying the root 
cause.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
