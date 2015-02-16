From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [BUG] b893e80e3147 breaks touchpad on Dell XPS13
Date: Mon, 16 Feb 2015 09:56:58 +0200
Message-ID: <54E1A2CA.4080208@linux.intel.com>
References: <CAEUsAPagb+cO8muTgTCRVg9wN-7rEgYbdSOm4bBOwDre8E-ARA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEUsAPagb+cO8muTgTCRVg9wN-7rEgYbdSOm4bBOwDre8E-ARA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Rorvick <chris@rorvick.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi

On 02/16/2015 09:14 AM, Chris Rorvick wrote:
> Hi,
>
> Commit b893e80e3147 ("ACPI / LPSS: Remove non-existing clock control
> from Intel Lynxpoint I2C") is causing my touchpad to not load on my
> Dell XPS13.  I do not see any errors in the Xorg log, just 20 or so
> lines missing where it would normally be loading the synaptics driver.
> Reverting this commit against Linus's tree (i.e., commit a9724125ad01)
> makes it happy again.
>
> Let me know if you need any further info.
>
Your report is perfect reason for the revert. Even documentation doesn't 
state that clock gating control it's obviously needed in your machine.

Probably some Lynxpoint versions have it and some don't. Anyway best is 
to revert since this clock gating haven't caused any harm on Lynxpoints 
which don't have it.

I'll send a revert in a minute.

-- 
Jarkko
