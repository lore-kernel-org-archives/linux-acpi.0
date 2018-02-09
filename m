From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] acpi/dptf: document sysfs atttributes
Date: Fri, 9 Feb 2018 11:57:50 +0100
Message-ID: <CAJZ5v0gwiuo_b_N_8PjJ7Q532s1V-e37080Dk0YCNs+nMDVOVQ@mail.gmail.com>
References: <cover.1518009225.git.aishpant@gmail.com> <01eb929d8dbfa3e2041d33619a7d30a6b0f4748c.1518009225.git.aishpant@gmail.com>
 <CAJZ5v0i5=EdmR_6Kcg=r5XUBtt8yaQX_yHt_qRfZLU-q85gkBQ@mail.gmail.com> <20180209105425.GA24487@mordor.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180209105425.GA24487@mordor.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Aishwarya Pant <aishpant@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 9, 2018 at 11:54 AM, Aishwarya Pant <aishpant@gmail.com> wrote:
> On Fri, Feb 09, 2018 at 11:31:35AM +0100, Rafael J. Wysocki wrote:
>> On Wed, Feb 7, 2018 at 2:18 PM, Aishwarya Pant <aishpant@gmail.com> wrote:
>> > The descriptions have been collected from git commit logs and reading
>> > through code.
>> >
>> > Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
>> > ---
>> >  Documentation/ABI/testing/sysfs-platform-dptf | 30 +++++++++++++++++++++++++++
>> >  1 file changed, 30 insertions(+)
>> >  create mode 100644 Documentation/ABI/testing/sysfs-platform-dptf
>> >
>> > diff --git a/Documentation/ABI/testing/sysfs-platform-dptf b/Documentation/ABI/testing/sysfs-platform-dptf
>> > new file mode 100644
>> > index 000000000000..e8168e5198d7
>> > --- /dev/null
>> > +++ b/Documentation/ABI/testing/sysfs-platform-dptf
>> > @@ -0,0 +1,30 @@
>> > +sysfs interface for ACPI DPTF platform power driver
>> > +---------------------------------------------------
>>
>> The header isn't necessary.
>>
>> > +
>> > +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/charger_type
>> > +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/adapter_rating_mw
>> > +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/max_platform_power_mw
>> > +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/platform_power_source
>> > +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/battery_steady_power
>>
>> There should be one entry per attribute AFAICS.
>
> I grouped attributes by the date in which they were added for brevity, because
> otherwise fields like Date added, KernelVersion and Contact information are the
> same.
>
> I can split them up if it makes more sense...

That's what the format is from looking at the existing files.
