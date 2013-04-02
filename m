From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo
 ThinkPads
Date: Tue, 02 Apr 2013 21:44:07 +0800
Message-ID: <515AE0A7.2070707@intel.com>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com> <20130211175213.GA25139@srcf.ucam.org> <20130211190617.GH13768@thinkpad-t410> <20130211190914.GA27364@srcf.ucam.org> <20130213203228.GE22867@thinkpad-t410> <20130213205558.GA16559@srcf.ucam.org> <20130307193812.GD24233@thinkpad-t410> <20130318212546.GC3964@thinkpad-t410> <515A6A10.70404@bjencks.net> <515AA197.7020601@intel.com> <20130402112328.GA23248@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15513 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760784Ab3DBNnI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Apr 2013 09:43:08 -0400
In-Reply-To: <20130402112328.GA23248@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Ben Jencks <ben@bjencks.net>, Seth Forshee <seth.forshee@canonical.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, joeyli <jlee@suse.com>

On 04/02/2013 07:23 PM, Matthew Garrett wrote:
> On Tue, Apr 02, 2013 at 05:15:03PM +0800, Aaron Lu wrote:
> 
>> Perhaps we can introduce a _BCM quirk function, with a DMI table for
>> these systems.
> 
> No. Really, plesae no.
> 

I would like to know why, care to explain?

Thanks,
Aaron
