From: "Walter Francis" <wally@theblackmoor.net>
Subject: Re: PROBLEM:  ACPI Thermal Zone for CPU0 does not update after     
     hibernation
Date: Mon, 9 Apr 2007 22:18:33 -0400 (EDT)
Message-ID: <33655.192.168.0.107.1176171513.squirrel@panacea.theblackmoor.net>
References: <11584.192.146.101.26.1175890435.squirrel@panacea.theblackmoor.net>
    <20070409174700.2e0a14d8.akpm@linux-foundation.org>
    <33389.192.168.0.107.1176169658.squirrel@panacea.theblackmoor.net>
    <20070409185702.bbea2cb9.akpm@linux-foundation.org>
Reply-To: wally@theblackmoor.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932561AbXDJCTU@vger.kernel.org>
In-Reply-To: <20070409185702.bbea2cb9.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Jung-Ik  Lee <jilee@google.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

> On Mon, 9 Apr 2007 21:47:38 -0400 (EDT) "Walter Francis"
> <wally@theblackmoor.net> wrote:
>
>> > On Fri, 6 Apr 2007 16:13:55 -0400 (EDT)
>> > "Walter Francis" <wally@theblackmoor.net> wrote:
>>
>> >> After hibernating, the CPU0 thermal zone never updates.  It will stay at
>> 59C
>> >> forever for example.

> Yes, the above looks like the correct change.

> Strange.  Maybe a timing thing.

> Yes it does.  What happens of you stop and restart the daemon a second
> time?

Same thing, although I reverted the change and it still happens, so I must
have overlooked it before.  Which is odd, because it's right at the end of my
suspend script.  Looked to see if the cpuspeed daemon has updated recently and
it hasn't.  Strange. :)

> fwiw, /proc/acpi/thermal_zone/ATF0/temperature seems to do the right thing
> here.

SMP?  Not sure if it's directly tied to SMP, my other laptop I never could get
to behave when suspending.

If there's any more info I can provide or patches to try, let me know.

-- 
Walter Francis

khayts.us
theblackmoor.net
unlimitedphoto.com
