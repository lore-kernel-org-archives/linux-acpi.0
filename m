From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH 2/3] Add rfkill support to compal-laptop
Date: Tue, 18 Aug 2009 22:08:14 +0100
Message-ID: <9b2b86520908181408v5f7875b6sea31d8d95cc08c0b@mail.gmail.com>
References: <4A89E768.7010207@dell.com>
	 <1250558643.30166.109.camel@localhost.localdomain>
	 <9b2b86520908180044l72cb8642j6256e246662f7971@mail.gmail.com>
	 <9b2b86520908180752k66feda09rf9034a96ac6ef470@mail.gmail.com>
	 <4A8AE459.8060102@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752238AbZHRVIQ@vger.kernel.org>
In-Reply-To: <4A8AE459.8060102@dell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: "johannes@sipsolutions.net" <johannes@sipsolutions.net>, Marcel Holtmann <marcel@holtmann.org>, cezary.jackiewicz@gmail.com, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 8/18/09, Mario Limonciello <mario_limonciello@dell.com> wrote:
> Hi Alan & Marcel:
>
> Alan Jenkins wrote:
>> Also, you're missing the calls to rfkill_destroy() here.
>>
>> Whew, I think that's everything.  I hope you find the feedback useful,
>> despite it being a little fragmented.
>>
>>
> Thanks for all the feedback.  I think i've addressed all of the concerns
> that were pointed out.  I appreciate the pointer to scripts/cleanpatch,
> that does significantly help in finding whitespace problems that the
> naked eye just browses over.
>
> I'm attaching the updated patch (sorry, git send-email seems to still
> not be very graceful with line breaks when the SMTP implementation is
> exchange from what i've seen)

> +static void compal_rfkill_poll(struct rfkill *rfkill, void *data)
> +{
> +	unsigned long radio = (unsigned long) data;
> +	u8 result;
> +	bool hw_blocked;
> +	bool sw_blocked;
> +
> +	ec_read(COMPAL_EC_COMMAND_WIRELESS, &result);
> +
> +	hw_blocked = !(result & KILLSWITCH_MASK);
> +	sw_blocked = (!hw_blocked && !(result & radio));
> +
> +	rfkill_set_states(rfkill, sw_blocked, hw_blocked);
> +}

I assume you have good reason for having sw_block depend on hw_block.
I.e. you can't read sw_blocked while hw_blocked is set, right?

If KILLSWITCH is toggled on and off, will the hardware "forget" any
prior soft-blocks?

It would also be nice to know if hardware/firmware ever changes
sw_blocked, e.g. in response to a button press.

Johannes, I think I'm confusing myself here.  Can you have a look at
this code?  I remember the rfkill rewrite was designed to help with
something like this, but I don't know how exactly.

Thanks
Alan
