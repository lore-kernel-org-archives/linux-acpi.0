From: Mircea Bardac <dev.list@mircea.bardac.net>
Subject: Re: acpi/sensors temperature on nx6325
Date: Mon, 11 Jun 2007 13:29:05 +0300
Message-ID: <200706111329.08730.dev.list@mircea.bardac.net>
References: <200706111310.25351.dev.list@mircea.bardac.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bravo.securenet-server.net ([207.210.84.244]:57631 "EHLO
	bravo.securenet-server.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757614AbXFKKch (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Jun 2007 06:32:37 -0400
Received: from [86.121.179.56] (helo=mircea.home.bardac.net)
	by bravo.securenet-server.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <dev.list@mircea.bardac.net>)
	id 1HxhAW-0003ns-HO
	for linux-acpi@vger.kernel.org; Mon, 11 Jun 2007 06:30:40 -0400
In-Reply-To: <200706111310.25351.dev.list@mircea.bardac.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Monday 11 June 2007 13:10:23 you wrote:
> I got the same effect: I can't see the temperature change dynamically,
> degree by degree. Also, in a test, the sensor went up to 60-65C and the
> trip-point did't activate. This was with polling set to 1.

Clarification:

Using a polling frequency of 1 second (*) I didn't see the ACPI temperature 
increase at all.


"sensors" has shown the temperature increasing, but reaching 60-65C the 
trip-point didn't activate.


* The frequency is measured in "times/second" or Hz.
Shouldn't "polling_frequency" be renamed to "polling_interval" if it is 
measured in seconds?


Regards,
Mircea
