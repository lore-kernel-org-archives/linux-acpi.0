From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/6] Hibernation: Introduce system_entering_hibernation
Date: Sun, 05 Oct 2008 07:27:35 +0900
Message-ID: <48E7EDD7.5080507@gmail.com>
References: <200808290002.55026.rjw@sisk.pl> <20081004225008.2cc08201@lxorguk.ukuu.org.uk> <48E7E5B1.8010101@gmail.com> <200810050030.18814.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:55722 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898AbYJDW3Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Oct 2008 18:29:25 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1081253tic.23
        for <linux-acpi@vger.kernel.org>; Sat, 04 Oct 2008 15:29:23 -0700 (PDT)
In-Reply-To: <200810050030.18814.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Robert Hancock <hancockr@shaw.ca>, LKML <linux-kernel@vger.kernel.org>, Frans Pop <elendil@planet.nl>, Maciej Rutecki <maciej.rutecki@gmail.com>

Rafael J. Wysocki wrote:
> On Saturday, 4 of October 2008, Tejun Heo wrote:
>> Alan Cox wrote:
>>>> Hm, I'm not sure what you mean exactly, but the point is to blacklist the
>>>> on-board controllers only and a devfn of the controller is needed for that,
>>>> or a part of it (like the slot number I'm using).  Could that be done above
>>>> the driver level?
>>> It can be done in one place via the libata core code I think rather than
>>> in each driver. Might need to be a helper function but you'd at least
>>> remove all the duplication.
>> I think it's better to keep the list in each LLD but having a helper in
>> libata-core would be nice.
> 
> Well, I can try to introduce one in a future patch.  Will that be OK?

Yeah, sure.  :-)

-- 
tejun
