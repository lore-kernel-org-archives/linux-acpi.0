From: Roland Dreier <roland@purestorage.com>
Subject: Re: Regression in 3.10.80 vs. 3.10.79
Date: Sat, 13 Jun 2015 09:56:02 -0700
Message-ID: <CAL1RGDXak7oCpOQeXqvDxHf2ihZD6jUopKPZMPCLdPfLO38qWg@mail.gmail.com>
References: <CAL1RGDV6hr3_Oa6O-kPzx9EemtOWWtYq+-RkCzN7axNPLz5MJw@mail.gmail.com>
 <1903121.bsBlXHXLzb@vostro.rjw.lan> <CAL1RGDVMwmpB2Gap3HcWzUP6MAr83wtkZLic9dv8Ms6wLEX95A@mail.gmail.com>
 <2035450.JLWirv5QXd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys010aog103.obsmtp.com ([74.125.245.74]:57930 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752463AbbFMQ4Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 13 Jun 2015 12:56:25 -0400
Received: by lblr1 with SMTP id r1so6962195lbl.0
        for <linux-acpi@vger.kernel.org>; Sat, 13 Jun 2015 09:56:23 -0700 (PDT)
In-Reply-To: <2035450.JLWirv5QXd@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, George McCollister <george.mccollister@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>

On Fri, Jun 12, 2015 at 7:52 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Below is a more sophisticated, so to speak, version of it with a changelog and
> all.  It works for me, but more testing would be much appreciated.

Great, I'm convinced by your reasoning that this makes sense.  I'm
building 3.10.80 patched with this (needed a tiny bit of context
adjustment because acpi_dev_filter_resource_type() hadn't been added
to 3.10 yet), and will confirm that it fixes the issue I saw.

Thanks!
  Roland
