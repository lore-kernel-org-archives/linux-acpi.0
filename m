From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: 2.6.32-rc1: spurious error message from "ACPI button: provide
 lid status functions"
Date: Mon, 5 Oct 2009 16:59:07 -0700
Message-ID: <20091005165907.291b9c6c@jbarnes-g45>
References: <4AC72D09.3040907@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755361AbZJEX7y@vger.kernel.org>
In-Reply-To: <4AC72D09.3040907@tuffmail.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Eric Anholt <eric@anholt.net>, Matthew Garrett <mjg59@srcf.ucam.org>, linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 03 Oct 2009 11:52:57 +0100
Alan Jenkins <alan-jenkins@tuffmail.co.uk> wrote:

> ACPI: Waking up from system sleep state S4
> PM: Device PNP0C0D:00 failed to thaw: error 1
> 
> The device appears to be the acpi lid "button".  The error comes from
> calling acpi_lid_send_state():
> 
>     @@ -242,7 +272,12 @@ static int acpi_lid_send_state(struct
>     acpi_device *device)
>          /* input layer checks if event is redundant */
>          input_report_switch(button->input, SW_LID, !state);
>          input_sync(button->input);
>     -    return 0;
>     +
>     +    ret = blocking_notifier_call_chain(&acpi_lid_notifier, state,
>     device);
>     +    if (ret == NOTIFY_DONE)
>     +        ret = blocking_notifier_call_chain(&acpi_lid_notifier,
> state,
>     +                           device);
>     +    return ret;
>      }
> 
> 
> The "error 1" is actually NOTIFY_OK.
> 
>     @include/linux/notify.h:
>     #define NOTIFY_DONE        0x0000        /* Don't care */
>     #define NOTIFY_OK        0x0001        /* Suits me */
>     #define NOTIFY_STOP_MASK    0x8000        /* Don't call further */
>     #define NOTIFY_BAD        (NOTIFY_STOP_MASK|0x0002)
>                             /* Bad/Veto action */
>     /*
>      * Clean way to return from the notifier and stop further calls.
>      */
>     #define NOTIFY_STOP        (NOTIFY_OK|NOTIFY_STOP_MASK)
> 
> 
> Clearly acpi_lid_send_state() should return 0 for NOTIFY_OK.  I guess
> NOTIFY_STOP can be ignored until someone says they need it.
> 
> But I don't understand the NOTIFY_DONE case, so I'm not sure.  I can't
> find any users to reverse engineer it.  IMO it either needs to be
> removed or commented.
> 
> Can you please sort this out, so we don't see this error message on a
> completely successful resume?

Ah yeah, this does look funky.  I'll fix it up.

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
