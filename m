From: Roland Dreier <roland@purestorage.com>
Subject: Re: Regression in IO resource allocation
Date: Wed, 1 Jun 2016 10:08:59 -0700
Message-ID: <CAL1RGDU+rMotA4XzBmnnS9GhZWu7v9LQ9NeL=jqVXtP40yfvYw@mail.gmail.com>
References: <CAL1RGDW9z1FhgQwJZTkk0kUBipT68hmW2C4--3Hbb5vzj5ta2w@mail.gmail.com>
 <3491327.Z9FVFNvO7z@vostro.rjw.lan> <CAL1RGDUfCuZ0qiQT4xUf0koS3uxfXfBPMfYL41tkjB_cM36Nfw@mail.gmail.com>
 <CAJZ5v0jOg-oTDEZodhLHD5iz039kKP-UCQoB92nZ8=_qhSa-HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jOg-oTDEZodhLHD5iz039kKP-UCQoB92nZ8=_qhSa-HA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, May 31, 2016 at 3:31 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> It may not be called at all if _PTC is used on that system, for example.

Yes, that's exactly the case on my system.

So from my POV:

Tested-by: Roland Dreier <roland@purestorage.com>

Thanks!
