From: Len Brown <len.brown@intel.com>
Subject: Re: [patch 4/6] Add output class document
Date: Mon, 6 Nov 2006 17:42:26 -0500
Message-ID: <200611061742.27298.len.brown@intel.com>
References: <200611042122.00950.luming.yu@gmail.com> <20061104082228.GA30489@kroah.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44442 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1753897AbWKFWkR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Nov 2006 17:40:17 -0500
In-Reply-To: <20061104082228.GA30489@kroah.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Yu Luming <luming.yu@gmail.com>, Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>, Matt Domsch <Matt_Domsch@dell.com>, Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr, Richard Hughes <hughsient@gmail.com>

On Saturday 04 November 2006 03:22, Greg KH wrote:
> On Sat, Nov 04, 2006 at 09:22:00PM +0800, Yu Luming wrote:

> Have you been working with the X developers that have been doing a lot
> of work in describing and interacting with these different video
> devices?  I think you might want to work with them so that you don't
> create an interface that will not be used by them.

We discussed this with Keith Packard, who insisted that video switching
is best done from within the video driver using native hardware interfaces.

That sounds good to me, but it doesn't answer the question about
systems who choose to export video switching via ACPI.
The goal at hand is to export that capability in the event
it is not available via other means.

The issue that will come up is if this capability and a native
hardware technique are used at the same time -- probably
bad things will happen.  In that case, we need a way for
the native technique to disable use of the ACPI technique.

cheers,
-Len
