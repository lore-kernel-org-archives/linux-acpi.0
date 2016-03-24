From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6] acpi: Issue _OSC call for native thermal interrupt handling
Date: Thu, 24 Mar 2016 02:28:59 +0100
Message-ID: <CAJZ5v0hh9mGyHyJSubW-76w3jKLaQHjQcra9mC8m8jHK9oC9kw@mail.gmail.com>
References: <1458706064-4147-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	<56F2C7B5.4000208@hpe.com>
	<1458764521.27934.168.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458764521.27934.168.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Linda Knippers <linda.knippers@hpe.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, "open list:EDAC-CORE" <linux-edac@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Mar 23, 2016 at 9:22 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Wed, 2016-03-23 at 12:43 -0400, Linda Knippers wrote:
>> I raised a general concern on a previous patch so I found a 1P server
>> with Skylake and HWP to try.  This doesn't qualify as a tested-by
>> since all I did was apply the patch and boot the server but hey, it
>> booted.
> Thanks.
>
>>
>> I do have a question below...
>>
> [...]
>> +     if (ACPI_SUCCESS(acpi_run_osc(handle, &osc_context))) {
>> > +           acpi_hwp_native_thermal_lvt_set = true;
>> > +           kfree(osc_context.ret.pointer);
>>
>> There are other boot messages that indicate when something is
>> happening
>> with _OSC.  Should there be one for this?  Or is there some other
>> obvious
>> way one can know that this was set?
>>
> I am following model of acpi_bus_osc_support, which issues _OSC for
> global platform scope, where nothing is getting printed. If it is
> useful, I don't mind adding a print.
>
> Rafael,
>         What do you think?

Printing a message after acpi_run_osc() has been called successfully
shouldn't hurt.  Maybe using acpi_handle_info()?

Thanks,
Rafael
