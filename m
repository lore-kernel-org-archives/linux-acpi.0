From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Re: Linux 2.6.28-rc1] ACPI Warning (nspredef-0852)[...]
Date: Sat, 25 Oct 2008 12:59:38 +0200
Message-ID: <200810251259.39233.rjw@sisk.pl>
References: <8db1092f0810250021p70be6b62wdbb9a4c1c20c7a27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50112 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331AbYJYKzI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Oct 2008 06:55:08 -0400
In-Reply-To: <8db1092f0810250021p70be6b62wdbb9a4c1c20c7a27@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, lenb@kernel.org, fabio.comolli@gmail.com

On Saturday, 25 of October 2008, Maciej Rutecki wrote:
> During suspend to ram I have this message:
> 
> ACPI Warning (nspredef-0852): \_WAK: Return type mismatch - found
> Integer, expected Package [20080926]
> 
> s2ram seems works OK
> 
> dmesg, acpidump:
> http://unixy.pl/maciek/download/kernel/2.6.28-rc1_wak/

IMO it's yet another incarnation of
http://bugzilla.kernel.org/show_bug.cgi?id=11822

Thanks,
Rafael
