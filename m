From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: Another bad usage of smp_processor_id
Date: Wed, 15 Sep 2010 01:14:34 +0200
Message-ID: <1284506074.7596.0.camel@maxim-laptop>
References: <1283077579.5529.2.camel@maxim-laptop>
	 <1283336736.3564.0.camel@maxim-laptop>  <1283493662.2111.3158.camel@rui>
	 <1283847507.2750.1.camel@maxim-laptop>
	 <1284284277.2928.6.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48267 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648Ab0INXOl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Sep 2010 19:14:41 -0400
Received: by bwz11 with SMTP id 11so6071899bwz.19
        for <linux-acpi@vger.kernel.org>; Tue, 14 Sep 2010 16:14:39 -0700 (PDT)
In-Reply-To: <1284284277.2928.6.camel@maxim-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sun, 2010-09-12 at 11:37 +0200, Maxim Levitsky wrote: 
> On Tue, 2010-09-07 at 11:18 +0300, Maxim Levitsky wrote: 
> > On Fri, 2010-09-03 at 14:01 +0800, Zhang Rui wrote: 
> > > Hi, Maxim,
> > > 
> > > please try this patch and see if the problem still exists. :)
> > Yes it does :)
> > And its worse since my system now panics on resume...
> > Kernel log attached.

Ok. 2.6.36-rc4 fixes this.

Best regards,
Maxim Levitsky

