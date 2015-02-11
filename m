From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Fwd: [Bug 92111] Power regression from 3.17 to 3.18 and 3.19
Date: Wed, 11 Feb 2015 01:43:06 +0000
Message-ID: <20150211014306.GA15848@srcf.ucam.org>
References: <1790277.SYbcblnshn@vostro.rjw.lan>
 <4162660.VeBlp9QsD2@vostro.rjw.lan>
 <20150211010150.GA14596@srcf.ucam.org>
 <3901843.GxiEPZOTU6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41931 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbbBKBnL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Feb 2015 20:43:11 -0500
Content-Disposition: inline
In-Reply-To: <3901843.GxiEPZOTU6@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andreas Noever <andreas.noever@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, attila.jakosa@gmail.com, Len Brown <len.brown@intel.com>

On Wed, Feb 11, 2015 at 02:57:48AM +0100, Rafael J. Wysocki wrote:

> Well, it looks like we circled back to http://marc.info/?l=linux-acpi&m=142361557824868&w=4 :-)

Right. And, like I said, if there's a "We're seeing increased power 
consumption" bug then there's an incentive for people from Intel to 
actually help identify the root source, whereas if there's a "We can't 
enable Thunderbolt hotplug on this platform Intel pretend has nothing to 
do with them because otherwise we'll see increased power consumption", 
it's going to be so far down people's list of priorities that it's 
probably not going to happen.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
