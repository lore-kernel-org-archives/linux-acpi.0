From: Pavel Troller <patrol@sinus.cz>
Subject: Re: always 3 times: "AE_NOT_FOUND, Processor Device is not present"
Date: Sat, 5 Jan 2008 13:40:24 +0100
Message-ID: <20080105124024.GA15738@tangens.sinus.cz>
References: <87396499@web.de>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tangens.sinus.cz ([195.39.17.8]:47158 "EHLO tangens.sinus.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754055AbYAEMk0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 5 Jan 2008 07:40:26 -0500
Content-Disposition: inline
In-Reply-To: <87396499@web.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: devzero@web.de
Cc: linux-acpi@vger.kernel.org

> came across this by some module testing and i`m just curious why that message is always being printed 3 times where one would be enough.
> 
> indeed a very minor issue (if any) - just wanted to let you know....
> 
Hi!
  Maybe it's because your ACPI BIOS exports entries for 4 CPUs (your mobo
can accept quad-core CPU), but only one CPU/core is really populated. One of
my motherboards does exactly the same - I have a dual-core CPU in it and
it shows always 2x PROCESSOR_NOT_FOUND error.
  With regards, Pavel Troller
