From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 2/2] acpi: nfit: Add support for hot-add
Date: Mon, 9 Nov 2015 10:25:10 -0800
Message-ID: <CAPcyv4h-OqKcY50Nfb5XQyfxCPQqWs+j4hgkG20bJiUr1ue26g@mail.gmail.com>
References: <1445986707-15395-1-git-send-email-vishal.l.verma@intel.com>
	<1445986707-15395-3-git-send-email-vishal.l.verma@intel.com>
	<CAPcyv4gytTTVgU6evY9d+EoxD0wRs4J1D_LS+ucJ5vOju0Kd2A@mail.gmail.com>
	<13659976.4obepioknq@vostro.rjw.lan>
	<CAPcyv4jK+smY6gVaxPAsWh7iZTo5+ZzrGy9SWqmdM1A4sp+jeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34718 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbbKISZL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2015 13:25:11 -0500
Received: by wmnn186 with SMTP id n186so119462821wmn.1
        for <linux-acpi@vger.kernel.org>; Mon, 09 Nov 2015 10:25:10 -0800 (PST)
In-Reply-To: <CAPcyv4jK+smY6gVaxPAsWh7iZTo5+ZzrGy9SWqmdM1A4sp+jeA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Vishal Verma <vishal.l.verma@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Elliott Robert <elliott@hpe.com>, Toshi Kani <toshi.kani@hpe.com>

On Sun, Nov 8, 2015 at 5:26 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Sun, Nov 8, 2015 at 4:49 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Saturday, November 07, 2015 10:57:17 AM Dan Williams wrote:
>>> Rafael, awaiting your ack...
>>
>> Well, this seems to be entirely NFIT-related.
>>
>> Is there anything in particular you want me to look at?
>>
>
> This might be more relevant for a follow-on patch, but I wonder if the
> core should be guaranteeing that the ->notify() callback occurs under
> device_lock().  In the case of NFIT it seems possible for the notify
> event to race ->add() or ->remove(), but maybe I missed some other
> guarantee?

...and no worries if you don't see anything worth commenting on, the
bulk of this is indeed NFIT specific.
