From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Fwd: [Bug 92111] Power regression from 3.17 to 3.18 and 3.19
Date: Wed, 11 Feb 2015 01:53:26 +0100
Message-ID: <1721194.3W9qJruT3Q@vostro.rjw.lan>
References: <1790277.SYbcblnshn@vostro.rjw.lan> <20150211002601.GA13363@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64576 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752283AbbBKAaW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Feb 2015 19:30:22 -0500
In-Reply-To: <20150211002601.GA13363@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andreas Noever <andreas.noever@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, attila.jakosa@gmail.com

On Wednesday, February 11, 2015 12:26:02 AM Matthew Garrett wrote:
> On Wed, Feb 11, 2015 at 01:29:36AM +0100, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > The _OSI("Darwin") support seems to break CPU power management for Attila.
> > 
> > Is there anything we can possibly do about that?
> 
> Hm. It's not clear to me what the bug is describing. If we're not waking 
> up more frequently, why aren't we entering PC6?

Good question. :-)

The bug is saying, pretty much, that after a positive _OSI response to "Darwin"
we cannot enter PC6 any more on that machine all other things being equal.

