From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo
 ThinkPads
Date: Tue, 2 Apr 2013 12:23:28 +0100
Message-ID: <20130402112328.GA23248@srcf.ucam.org>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com>
 <20130211175213.GA25139@srcf.ucam.org>
 <20130211190617.GH13768@thinkpad-t410>
 <20130211190914.GA27364@srcf.ucam.org>
 <20130213203228.GE22867@thinkpad-t410>
 <20130213205558.GA16559@srcf.ucam.org>
 <20130307193812.GD24233@thinkpad-t410>
 <20130318212546.GC3964@thinkpad-t410>
 <515A6A10.70404@bjencks.net>
 <515AA197.7020601@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:32796 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753921Ab3DBLXl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Apr 2013 07:23:41 -0400
Content-Disposition: inline
In-Reply-To: <515AA197.7020601@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Ben Jencks <ben@bjencks.net>, Seth Forshee <seth.forshee@canonical.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, joeyli <jlee@suse.com>

On Tue, Apr 02, 2013 at 05:15:03PM +0800, Aaron Lu wrote:

> Perhaps we can introduce a _BCM quirk function, with a DMI table for
> these systems.

No. Really, plesae no.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
