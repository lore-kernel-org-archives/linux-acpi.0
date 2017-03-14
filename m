From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 16/16] ACPI / DSD: Document references, ports and endpoints
Date: Tue, 14 Mar 2017 18:05:54 +0100
Message-ID: <CAJZ5v0j1i-tNOdyhhknYCSPbOg7KAQpYgeReH_KwgebO3AcjRA@mail.gmail.com>
References: <1488809970-25568-1-git-send-email-sakari.ailus@linux.intel.com>
 <1488809970-25568-17-git-send-email-sakari.ailus@linux.intel.com>
 <1629581.fh46rNHz4U@aspire.rjw.lan> <3df6ac2a-29cc-52b1-cc0c-4c1bc4198c83@linux.intel.com>
 <d0ce808b-a000-6038-c347-25fae32535dc@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f173.google.com ([74.125.82.173]:33590 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752950AbdCNRF4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Mar 2017 13:05:56 -0400
In-Reply-To: <d0ce808b-a000-6038-c347-25fae32535dc@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Tue, Mar 14, 2017 at 9:09 AM, Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
> On 03/14/17 10:08, Sakari Ailus wrote:
>> How about this instead:
>>
>> All port nodes are located under the device's "_DSD" node in the
>> hierarchical data extension tree. The property extension related to
>> each port node must contain the key "port" and an integer value which
>> is the number of the port.
>
> So with matching strings instead of indices, this will change, too...

It doesn't have to AFAICS, but the number is just redundant IMO.  You
only need a boolean property saying "this is a port", so you know that
you should expect a list of endpoints in that object.

Thanks,
Rafael
