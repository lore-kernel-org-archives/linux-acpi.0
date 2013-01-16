From: Tom Gundersen <teg@jklm.no>
Subject: Re: [arch-general] powernow-k8 fails to load with linux 3.7.2
Date: Wed, 16 Jan 2013 21:37:58 +0100
Message-ID: <CAG-2HqWBVf=RWXExeFgxYdPTzPfQYZnt-3ZKzULTwdP9+-5mVQ@mail.gmail.com>
References: <20130115224755.085aa6b7@bluemoon> <CAG-2HqWPOYKVCj-Z=z_1e=mE6b6z9hMYFJzHf2GYAmTwQovN0A@mail.gmail.com>
 <20130116131725.4e590c34@bluemoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130116131725.4e590c34@bluemoon>
Sender: cpufreq-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>, Andre Przywara <andre.przywara@amd.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Leonid Isaev <lisaev@umail.iu.edu>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

[dropped arch-general, added kernel folks]

On Wed, Jan 16, 2013 at 8:17 PM, Leonid Isaev <lisaev@umail.iu.edu> wrote:
> On Wed, 16 Jan 2013 11:10:19 +0100
> Tom Gundersen <teg@jklm.no> wrote:
>
>> On Wed, Jan 16, 2013 at 5:47 AM, Leonid Isaev <lisaev@umail.iu.edu> wrote:
>> >         I just installed linux 3.7.2 from [testing] on an AMD system and
>> > noticed that powernow-k8 is not loaded.
>>
>> Probably due to this:
>> <http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e1f0b8e9b04a262834ed1>.

[...]

>> Hm, I thought acpi_cpufreq should have been loaded instead, no idea
>> why that does not happen for you. Could you try loading it manually?
>
> Neither acpi_cpufreq nor powernow_k8 is loaded automatically which of course
> leads to failure of all custom units configuring ondemand governor via
> sysfs. Manually modprob'ing acpi_cpufreq does work and indeed properly scales
> down the frequancy, but is accompanied by an info-level kernel message
> "acpi-cpufreq: overriding BIOS provided _PSD data".
>
> So, if the cpufreq driver works OK for other AMD users, I'll happily blame
> asus...

Matthew, Andre, Rafael,

Is what Leonid experinces above expected behavior or is this a bug? He
is using stock Arch kernel, which is almost vanilla 3.7.3 (see [0] for
the applied patches, nothing looks relevant).

Cheers,

Tom

[0]: <https://projects.archlinux.org/svntogit/packages.git/tree/trunk?h=packages/linux>
