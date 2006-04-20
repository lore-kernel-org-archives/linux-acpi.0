From: Xavier Bestel <xavier.bestel@free.fr>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Date: Thu, 20 Apr 2006 18:11:00 +0200
Message-ID: <1145549460.23837.156.camel@capoeira>
References: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com>
	 <20060420073713.GA25735@srcf.ucam.org> <4447AA59.8010300@linux.intel.com>
	 <20060420153848.GA29726@srcf.ucam.org>  <4447AF4D.7030507@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp5.wanadoo.fr ([193.252.22.26]:33524 "EHLO smtp5.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1751088AbWDTQLI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Apr 2006 12:11:08 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0512.wanadoo.fr (SMTP Server) with ESMTP id 650531C001C4
	for <linux-acpi@vger.kernel.org>; Thu, 20 Apr 2006 18:11:07 +0200 (CEST)
In-Reply-To: <4447AF4D.7030507@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 17:57, Alexey Starikovskiy wrote:
> Matthew Garrett wrote:
> > On Thu, Apr 20, 2006 at 07:35:53PM +0400, Alexey Starikovskiy wrote:
> > 
> >> Could it be more sensible to use kevent and dbus for sending all events 
> >> from ACPI?
> > 
> > For most of the events, probably. I'm less convinced by the button 
> > driver - sleep and power buttons can also generate keycodes rather than 
> > ACPI events, and so getting the button driver to behave like an input 
> > device adds consistency.
> > 
> I think you will agree that ACPI buttons are special and will need special handling even in input stream...
> Generic application does not need to know if power, sleep, or lid button is pressed, so you will need to intercept them from input stream... I cannot find any reason to mix these buttons into input, do you?

There are keyboards with power/sleep buttons. It makes sense they have
the same behavior than ACPI buttons.

	Xav


