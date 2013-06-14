From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [PATCH 0/5] ACPI / scan: Make it possible to use the container
 hotplug with other scan handlers
Date: Fri, 14 Jun 2013 15:32:42 -0700
Message-ID: <CA+8MBbKZBvqVA+wKTK7GpXorpBvDLGCJURc+PQz+QfDiwA1a8A@mail.gmail.com>
References: <1417592.vuSG0cUIGo@vostro.rjw.lan>
	<1371162234.21540.43.camel@misato.fc.hp.com>
	<3908561D78D1C84285E8C5FCA982C28F2DA7C18E@ORSMSX106.amr.corp.intel.com>
	<3168584.RRBYoY5UXf@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:33833 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476Ab3FNWcm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Jun 2013 18:32:42 -0400
In-Reply-To: <3168584.RRBYoY5UXf@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Toshi Kani <toshi.kani@hp.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Lu, Aaron" <aaron.lu@intel.com>

On Fri, Jun 14, 2013 at 3:23 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Can you please just test patch [5/5] alone without patches [1-4/5]?  We believe
> that this should work too and if that's the case, we'll only need that patch
> and a reworked [1/5].

Your belief is sound - I popped all five patches and then applied just
5/5 ... and
the system still works.

-Tony
