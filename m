From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC][PATCH 0/2] boot interrupts on Intel X58 and 55x0
Date: Sun, 6 Sep 2009 22:33:28 -0300
Message-ID: <20090907013328.GA19670@khazad-dum.debian.net>
References: <20090904165525.26294.31112.sendpatchset@t500>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34788 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758409AbZIGBdg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Sep 2009 21:33:36 -0400
Content-Disposition: inline
In-Reply-To: <20090904165525.26294.31112.sendpatchset@t500>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Assmann <sassmann@redhat.com>
Cc: linux-kernel@vger.kernel.org, jcm@redhat.com, sdietrich@novell.com, linux-acpi@vger.kernel.org, andi@firstfloor.org, hpa@zytor.com, mingo@elte.hu, Olaf.Dabrunz@gmx.net, ktokunag@redhat.com, tglx@linutronix.de, lenb@kernel.org

On Fri, 04 Sep 2009, Stefan Assmann wrote:
> is more serious namely the onboard NIC (8086:10c9) is malfunctioning on some
> of our test system if the second patch is applied. It fails to acquire an IP
> from DHCP and we're pretty clueless on this issue right now.
> Help is greatly appreciated!

Did you read Intel documet 320839-009, August/2009, already?  It is at:
http://www.intel.com/Assets/PDF/specupdate/320839.pdf

I see some stuff there that might be a problem, many of the "issues" are
related to interrupt handling.  Errata 40 (EOI to IOAPIC can be blocked)
even states that one should avoid the X58 IOH IOAPIC on stepping B2
completely, and use the IOAPIC in the ICH10R instead.

And the B2 stepping is the one in most motherboards (B3 is quite new).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
