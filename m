From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RESEND][PATCH v2 27/36] drivers: Add a generic helper to match
 device by fwnode handle
Date: Thu, 18 Apr 2019 16:39:51 +0200
Message-ID: <CAJZ5v0jXioEAELmHqMhR0wJQkzLQpp1WA-zuWHdFkSWjiX0kVw@mail.gmail.com>
References: <1555344260-12375-28-git-send-email-suzuki.poulose@arm.com>
 <1555411164-26399-1-git-send-email-suzuki.poulose@arm.com>
 <CAJZ5v0i2-11rgH5Y+83U041Eyp=SA56oPqDmS2g24SyYYJH3jg@mail.gmail.com> <ebb13205-2548-1c30-fd65-bdfe4c7d9c08@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ebb13205-2548-1c30-fd65-bdfe4c7d9c08@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, coresight@lists.linaro.org, Mathieu Poirier <mathieu.poirier@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 16, 2019 at 12:53 PM Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
>
> On 04/16/2019 11:48 AM, Rafael J. Wysocki wrote:
> > On Tue, Apr 16, 2019 at 12:39 PM Suzuki K Poulose
> > <suzuki.poulose@arm.com> wrote:
> >>
> >> Make the device_fwnode_match() a generic helper to match device
> >> by fwnode handle for use with bus_find_device(). This will be
> >> also used by coresight.
> >>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> >> Cc: linux-acpi@vger.kernel.org
> >> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> ---
> >>
> >> Resending with linux-acpi in Cc, as requested by Rafael.
> >
> > Do any other patches in your series depend on this one?
>
> Yes, I do. But they are in the middle of a big series of changes and
> I don't expect this series to go into 5.2. So, if you plan to pull this
> please go ahead.

I would prefer the new exported function to return bool.  With that
changed, I can apply the patch I think.
