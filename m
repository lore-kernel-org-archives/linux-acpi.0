From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] acpi: video: trivial style cleanups
Date: Fri, 2 Aug 2013 20:28:25 -0500
Message-ID: <CAMP44s1n7FfGp+KFivVdiMUgKHiyjD5SDaCZkKmfkwfOpzLzUg@mail.gmail.com>
References: <1375400641-1694-1-git-send-email-felipe.contreras@gmail.com>
	<2112254.EC1eeAtOxW@vostro.rjw.lan>
	<CAMP44s2oYm+iE-BYu93-bniTRPiu_LZWSAmAd8xEoNSZJbjemQ@mail.gmail.com>
	<3692149.CN6y0aXjQ7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:41540 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755458Ab3HCB22 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Aug 2013 21:28:28 -0400
In-Reply-To: <3692149.CN6y0aXjQ7@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Aaron Lu <aaron.lwe@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Jiri Kosina <trivial@kernel.org>

On Fri, Aug 2, 2013 at 7:01 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, August 02, 2013 12:56:09 PM Felipe Contreras wrote:
>> On Fri, Aug 2, 2013 at 9:09 AM, Rafael J. Wysocki <rjw@sisk.pl> wrot=
e:
>> > On Thursday, August 01, 2013 11:18:34 PM Felipe Contreras wrote:
>> >> On Thu, Aug 1, 2013 at 8:55 PM, Aaron Lu <aaron.lwe@gmail.com> wr=
ote:
>> >> > On 08/02/2013 07:44 AM, Felipe Contreras wrote:
>> >> >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> >> >
>> >> > Change log please.
>> >>
>> >> You mean a commit message?
>> >
>> > No.  He meant the part that goes between the subject and the signo=
ff.
>> > This is called a change log (or changelog).
>>
>> Not in Git lingo.
>>
>> % man git commit
>>
>> "Though not required, it=E2=80=99s a good idea to begin the commit m=
essage
>> with a single short (less than 50 character) line summarizing the
>> change, followed by a blank line and then a more thorough
>> description."
>
> Please go and read this: https://lwn.net/Articles/560392/

OK, I've read it, and he doesn't seem to have a problem with trivial pa=
tches:

"For the most trivial patches, the one-line summary might suffice"

This patch falls into that category.

> Now, you may still argue that your patches fall into the "add missing=
 include
> of foo.h" category, but it does several different things:
> - fixes some whitespace,
> - fixes a couple of static variable initializations,
> - removes some braces,
> - changes the placement of some lables (some of them unnecessarily).

All of these fall under the category of coding style fixes.

Jonathan Colbert lists the reasons for a detailed commit message descri=
ption:

* the original motivation for the work is quickly forgotten

The motivation is clear; cleanup the code.

* Andrew Morton also famously pushes developers to document the
reasons explaining why a patch was written, including the user-visible
effects of any bugs fixed

It's clear; the reason for the cleanup is that the code is not clean.
There's no user-visible effects of code cleanups.

* Kernel developers do not like having to reverse engineer the intent
of a patch years after the fact.

The intent is clear; cleanup.

> It would be simply *nice* to write what it does in the changelog so t=
hat
> people reading the git log don't have to look deeper to see what chan=
ges the
> author meant as "trivial style cleanups".

Each time I've looked into a cleanup patch, I look at the code, never
the description. Mistakes can be made in the cleanup, the description
won't change that.

I have landed these one-line-commit-message trivial cleanups in the
kernel before. Never have I seen questions of; "what did this cleanup
patch tried to do?", or; "the commit message says you fixed code-style
A, but you also did whitespace changes, was that intended?"

Be honest; if you apply this patch, nobody is going to see it ever agai=
n.

> That's just a matter of making it easier to work with you for other p=
eople,
> but maybe you just want to be difficult to work with in the first pla=
ce?

I add a proper description to the patches that deserve them. This
patch is not one of them.

I update the description according to the feedback to the patches that
deserve that. This patch is not one of them.

No user is ever going to be affected by this patch, I don't care that
much if you apply it or not, it's not important.

It's not worth my time to add a description that nobody is ever going
to read, so if you are going to drop it, go ahead.

If every time somebody provides a trivial cleanup patch you are going
to ask people to describe what each little obvious change it does,
it's no wonder the code doesn't get cleaned up.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
