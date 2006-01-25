From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH 0/2] Deliver ACPI events upon subscription and implement multiple readers for /proc/acpi/event
Date: Tue, 24 Jan 2006 20:46:27 -0500
Message-ID: <200601242046.27670.dtor_core@ameritech.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005D29F8D@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:23415 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750756AbWAYBqo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Jan 2006 20:46:44 -0500
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005D29F8D@hdsmsx401.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org

On Tuesday 24 January 2006 20:17, Brown, Len wrote:
> What's the problem with opening a socket to the user-space acpid --
> the way multiple readers work today?
>

- one does not want to use current implementation of acpid?
- one does not want to depend on having acpid running before
  starting snooping acpi events?
- because allowing multiple readers is a "right thing to do"?

... just to name a few advantages.

-- 
Dmitry
