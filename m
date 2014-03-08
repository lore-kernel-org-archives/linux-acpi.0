From: Alexander Mezin <mezin.alexander@gmail.com>
Subject: Re: [PATCH v2] ACPI / battery: trigger rechecking of AC adapter state
 when battery state changes.
Date: Sat, 8 Mar 2014 12:45:03 +0700
Message-ID: <CADnvcfKLsqXxVu+5n+B-OpF1aNRq-bj6f_bNzRShH7J=FXfyzA@mail.gmail.com>
References: <1393758159-6934-1-git-send-email-mezin.alexander@gmail.com>
	<1820321.2G4Ojtj5V1@vostro.rjw.lan>
	<5319404E.10509@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:40370 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbaCHFpD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Mar 2014 00:45:03 -0500
Received: by mail-pd0-f179.google.com with SMTP id w10so4903083pde.24
        for <linux-acpi@vger.kernel.org>; Fri, 07 Mar 2014 21:45:03 -0800 (PST)
In-Reply-To: <5319404E.10509@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

2014-03-07 10:43 GMT+07:00 Lan Tianyu <tianyu.lan@intel.com>:
> Sorry for later response due to be busy on other things.
>
> Hi Alexander:
>
> From the DSDT table, _Q08 is in change of notifying AC driver.
> So you can check "/sys/firmware/acpi/interrupts/gpe08". Whether the count
> increases or not during plugging or unplugging AC.
>
> According the description, the _Q08 wasn't triggered.

cat /sys/firmware/acpi/interrupts/gpe08
       0   invalid

Always.

> I think you can use acpi_notifier_call_chain() here and register acpi
> notifier in the AC driver. When get the Battery change event, call
> acpi_ac_get_state(ac). From my view, this is more general than traverse all
> power supply device and call AC's get_property() callback in battery driver.

Thanks for this suggestion. This looks like better solution for me
too. I'll prepare v3 soon.

>
> --
> Best Regards
> Tianyu Lan
