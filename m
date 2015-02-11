From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Fwd: [Bug 92111] Power regression from 3.17 to 3.18 and 3.19
Date: Wed, 11 Feb 2015 00:26:02 +0000
Message-ID: <20150211002601.GA13363@srcf.ucam.org>
References: <1790277.SYbcblnshn@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41260 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbbBKA0G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Feb 2015 19:26:06 -0500
Content-Disposition: inline
In-Reply-To: <1790277.SYbcblnshn@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andreas Noever <andreas.noever@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, attila.jakosa@gmail.com

On Wed, Feb 11, 2015 at 01:29:36AM +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> The _OSI("Darwin") support seems to break CPU power management for Attila.
> 
> Is there anything we can possibly do about that?

Hm. It's not clear to me what the bug is describing. If we're not waking 
up more frequently, why aren't we entering PC6?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
