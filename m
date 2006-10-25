From: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Subject: RE: ia64 acpi-cpufreq driver
Date: Tue, 24 Oct 2006 21:47:34 -0600 (MDT)
Message-ID: <1134.24.9.204.52.1161748054.squirrel@mail.atl.hp.com>
References: <EB12A50964762B4D8111D55B764A8454C95BB5@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <EB12A50964762B4D8111D55B764A8454C95BB5@scsmsx413.amr.corp.intel.com>
Sender: linux-ia64-owner@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-acpi@vger.kernel.org, linux-ia64@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

> Yes. As it is today, acpi-cpufreq contains FFH driver functionality
> in itself. It calls acpi and cpufreq arch-independent interfaces but
> implements FFH internally.
>
> By, FFH driver do you mean to handle FFH related functions only for
> P-states or something that can handle all FFH functions (like C-states,
> etc).
> I don't see any other kernel part/or driver will use this particular
> PAL_GET_PSTATE and PAL_SET_PSTATE intefaces. So, my feeling is we don't
> need a separate FFH driver.

The only reason I can think of to have a separate FFH driver
would be that we could potentially combine parts of the x86
acpi-cpufreq and the ia64 acpi-cpufreq.

I didn't look closely, but the x86 and ia64 acpi-cpufreq drivers
looked pretty different, even apart from the FFH stuff, so maybe
that wouldn't be feasible.

Bjorn

