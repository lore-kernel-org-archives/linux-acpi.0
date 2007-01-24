From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: Fan speeds on HP nc6400 and nc8430
Date: Wed, 24 Jan 2007 09:54:32 -0700
Message-ID: <200701240954.32742.bjorn.helgaas@hp.com>
References: <C3FA62B1A90D7440B9B6C7C31895994F0366363A@zadbn02100.vodacom.corp> <3877989d0701232019g45af8feaxabdcf6ba77170a5d@mail.gmail.com> <200701232138.54758.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:57522 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752021AbXAXQzF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Jan 2007 11:55:05 -0500
In-Reply-To: <200701232138.54758.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luming Yu <luming.yu@gmail.com>
Cc: emisca <emisca.ml@gmail.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Pieter De Wit <Pieter.DeWit@vodacom.co.za>, linux-acpi@vger.kernel.org

On Tuesday 23 January 2007 21:38, Bjorn Helgaas wrote:
> On Tuesday 23 January 2007 21:19, Luming Yu wrote:
> > On 1/19/07, emisca <emisca.ml@gmail.com> wrote:
> > > The TZ4 thermal zone on all the hp compaq line nx**** and nc**** is
> > > not a temperature but the fan speed. You can see this information on
> > > the web and on hp forums.
> > 
> > Where is the hp forums.
> 
> I don't work on laptops, so I can't confirm this, but Google found
> this (from "tz4 thermal zone fan speed hp"):
> 
> http://forums1.itrc.hp.com/service/forums/bizsupport/questionanswer.do?threadId=1052925

Someone also sent me this, which I'll include in case it helps anybody
else.  Obviously, scripts like the one mentioned below are stop-gaps
that shouldn't be necessary.  But the script might have useful hints
about how to fix the kernel so the script would no longer be needed.

> Take a look at this:
> http://daniel.graziotin.net/2006/12/02/hp-nx6325-and-friends-thermal-problems-solved this fixed my thermal problem.
> And make sure you unload the psmouse module during halt/reboot
> otherwise you have problemes when you start your notebook again.
> (symptom's: very long BIOS-Boot, ACPI-problems (thermal)..)
