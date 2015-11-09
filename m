From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 2/2] acpi: nfit: Add support for hot-add
Date: Sun, 8 Nov 2015 17:26:03 -0800
Message-ID: <CAPcyv4jK+smY6gVaxPAsWh7iZTo5+ZzrGy9SWqmdM1A4sp+jeA@mail.gmail.com>
References: <1445986707-15395-1-git-send-email-vishal.l.verma@intel.com>
	<1445986707-15395-3-git-send-email-vishal.l.verma@intel.com>
	<CAPcyv4gytTTVgU6evY9d+EoxD0wRs4J1D_LS+ucJ5vOju0Kd2A@mail.gmail.com>
	<13659976.4obepioknq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37641 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbbKIB0F (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Nov 2015 20:26:05 -0500
Received: by wmww144 with SMTP id w144so18931706wmw.0
        for <linux-acpi@vger.kernel.org>; Sun, 08 Nov 2015 17:26:04 -0800 (PST)
In-Reply-To: <13659976.4obepioknq@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Vishal Verma <vishal.l.verma@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Elliott Robert <elliott@hpe.com>, Toshi Kani <toshi.kani@hpe.com>

On Sun, Nov 8, 2015 at 4:49 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Saturday, November 07, 2015 10:57:17 AM Dan Williams wrote:
>> Rafael, awaiting your ack...
>
> Well, this seems to be entirely NFIT-related.
>
> Is there anything in particular you want me to look at?
>

This might be more relevant for a follow-on patch, but I wonder if the
core should be guaranteeing that the ->notify() callback occurs under
device_lock().  In the case of NFIT it seems possible for the notify
event to race ->add() or ->remove(), but maybe I missed some other
guarantee?
