From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: ACPI-video: Fine-tuning for several function implementations
Date: Wed, 7 Sep 2016 08:40:50 +0200
Message-ID: <df98177a-58e6-b5a3-d6b6-307625ba17b5@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
 <CAJZ5v0hug9QfZHQosCFFXEcFMsDd=YvXkqMmQya3RSqmOnY4dg@mail.gmail.com>
 <3e0cdc5b-fd15-515a-82f2-2f44792664ed@users.sourceforge.net>
 <CAJZ5v0gWgxbtJ4m0eDkdOaR_usjTqmcWBWds5qprr+ydHhEjnA@mail.gmail.com>
 <6882cbb1-3f61-fb64-2972-30c277f28580@users.sourceforge.net>
 <CAJZ5v0hyhdUknW8RqpT6f4zAuPuMN1EN=P7C54Aa+VqEK2pcGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hyhdUknW8RqpT6f4zAuPuMN1EN=P7C54Aa+VqEK2pcGw@mail.gmail.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: linux-acpi@vger.kernel.org

> Your patches happen to modify code maintained by me.  From my
> perspective the value of the changes made by them is marginal.

Thanks for another bit of interesting information.


> Nevertheless, I might take them if you made my life somewhat easier,

I am also looking for further approaches to help you there.


> so I've tried to tell you politely how to do that.

This feedback is generally fine.


> If you're not willing to do it,

My willingness is depending on also some factors.


> though, this is where it ends.

I hope that a bit more clarification can improve the situation.


> And attempts to convince me that I may not want my life to be easier
> after all are not likely to succeed.

We usually want that life will become more comfortable.

I chose to contribute something to Linux source files for this purpose.
My knowledge evolved in the way that I am using some tools for
static source code analysis. Such advanced tools can point various
change opportunities out. I picked a few special search patterns up.
It happened then that hundreds of source files were found which contain
update candidates. I am trying to inform the corresponding developers
about improvement possibilities in affected systems.


Further challenges are relevant then as usual.

* Handling of the search process and their results

* Communication between contributors


Search patterns can occasionally be categorised as "too special".
The software technology contains also the risk for showing "false positives".

The reactions of code reviewers are varying between rejection and acceptance.
Now I would like to determine again which details of the proposed changes
have got a higher chance for acceptance.

The discussed concrete patch series is just another example for usual
difficulties or more interesting software development challenges.
I hope that they can be resolved in a systematic way.
I sent analysis results as a series of small software updates. I find
it important to understand them also in the way that they belong to
software design patterns. I can imagine that it is harder to recognise
the involved patterns from the presented combination of update steps.

Would you like to check and clarify these patterns once more
before the desired improvements will happen (in a software area you maintain)?


So there are further constraints to consider. My software development experience
leaded me to a very specific kind of patch granularity here.
My software development interest evolved also in the way that I dared
to fiddle with the source files "drivers/acpi/processor_perflib.c"
and "drivers/acpi/processor_throttling.c" yesterday.
The consequence is that I would to publish a corresponding series
of 30 update steps for integration into another source code repository.
It seems that I need to wait a bit more for the next contribution attempt
before the change acceptance will fit to such an approach.

Regards,
Markus
