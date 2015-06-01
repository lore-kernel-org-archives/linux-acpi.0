From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/3] Use acpi_video_unregister_backlight instead of acpi_video_unregister
 in platfrom backlight drivers
Date: Mon, 01 Jun 2015 19:58:17 +0200
Message-ID: <556C9D39.8030506@redhat.com>
References: <1433150708-8498-1-git-send-email-hdegoede@redhat.com> <20150601174103.GC87111@vmdeb7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20150601174103.GC87111@vmdeb7>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Ben Skeggs <bskeggs@redhat.com>, platform-driver-x86@vger.kernel.org, dri-devel@lists.freedesktop.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Darren,

On 01-06-15 19:41, Darren Hart wrote:
> On Mon, Jun 01, 2015 at 11:25:05AM +0200, Hans de Goede wrote:
>> Hi All,
>>
>> I'm working on cleaning up the currently somewhat convoluted logic to
>> select which backlight interfaces to register on x86 systems, see:
>> http://lists.freedesktop.org/archives/dri-devel/2014-December/074687.html
>>
>> For a rought outline (details will change in the actual patch-set).
>>
>> These 3 patches are a preparation for that work, as the behavior of the
>> current code is not always consistent (it changes depending on module
>> loading order in some cases). These 3 patches remove this inconsistency
>> which in some cases may result in a behavior change.
>>
>> This way the cleanup can have a consistent base to build upon, and I can
>> ensure that the cleanup itself does not cause any functional changes.
>>
>> I hope to post a v1 of the actual cleanup patch-set in 1-2 weeks.
>
> That will likely mean we miss the 4.2 merge window and will target this for 4.3
> (which is fine by me, but just so you know).

IMHO this patches are worthwhile to have by themselves, as said
they fix various inconsistencies, which is a good thing to fix
regardless.

I think that these going into 4.2, and the cleanup which depends on them
(but is other then that pretty much an orthogonal patch set) going into
4.3 is actually a good thing, because if people then experience any
problems due to my work on this, we can easily see if it is due to
the behavior change these 3 patches may introduce in some cases, or
if it is due to the actual cleanup causing a behavior change (which it
should not).

Regards,

Hans
