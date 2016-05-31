From: Roland Dreier <roland@purestorage.com>
Subject: Re: Regression in IO resource allocation
Date: Tue, 31 May 2016 14:42:16 -0700
Message-ID: <CAL1RGDUfCuZ0qiQT4xUf0koS3uxfXfBPMfYL41tkjB_cM36Nfw@mail.gmail.com>
References: <CAL1RGDW9z1FhgQwJZTkk0kUBipT68hmW2C4--3Hbb5vzj5ta2w@mail.gmail.com>
 <3491327.Z9FVFNvO7z@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3491327.Z9FVFNvO7z@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, May 31, 2016 at 2:11 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Can you please try the appended patch (untested)?

Thanks for the quick reply.  Patch looks OK on my system... it boots
(which is very good :) and I see

    system 00:01: [io  0x0400-0x047f] has been reserved

however I don't see the "ACPI CPU throttle" region reserved in
/proc/ioports... haven't debugged why acpi_processor_get_throttling()
isn't getting called or what is happening yet.

Will dig a bit deeper and let you know.

 - R.
