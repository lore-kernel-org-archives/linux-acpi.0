From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PULL] ACPI & Power Management patches for Linux-3.4-merge
Date: Fri, 30 Mar 2012 15:54:23 -0400
Message-ID: <4F760F6F.5060002@kernel.org>
References: <4F759B4A.5010807@kernel.org> <CA+55aFxHpGhs72T6BNSaHJiZVRSKg8LTtWm7728RzP=+mrGTmQ@mail.gmail.com> <CA+55aFx8XT0biUUWfTRf1VJC_2dgcqV5Lr3AxQG0ze+B0gSC9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFx8XT0biUUWfTRf1VJC_2dgcqV5Lr3AxQG0ze+B0gSC9A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Lee <rob.lee@linaro.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

I'll take curtain C:-)

Will send you a fresh merge request in about an hour.
Sorry for the trouble.

thanks,
-Len


On 03/30/2012 03:32 PM, Linus Torvalds wrote:

> On Fri, Mar 30, 2012 at 12:16 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> But there's been at least three merges that submaintainers did for me
>> this merge window where I looked at their merge and said "No, that's
>> wrong, and I would have done it better". Two of those were the nice
>> kind of "I left it unmerged, but here's my example merge if you want
>> to take it", so the wrong merges didn't ever show up in the tree. But
>> yours is now no longer even the top commit in your pile of fixes, so
>> now I apparently have to take that *known*incorrect* merge and fix it
>> up with an evil merge of my own.
> 
> Ugh. I'm undoing my merge rather than do that evil merge that fixes up yours.
> 
> So I have three choices:
> 
>  (a) I can just re-do your merge, and lose the two commits you had on top of it
> 
>  (b) I can create a new local branch with your pre-merged state, and
> cherry-pick the two commits on top of that, and then merge that, and
> then fake out the pull request.
> 
>  (c) I can ask you to do that fix up (rebase those two commits on top
> of the state before the broken merge), and then you can ask me to pull
> again, without the merge - same as (b) really, but I don't have to
> fake the pull request message when I create the merge.
> 
> I think I'll do (c), but then probably fall back on (a) if I don't
> hear from you. (b) gets me the tree I want, but I don't like faking
> pull requests - I've occasionally pulled less than requested (exactly
> because I didn't like the top merge), but I try to avoid actually
> adding modified commits on top.
> 
>                   Linus
