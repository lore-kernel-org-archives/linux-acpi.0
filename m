From: Len Brown <lenb@kernel.org>
Subject: Re: acpi/sensors temperature on nx6325
Date: Sun, 17 Jun 2007 23:23:50 -0400
Message-ID: <200706172323.50305.lenb@kernel.org>
References: <200706111310.25351.dev.list@mircea.bardac.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34703 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbXFRDYz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 Jun 2007 23:24:55 -0400
In-Reply-To: <200706111310.25351.dev.list@mircea.bardac.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mircea Bardac <dev.list@mircea.bardac.net>
Cc: linux-acpi@vger.kernel.org


> I got the same effect: I can't see the temperature change dynamically, degree 
> by degree. Also, in a test, the sensor went up to 60-65C and the trip-point 
> did't activate. This was with polling set to 1.
> 
> If you need any more information, let me know.

Try 2.6.22-rc5 with polling set to 0 and let me know if that doesn't work.

thanks,
-Len
