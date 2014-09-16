From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH 10/13] eeepc-laptop: compare proper return values in get_cpufv
Date: Tue, 16 Sep 2014 13:54:25 +0200
Message-ID: <CAH6sp9N1y3=LLju85ZHgc05ENUYLgUdYBYpemc6_oNhbsZ+r6g@mail.gmail.com>
References: <1410563212-31565-1-git-send-email-fransklaver@gmail.com>
	<1410563212-31565-11-git-send-email-fransklaver@gmail.com>
	<20140915214902.GB64909@vmdeb7>
	<20140915215125.GA21435@kroah.com>
	<20140915215527.GC7867@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140915215527.GC7867@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Darren Hart <dvhart@infradead.org>, Corentin Chary <corentin.chary@gmail.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, acpi4asus-user <acpi4asus-user@lists.sourceforge.net>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-acpi <linux-acpi@vger.kernel.org>, "H. Peter Anvin" <hpa@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 15, 2014 at 11:55 PM, Frans Klaver <fransklaver@gmail.com> wrote:
> On Mon, Sep 15, 2014 at 02:51:25PM -0700, Greg Kroah-Hartman wrote:
>> On Mon, Sep 15, 2014 at 02:49:02PM -0700, Darren Hart wrote:
>> >
>> > This patch is fine as is. However, Greg has supported propogating the error code
>> > through to the sysfs interface (if I understand him correctly on an earlier post
>> > to this list). This would require an addition change to this patch would
>> > propogated the get_cpufv error code in show_available_cpuv(), show_cpuv(), and
>> > store_cpuv(). As it is, we return -ENODEV on any failure, where an ACPI call
>> > error should probably return -ENXIO as I understand it.
>>
>> I really have no idea at this point in time what to recommend.  How
>> about just stick with what is happening today so that:
>>
>> > However, there was a rather famous change in error code handling in which pulse
>> > audio broke and Linus was very upset with one of his maintainers.
>>
>> That doesn't happen :)
>
> So if I interpret that correctly, we're dropping the last patch
> (ENODEV -> ENXIO) from the series? That's fine by me. As mentioned
> earlier, I already saw something else break because I returned ENXIO
> instead of ENODEV.
>
> Maybe it's a good idea to try and document the expected behavior
> somewhere, if even Greg isn't sure what to do.

For good measure:

v2 will not change the return values at the sysfs interface, meaning
we will always return -ENODEV on error. I am going to try to keep as
much internal functions propagating errors as possible though, unless
someone strongly disagrees.

Thanks,
Frans
