From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: Linux 2.6.28-rc1] ACPI Warning (nspredef-0852)[...]
Date: Tue, 28 Oct 2008 15:18:18 +0800
Message-ID: <1225178298.5189.138.camel@yakui_zhao.sh.intel.com>
References: <fa.1HaqObZirROiyqr922A7hRDVc54@ifi.uio.no>
	 <fa.Rzh43vSl9NX1QQ2nOYQSgEJcZAw@ifi.uio.no> <49035313.9080309@shaw.ca>
	 <200810252004.01274.rjw@sisk.pl>
	 <8db1092f0810251151l4c7f9382r34defa6d4d6ee24c@mail.gmail.com>
	 <8db1092f0810271319s5d15c2ffrab37a548fa388738@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59234 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536AbYJ1HLz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Oct 2008 03:11:55 -0400
In-Reply-To: <8db1092f0810271319s5d15c2ffrab37a548fa388738@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Robert Hancock <hancockr@shaw.ca>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "fabio.comolli@gmail.com" <fabio.comolli@gmail.com>

On Mon, 2008-10-27 at 13:19 -0700, Maciej Rutecki wrote:
> 2008/10/25 Maciej Rutecki <maciej.rutecki@gmail.com>:
> > Suspend to ram, but another machine (previous PC, now laptop) and
> > another problem:
> >
> > ACPI: EC: missing confirmations, switch off interrupt mode.
> > ACPI Exception (evregion-0419): AE_TIME, Returned by Handler for
> > [EmbeddedControl] [20080926]
> > ACPI Error (psparse-0524): Method parse/execution failed [\_TZ_.C31E]
> > (Node f7019858), AE_TIME
> > ACPI Error (psparse-0524): Method parse/execution failed
> > [\_TZ_.TZ3_._TMP] (Node f7019ed0), AE_TIME
> >
> > It doesn't happened immediately after s2ram but is correlation between
> > s2ram and this error.
Will you please confirm whether the following issue exists on the
previous kernel? For example: 2.6.27-rc6 or 2.6.27.2
 
> ACPI Exception (evregion-0419): AE_TIME, Returned by Handler for
> [EmbeddedControl] [20080926]
> ACPI Error (psparse-0524): Method parse/execution failed [\_TZ_.C31E]
> (Node f7019858), AE_TIME
> ACPI Error (psparse-0524): Method parse/execution failed
> [\_TZ_.TZ3_._TMP] (Node f7019ed0), AE_TIME
   
If there is no such problem on the early kernel, maybe it is a
regression.

Thanks.
> I was wrong; it happens not only after suspend to ram but sometimes
> after normal boot.
> 
> 

