From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH 3/4] RFC Thermal: Introduce a step-wise thermal governor
Date: Tue, 12 Jun 2012 14:46:03 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB5913618B@BGSMSX101.gar.corp.intel.com>
References: <1339436374-26881-1-git-send-email-durgadoss.r@intel.com>
 <1339436374-26881-4-git-send-email-durgadoss.r@intel.com>
 <20120612125901.GD8724@besouro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:41358 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924Ab2FLOqI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jun 2012 10:46:08 -0400
In-Reply-To: <20120612125901.GD8724@besouro>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>

Hi Eduardo,

> > +	  Enable this to manage platform thermals using a simple linear
> > +          throttling algorithm
> 
> Same as before, add some description of the governor-policy.

I added comments while defining this function inside the file.
Never mind, will make it more readable in next version :-)

> > +		else if (new_state <= 0)
> 
> new_state can not be negative as it is declared as unsigned.

Good one. Thank you. will fix.

> 
> Again, what was the difference between linear and step_wise?
> 

Not intended to be different.

> Is it so that linear applies only to the passive trip points and
> step wise applies to all cooling devices in the specific zone?

No. Right now it is like that.
Now that we agree to clean thermal_sys.c from throttling code,
I will add that functionality here.

> 
> I guess we need some more clarity on the differences.

I hope my next patch set will make things clear.

Thanks,
Durga
