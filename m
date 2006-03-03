From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
Subject: Re: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
Date: Fri, 3 Mar 2006 16:16:05 +0800
Message-ID: <756b48450603030016r36940139m4d64da5c23156d00@mail.gmail.com>
References: <AcY1+QTZumb9d6e3RHms9ocp4LswwgAtmORQ>
	 <3ACA40606221794F80A5670F0AF15F840AFD4B93@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.177]:23425 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752184AbWCCIQG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Mar 2006 03:16:06 -0500
Received: by pproxy.gmail.com with SMTP id s49so258670pyc
        for <linux-acpi@vger.kernel.org>; Fri, 03 Mar 2006 00:16:05 -0800 (PST)
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840AFD4B93@pdsmsx403>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 2/21/06, Yu, Luming <luming.yu@intel.com> wrote:
> It would be better if you can merge this stuff with acpi video driver.
> If you look at video.c, there is NO HID definition for video device.
> we rely on acpi_video_bus_match to recoginize video device in ACPI
> namespace.

I took a quick look and I think Atlas might be ugly. The current acpi
video driver, as you pointed out, looks for well known required nodes,
specifically _DOD,_DOS,_ROM,.... None of these nodes are provided on
Atlas. From looking at the DSDT, all I see are _BCL and _BCM. It
doesn't even have _BQC. So, from a quick look at the existing video
driver, I see a couple of problems that I need advice on:

- is it ok if I add a _BCM check in acpi_video_bus_match. i think this
is not a problem.
- acpi_video_bus_check fails out if no _DOS,_ROM,_GPD,_SPD,_VPO. this
check fails on Atlas because it doesn't have any of those
capabilities. The video driver does check for _BCM in
video_device_find_cap but that's at a much later stage. Do you want me
to do something like if (acpi_video_bus_check() &&
acpi_video_output_device_exceptions_detect() )... or do you want me to
do something cleaner and move the whole _BCM detection earlier in the
process?
- acpi_video_bus_get_devices will only call video_bus_get_one_device
if the device node has children. In Atlas, the "Video Bus", (ie: LCD
device in the DSDT I pasted before) has no children, at least as found
by scan.c, so we won't get to get_one_device(). What do you think I
should do about this?

I have a suspicion that for boards like this where ACPI support isn't
so complete, we should just use board specific drivers rather than
mangling the mainstream video driver code. What do you think?

Thanks,
jayakumar
