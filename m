From: "Luming Yu" <luming.yu@gmail.com>
Subject: Re: PROBLEM: CPU fan shuts down on load of fan.ko in kernel 2.6.18 and later
Date: Wed, 17 Jan 2007 10:49:31 +0800
Message-ID: <3877989d0701161849s35069b88u537fffcd913b355d@mail.gmail.com>
References: <E3C0BCA40296C347AF7142161DB9FC8298F74B@mssmsx411>
	 <200701151006.15790.bjorn.helgaas@hp.com>
	 <1e2af89e0701151639i1b3e651dne117da0e55bd666f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.238]:61622 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbXAQCtl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jan 2007 21:49:41 -0500
Received: by wx-out-0506.google.com with SMTP id h31so2356321wxd
        for <linux-acpi@vger.kernel.org>; Tue, 16 Jan 2007 18:49:31 -0800 (PST)
In-Reply-To: <1e2af89e0701151639i1b3e651dne117da0e55bd666f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Brett <matthew.brett@gmail.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Salatiel Filho <salatiel.filho@gmail.com>, linux-acpi@vger.kernel.org

>
> > > But, _ON and _OFF methods set \_TZ.THRM.FNON object to 1 and 0
> > > respectively, so, I think, it could be used as value returned by _STA
> > > method. Attached patch for DSDT should solve the fan issue.
>
> For reference, it does solve the fan issue - fan stays on during boot,
> echo 0 and 3 to  /proc/acpi/fan/*/state cause the fan to switch on and
> off respectively.
>

Does it really solve the problem of CPU fan shutting down on load of fan.ko?
Could you just re-test, since that is the problem from the beginning.

--Luming
