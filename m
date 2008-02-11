From: "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl>
Subject: Re: 2.6.25-rc1 regression - suspend to ram
Date: Tue, 12 Feb 2008 00:10:54 +0100
Message-ID: <200802120010.55021.Rafal.Wysocki@fuw.edu.pl>
References: <20080211225811.GB4343@ics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.fuw.edu.pl ([193.0.80.14]:35347 "EHLO mail.fuw.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362AbYBKXMl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Feb 2008 18:12:41 -0500
In-Reply-To: <20080211225811.GB4343@ics.muni.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Cc: linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, venkatesh.pallipadi@intel.com

On Monday, 11 of February 2008, Lukas Hejtmanek wrote:
> Hello,

Hi,
 
> 2.6.25-rc1 takes really long time till it suspends (about 30-40secs, used to
> be about 5 secs at all) and it is resuming about few minutes.  While resuming,
> capslock toggles the capslock led but with few secs delay.
> 
> 2.6.24-git15 was OK. 2.6.24 is OK.
> 
> I have Lenovo ThinkPad T61.

If you have CONFIG_CPU_IDLE set, please try to boot with idle=poll and see if
that helps.

Thanks,
Rafael
