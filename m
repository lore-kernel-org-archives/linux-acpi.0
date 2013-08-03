From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] acpi: video: trivial costmetic cleanups
Date: Sat, 3 Aug 2013 15:28:58 -0500
Message-ID: <CAMP44s11E1z96swMrn6NwSeXopXL8NMs+F+SZXnGm2t2N2i24g@mail.gmail.com>
References: <1375400641-1694-1-git-send-email-felipe.contreras@gmail.com>
	<2947185.O65YUjZvxL@vostro.rjw.lan>
	<CAMP44s0J4gjcnFhL=+oz0Wkrd5edeDhFc39bOdbf4aaefuDmNQ@mail.gmail.com>
	<1714177.6pDg1Dt5hn@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1714177.6pDg1Dt5hn@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Aaron Lu <aaron.lwe@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Jiri Kosina <trivial@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Aug 3, 2013 at 6:38 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, August 02, 2013 08:34:29 PM Felipe Contreras wrote:
>> On Fri, Aug 2, 2013 at 7:07 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > On Friday, August 02, 2013 12:52:18 PM Felipe Contreras wrote:
>> >> On Fri, Aug 2, 2013 at 9:05 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> >> > On Thursday, August 01, 2013 11:15:38 PM Felipe Contreras wrote:
>> >> >> On Thu, Aug 1, 2013 at 8:50 PM, Aaron Lu <aaron.lwe@gmail.com> wrote:
>> >> >> > On 08/02/2013 07:43 AM, Felipe Contreras wrote:
>> >> >> >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> >> >> >
>> >> >> > Please add change log explaining what you have changed.
>> >> >> > It seems that the patch modify comment style only, some add a space and
>> >> >> > some change spaces to tab, is it the case?
>> >> >>
>> >> >> The commit message already explains what the change is; trivial
>> >> >> cosmetic cleanups. Cosmetic means it's completely superficial.
>> >> >
>> >> > And I have a rule not to apply patches without changelogs.  So either I'll
>> >> > need to write it for you, or can you add one pretty please?
>> >>
>> >> The commit message is right there. Maybe Jiri can apply it then, if
>> >> not, then stay happy with your untidy code.
>> >
>> > First of all, I didn't say I wouldn't apply the patch, did I?
>> >
>> > Second, I asked you *nicely* to add a changelog so that I don't need to write
>> > it for you.
>> >
>> > I don't know what made it difficult to understand.
>> >
>> > Anyway, I ask everyone to write changelogs and nobody has had any problems with
>> > that so far.  I don't see why I should avoid asking you to follow the rules
>> > that everybody else is asked to follow.  If those rules are too difficult for
>> > you to follow, I'm sorry.
>>
>> The patch has a commit message that describes exactly what it does.
>
> No, it doesn't describe it exactly.  You're contradicting facts.
>
>> Unless there is valid feedback I will not send another version.
>>
>> To me, a valid criticism to the commit message would be: "I read X,
>> but I thought it would do Y". For example; "I didn't expect the patch
>> to do white-space cleanups", but I think that's exactly what people
>> expect when they read "trivial costmetic cleanups'.
>
> If what you're saying was correct, then it would be sufficient to use a
> "this patch fixes a bug" commit message for every bug fix, but quite evidently
> that is not the case.

No, it wouldn't be sufficient, take a look a the Corbert's list you
yourself mentioned:

* the original motivation for the work is quickly forgotten

"this patch fixes a bug" doesn't describe the motivation.

* Andrew Morton also famously pushes developers to document the
reasons explaining why a patch was written, including the user-visible
effects of any bugs fixed

The reason for the patch is not documented, nor the user-visible effects.

* Kernel developers do not like having to reverse engineer the intent
of a patch years after the fact.

The intent of the patch is not mentioned.

That is completely different with my patch.

Personally I like to answer these questions: What is the patch is
doing (motivation)? What is the current problem? What is the change?
What are the side-effects?

All those are clear with "trivial costmetic cleanups", they are not
with "this patch fixes a bug".

I think you are committing a hasty generalization fallacy. Not all
patches are the same.

-- 
Felipe Contreras
