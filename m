From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] ACPI: Enable SCI_EMULATE to manually simulate physical
 hotplug testing.
Date: Thu, 13 Sep 2012 20:50:02 -0700
Message-ID: <CAE9FiQWYSJmCUfjET8UdWHfhbDP45xMdZ+_pd212u_esbsYVhg@mail.gmail.com>
References: <1346707623-31476-1-git-send-email-yinghai@kernel.org>
	<1346776024.4732.196.camel@misato.fc.hp.com>
	<CAE9FiQXN1kDwSPTH5UWvDPbrtqGgcEKR4dWwYrP57H4aSA-UMA@mail.gmail.com>
	<1346794495.4732.221.camel@misato.fc.hp.com>
	<1347582132.3569.13.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347582132.3569.13.camel@misato.fc.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Sep 13, 2012 at 5:22 PM, Toshi Kani <toshi.kani@hp.com> wrote:
>> > >> +
>> > >> +     /*
>> > >> +      * Check for internal object and make sure there is a handler
>> > >> +      * registered for this object
>> > >> +      */
>> > >> +     obj_desc = acpi_ns_get_attached_object(node);
>> > >> +     if (obj_desc) {
>> > >> +             if (obj_desc->common_notify.notify_list[0]) {
>> > >
>> > > Is the above check necessary?  acpi_ev_queue_notify_request() sets up to
>> > > call the global handler, acpi_gbl_global_notify[0], even if the object
>> > > does not have a local handler registered.
>> >
>> > Not sure.
>> >
>> > maybe Len or other acpi guyes could answer your questions.
>>
>> I think this check should be removed, but would like someone to
>> verify...
>
>
> Hi Yinghai,
>
> Attached is my suggested update to your patch. It allows a SCI to be
> sent to any object, and therefore can be used for testing the global
> notify handler. Some drivers such as dock.c only register their handler
> to the global notify handler. I also made a few minor changes. I have
> been testing with this update and it is working fine. I like this
> feature, so I hope we can make progress with this update.

len, can you check them?

Thanks

Yinghai
