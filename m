From: "Matthew Brett" <matthew.brett@gmail.com>
Subject: Re: PROBLEM: CPU fan shuts down on load of fan.ko in kernel 2.6.18 and later
Date: Wed, 17 Jan 2007 09:02:02 +0000
Message-ID: <1e2af89e0701170102u45618fbdo851cb29d86bf54ae@mail.gmail.com>
References: <E3C0BCA40296C347AF7142161DB9FC8298F74B@mssmsx411>
	 <200701151006.15790.bjorn.helgaas@hp.com>
	 <1e2af89e0701151639i1b3e651dne117da0e55bd666f@mail.gmail.com>
	 <3877989d0701161849s35069b88u537fffcd913b355d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:44131 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932101AbXAQJCD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Jan 2007 04:02:03 -0500
Received: by nz-out-0506.google.com with SMTP id s1so381574nze
        for <linux-acpi@vger.kernel.org>; Wed, 17 Jan 2007 01:02:02 -0800 (PST)
In-Reply-To: <3877989d0701161849s35069b88u537fffcd913b355d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luming Yu <luming.yu@gmail.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Salatiel Filho <salatiel.filho@gmail.com>, linux-acpi@vger.kernel.org

Hi,

> Does it really solve the problem of CPU fan shutting down on load of fan.ko?
> Could you just re-test, since that is the problem from the beginning.

Yes; normally fan.ko is insmodded in my boot sequence. At that point
in the boot sequence the fan turns off and cannot be turned on again
(see results of echos to fan state earlier). After the DSDT patch, the
fan stays on through the boot sequence, fan.ko is shown as loaded via
lsmod, and echos to fan state behave as expected.

Best,

Matthew
