From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Linux 2.6.28-rc1] ACPI Warning (nspredef-0852)[...]
Date: Mon, 03 Nov 2008 15:26:05 +0300
Message-ID: <490EEDDD.4010203@gmail.com>
References: <fa.1HaqObZirROiyqr922A7hRDVc54@ifi.uio.no>	 <fa.Rzh43vSl9NX1QQ2nOYQSgEJcZAw@ifi.uio.no> <49035313.9080309@shaw.ca>	 <200810252004.01274.rjw@sisk.pl>	 <8db1092f0810251151l4c7f9382r34defa6d4d6ee24c@mail.gmail.com>	 <8db1092f0810271319s5d15c2ffrab37a548fa388738@mail.gmail.com>	 <1225187050.5189.146.camel@yakui_zhao.sh.intel.com>	 <8db1092f0810281245k14555e26w30547cf17fde534f@mail.gmail.com> <8db1092f0811030406i48150022gb5b444710d749b43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:17107 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755265AbYKCM0K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Nov 2008 07:26:10 -0500
In-Reply-To: <8db1092f0811030406i48150022gb5b444710d749b43@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Robert Hancock <hancockr@shaw.ca>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "fabio.comolli@gmail.com" <fabio.comolli@gmail.com>

Maciej Rutecki wrote:
> Problem still exists on 2.6.28-rc3:
> ACPI: EC: missing confirmations, switch off interrupt mode.
> ACPI Exception (evregion-0419): AE_TIME, Returned by Handler for
> [EmbeddedControl] [20080926]
> ACPI Error (psparse-0524): Method parse/execution failed [\_TZ_.C31E]
> (Node f7019858), AE_TIME
> ACPI Error (psparse-0524): Method parse/execution failed
> [\_TZ_.TZ3_._TMP] (Node f7019ed0), AE_TIME
>
> But I don't see any functional problems.
>
> Regards
>   
please see #11917
