From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/6] Hibernation: Introduce system_entering_hibernation
Date: Sun, 05 Oct 2008 06:52:49 +0900
Message-ID: <48E7E5B1.8010101@gmail.com>
References: <200808290002.55026.rjw@sisk.pl>	<200810032351.46869.rjw@sisk.pl>	<20081004002724.47fab174@lxorguk.ukuu.org.uk>	<200810041213.22249.rjw@sisk.pl> <20081004225008.2cc08201@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:38159 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494AbYJDVyj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Oct 2008 17:54:39 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1078252tic.23
        for <linux-acpi@vger.kernel.org>; Sat, 04 Oct 2008 14:54:37 -0700 (PDT)
In-Reply-To: <20081004225008.2cc08201@lxorguk.ukuu.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Robert Hancock <hancockr@shaw.ca>, LKML <linux-kernel@vger.kernel.org>, Frans Pop <elendil@planet.nl>, Maciej Rutecki <maciej.rutecki@gmail.com>

Alan Cox wrote:
>> Hm, I'm not sure what you mean exactly, but the point is to blacklist the
>> on-board controllers only and a devfn of the controller is needed for that,
>> or a part of it (like the slot number I'm using).  Could that be done above
>> the driver level?
> 
> It can be done in one place via the libata core code I think rather than
> in each driver. Might need to be a helper function but you'd at least
> remove all the duplication.

I think it's better to keep the list in each LLD but having a helper in
libata-core would be nice.

Thanks.

-- 
tejun
