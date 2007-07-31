From: Thomas Renninger <trenn@suse.de>
Subject: RE: regression on HP zx1 platform from ACPI autoload modulespatches
Date: Wed, 01 Aug 2007 00:27:53 +0200
Message-ID: <1185920873.18821.268.camel@queen.suse.de>
References: <617E1C2C70743745A92448908E030B2A020E3B4F@scsmsx411.amr.corp.intel.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47038 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150AbXGaW15 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 31 Jul 2007 18:27:57 -0400
In-Reply-To: <617E1C2C70743745A92448908E030B2A020E3B4F@scsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Doug Chapman <doug.chapman@hp.com>, Tony Luck <tony.luck@gmail.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-ia64@vger.kernel.org

On Tue, 2007-07-31 at 09:54 -0700, Luck, Tony wrote:
> > Tony, it looks like the patch has not hit Linus tree yet:
> 
> 
> Huh?  I can see it in his tree via gitweb.  Here's the patch:
> 
> 	http://tinyurl.com/3csnu6
> 
> and the raw "blob" for sba_iommu.c:
> 
> 	http://tinyurl.com/397cy6
> 
> [Scroll down to line 2018 and you'll see the new code in place].
> 
> Something very odd is happening.
My fault. A clean new checkout of the tree has the patch included.
Sorry for the confusion,

   Thomas

