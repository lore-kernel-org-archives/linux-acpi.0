From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [linux-pm] [patch] hibernation: utilize ACPI hardware signature
Date: Thu, 03 Jan 2008 09:52:57 +0800
Message-ID: <1199325177.16176.1.camel@sli10-desk.sh.intel.com>
References: <1199257162.14632.4.camel@sli10-desk.sh.intel.com>
	 <200801020937.13808.maximlevitsky@gmail.com>
	 <1199266193.4172.76.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:1920 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753334AbYACBwm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Jan 2008 20:52:42 -0500
In-Reply-To: <1199266193.4172.76.camel@johannes.berg>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, linux-pm@lists.linux-foundation.org, linux acpi <linux-acpi@vger.kernel.org>


On Wed, 2008-01-02 at 17:29 +0800, Johannes Berg wrote:
> > Once reading the ACPI spec I noticed that ACPI supports this feature
> > so it is qute nice to implement it, since this will prevent resume from disk what hardware was changed.
> > 
> > But.. how many bioses are broken regarding this feature....
> 
> If they are broken though, how likely is it they'll have a changing
> signature? I'd expect the most likely broken case is they just don't
> calculate it at all and leave it constant.
In my limited check, Thinkpad implements the signature fine, others
sound not. They are not broken, but just not implement the signature,
eg, it's always 0.

Thanks,
Shaohua

