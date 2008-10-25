From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Re: Linux 2.6.28-rc1] ACPI Warning (nspredef-0852)[...]
Date: Sat, 25 Oct 2008 20:04:00 +0200
Message-ID: <200810252004.01274.rjw@sisk.pl>
References: <fa.1HaqObZirROiyqr922A7hRDVc54@ifi.uio.no> <fa.Rzh43vSl9NX1QQ2nOYQSgEJcZAw@ifi.uio.no> <49035313.9080309@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:51170 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753069AbYJYR73 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Oct 2008 13:59:29 -0400
In-Reply-To: <49035313.9080309@shaw.ca>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Maciej Rutecki <maciej.rutecki@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, lenb@kernel.org, fabio.comolli@gmail.com

On Saturday, 25 of October 2008, Robert Hancock wrote:
> Henrique de Moraes Holschuh wrote:
> > On Sat, 25 Oct 2008, Rafael J. Wysocki wrote:
> >> On Saturday, 25 of October 2008, Maciej Rutecki wrote:
> >>> During suspend to ram I have this message:
> >>>
> >>> ACPI Warning (nspredef-0852): \_WAK: Return type mismatch - found
> >>> Integer, expected Package [20080926]
> >>>
> >>> s2ram seems works OK
> >>>
> >>> dmesg, acpidump:
> >>> http://unixy.pl/maciek/download/kernel/2.6.28-rc1_wak/
> >> IMO it's yet another incarnation of
> >> http://bugzilla.kernel.org/show_bug.cgi?id=11822
> > 
> > If this is an outright violation of the ACPI spec, let me know (and if
> > possible, please tell me the spec page).  This is the kind of thing I expect
> > it would be a no-brainer to get Lenovo to fix with a BIOS update.
> 
> I don't think this is the same issue, but in both cases it looks like 
> the BIOS AML code is wrong (just judging from the output, haven't looked 
> at the dump yet). _WAK is supposed to return a package of 2 DWORD 
> values, a bit field of conditions that occurred during sleep, and the 
> effective S-state the system actually entered (section 7.3.7 of the ACPI 
> 3.0 spec). Presumably the BIOS is returning a single integer.

The underlying issue is we've never reported such BIOS bugs before and now we
do that unconditionally.  IMnshO, this should only be done if ACPI debugging is
enabled.

While I can see a value in doing that always, IMO such a change should only be
made after a big announcement.

Thanks,
Rafael
