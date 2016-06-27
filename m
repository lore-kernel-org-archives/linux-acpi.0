From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 2/3] acpi: dptf_power: Add DPTF power participant
Date: Mon, 27 Jun 2016 03:45:10 +0200
Message-ID: <CAJZ5v0hR9E-pLkkvbSLwLG8A1ECCVa=+45YJ1+L1cjXHaPaLtg@mail.gmail.com>
References: <1466718134-29921-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1466718134-29921-3-git-send-email-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0hRVDMgsBzEMufwHurA8aRBmd7p_MvnMg1cdNYgDrPDaA@mail.gmail.com>
 <1466723970.8970.69.camel@linux.intel.com> <CAJZ5v0ithpoZfHJQwfyLdrsLyU1-M8psrJz12eaOTR9ffCTPOQ@mail.gmail.com>
 <1466991116.5580.11.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36094 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbcF0BpN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Jun 2016 21:45:13 -0400
Received: by mail-wm0-f50.google.com with SMTP id f126so81751618wma.1
        for <linux-acpi@vger.kernel.org>; Sun, 26 Jun 2016 18:45:12 -0700 (PDT)
In-Reply-To: <1466991116.5580.11.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Mon, Jun 27, 2016 at 3:31 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Fri, 2016-06-24 at 02:26 +0200, Rafael J. Wysocki wrote:
>> > > >
>> On Fri, Jun 24, 2016 at 1:19 AM, Srinivas Pandruvada
>> <srinivas.pandruvada@linux.intel.com> wrote:
>> > On Fri, 2016-06-24 at 00:31 +0200, Rafael J. Wysocki wrote:
>> > > On Thu, Jun 23, 2016 at 11:42 PM, Srinivas Pandruvada
>> > > <srinivas.pandruvada@linux.intel.com> wrote:
> [...]
>
>> I think what you need is that if acpi_battery is bound to at least
>> one
>> device, you don't want to bind dptf_power to anything.  Conversely,
>> if
>> dptf_power has been bound to at least one device, you don't want to
>> bind acpi_battery to anything.
>>
>> That may be achieved with a lock and two counters, one (A)
>> incremented
>> only by acpi_battery and the other (B) incremented only by dptf_power
>> and such that you can't increment A if B is different from 0 and you
>> can't increment B if A is different from 0.  Of course, each driver
>> would need to specify which counter it wants to use (A or B), so that
>> would take an additional argument to acpi_battery_common_add() and an
>> additional field in struct acpi_battery (for the remove operation).
>>
>> With that, I think it should only be possible to build both
>> acpi_battery and dptf_power if they are both modules.  IOW,
>> DPTF_POWER
>> should depend on (!ACPI_BATTERY || ACPI_BATTERY=m) or similar.  And
>> if
>> they are both modules, let user space manage that.
>>
>> And the waiting itself doesn't add any value then IMO.
> Yes. I think the best solution is not to let define DPTF_POWER when the
> ACPI_BATTERY is defined same as my first version of the patch or let
> both add as there is no harm as they will show same levels. The reason
> is:
> We have some devices with two ACPI_BATTERIES (primary and
> secondary/backup) and they must be presented as two power supply
> devices to user space. In those devices DPTF_POWER may be equivalent to
> only one of the ACPI_BATTERY (Will point to same battery for Battery
> levels). So we can't simply refuse to add ACPI_BATTERY device addition
> because DPTF_POWER device is registered before.

OK

Say dptf_power points to the same battery device as acpi_battery.  Is
there any way to tell when that happens?
