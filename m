From: Daniel Exner <dex@dragonslave.de>
Subject: Re: linux-next Regression: Unable to locate IOAPIC
Date: Sun, 15 Jun 2008 21:14:32 +0200
Message-ID: <200806152114.33007.dex@dragonslave.de>
References: <200806051100.12885.dex@dragonslave.de> <48536E3B.4000703@gmail.com> <86802c440806140126l7a949783of0fb08d11ae07bef@mail.gmail.com>
Reply-To: webmaster@dragonslave.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <86802c440806140126l7a949783of0fb08d11ae07bef@mail.gmail.com>
Content-Disposition: inline
Sender: linux-next-owner@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
List-Id: linux-acpi@vger.kernel.org

Hi all,

Yinghai Lu wrote:
> >> To clarify myself:
> >> 2.6.25.5:  --> relatively fast no IOAPIC Errors in dmesg
> >> 2.6.26-rc5:   --> relatively  no IOAPIC Errors in dmesg
> >> 2.6.26-rc5 + git-acpi Patch:   --> relatively  no IOAPIC Errors in dmesg
> >> 2.6.26-rc5 +  linux-next snapshot 20080604 --> even slower than before
> >> my ide Patch many "unable to locate IOAPIC" Errors
> >>
> >>
> >> So I think the problem lies not in the acpi tree but somewhre else.
> >>
> >> Is it possible to tell git to explicitly _exclude_ a specific tree while
> >> bisecting?
>
> can you check if the attached patch fix the problem?
> it will not check entries before MP_intsrc_info...
This fixed it, thanks :)

Also maschine feels not as fast as with 2.6.25.x but noticeable faster :)

I guss you no longer need the complete dmesg output?

Greetings
Daniel Exner
