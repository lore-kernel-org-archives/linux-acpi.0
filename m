From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: suspend kills serial wacom tablet
Date: Wed, 18 Apr 2007 16:00:47 -0600
Message-ID: <200704181600.47561.bjorn.helgaas@hp.com>
References: <pan.2007.02.20.13.52.07.111117@metm.org> <200704161510.18246.bjorn.helgaas@hp.com> <d120d5000704161418w7603e760wb34b90d8e3974537@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:42955 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754052AbXDRWBD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Apr 2007 18:01:03 -0400
In-Reply-To: <d120d5000704161418w7603e760wb34b90d8e3974537@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: marco <marco@metm.org>, linux-acpi@vger.kernel.org

On Monday 16 April 2007 15:18, Dmitry Torokhov wrote:
> As far as I understand Marco has a serial Wacom table. There is no
> in-kernel driver for serial wacoms, they are handled entirely in
> userspace (X).

Duh.  Thanks for straightening me out.  If I'd bothered to read the
subject line, I would have been much less confused :-)

Marco, since the kernel correctly detects your serial port, you should
not need "setserial."

I'm curious about the hang you saw when doing "cat /dev/ttyS0".  I
would expect the "cat" to block until the tablet sends data.  But
it should not affect the rest of the system, and you should be able
to kill the "cat."  Are you observing something different?

Bjorn
