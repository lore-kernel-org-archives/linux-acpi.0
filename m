From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [RFC][PATCH 3/4] swsusp: Introduce restore platform operations
Date: Wed, 23 May 2007 00:10:20 +0400
Message-ID: <46534E2C.60808@gmail.com>
References: <200705180019.35548.rjw@sisk.pl> <20070521233848.GN10714@elf.ucw.cz> <200705220155.44430.rjw@sisk.pl> <200705222203.48568.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:55334 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757498AbXEVUK3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 May 2007 16:10:29 -0400
Received: by ug-out-1314.google.com with SMTP id 44so407882uga
        for <linux-acpi@vger.kernel.org>; Tue, 22 May 2007 13:10:27 -0700 (PDT)
In-Reply-To: <200705222203.48568.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>

Rafael J. Wysocki ?????:
> On Tuesday, 22 May 2007 01:55, Rafael J. Wysocki wrote:
> Moreover, I'm not quite certain in which points the GPEs should actually be
>   
> disabled and enabled.  For example, there are some testing data indicating that
> the enabling of GPEs should be done after all of the device drivers' .resume()
> callbacks have run.
Opposite, ACPI devices require enabled GPEs to do their resume, so 
enabling of GPEs
should happen at least before .resume() of ACPI devices is called.

Regards,
Alex.
