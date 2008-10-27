From: "Maciej Rutecki" <maciej.rutecki@gmail.com>
Subject: Re: [Re: Linux 2.6.28-rc1] ACPI Warning (nspredef-0852)[...]
Date: Mon, 27 Oct 2008 21:19:56 +0100
Message-ID: <8db1092f0810271319s5d15c2ffrab37a548fa388738@mail.gmail.com>
References: <fa.1HaqObZirROiyqr922A7hRDVc54@ifi.uio.no>
	 <fa.Rzh43vSl9NX1QQ2nOYQSgEJcZAw@ifi.uio.no> <49035313.9080309@shaw.ca>
	 <200810252004.01274.rjw@sisk.pl>
	 <8db1092f0810251151l4c7f9382r34defa6d4d6ee24c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:12903 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754253AbYJ0UT6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Oct 2008 16:19:58 -0400
In-Reply-To: <8db1092f0810251151l4c7f9382r34defa6d4d6ee24c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Robert Hancock <hancockr@shaw.ca>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, lenb@kernel.org, fabio.comolli@gmail.com

2008/10/25 Maciej Rutecki <maciej.rutecki@gmail.com>:
> Suspend to ram, but another machine (previous PC, now laptop) and
> another problem:
>
> ACPI: EC: missing confirmations, switch off interrupt mode.
> ACPI Exception (evregion-0419): AE_TIME, Returned by Handler for
> [EmbeddedControl] [20080926]
> ACPI Error (psparse-0524): Method parse/execution failed [\_TZ_.C31E]
> (Node f7019858), AE_TIME
> ACPI Error (psparse-0524): Method parse/execution failed
> [\_TZ_.TZ3_._TMP] (Node f7019ed0), AE_TIME
>
> It doesn't happened immediately after s2ram but is correlation between
> s2ram and this error.

I was wrong; it happens not only after suspend to ram but sometimes
after normal boot.


-- 
Maciej Rutecki
http://www.maciek.unixy.pl
