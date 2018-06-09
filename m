From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [GIT PULL] libnvdimm for 4.18
Date: Sat, 9 Jun 2018 08:17:27 -0700
Message-ID: <CAPcyv4hPTyfSO5pncQ84cPrTe4sUJ+jA6cMHXm-6ocvLGKr65A@mail.gmail.com>
References: <1528502307.25740.14.camel@intel.com>
 <CA+55aFy_fiF2bwW=0gL4g8uL5099hWarL4+Q9djmDEuwRR2KKw@mail.gmail.com>
 <CA+55aFyTXHxaRQhsCwgicFw6=xk80Bjw92tgfmmRP4HQ-AhSvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <CA+55aFyTXHxaRQhsCwgicFw6=xk80Bjw92tgfmmRP4HQ-AhSvw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 8, 2018 at 5:26 PM, Linus Torvalds
<torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org> wrote:
> On Fri, Jun 8, 2018 at 5:19 PM Linus Torvalds
> <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org> wrote:
>>
>> If I get stuff that looks at all complex at the end of the merge
>> window, I will just cackle unpleasantly while I press the big 'D' key
>> on my keyboard.
>
> Side note: looking at what I just pulled, there was close to a D key here too.
>
> Dammit, the top commit in your tree is a merge. And the merge message
> for that merge is this:
>
>     Merge branch 'for-4.18/mcsafe' into libnvdimm-for-next
>
> That's it. One line. That doesn't say anything at all.
>
> That kind of uninformative commit message wouldn't be remotely
> acceptable for a regular simple one-liner patch.
>
> WHY THE HELL DO PEOPLE CONTINUE TO THINK THAT IT'S OK FOR MERGES?
>
> Dammit. Merges are *more* complex than random usual patches. They need
> proper commit messages. Yet you have two merges there with absolutely
> *no* information in the commit message.
>
> If you can't be bothered to write an informative commit message for a
> merge, you damn well shouldn't do the merge.
>
> It really is that simple.

Well, crap. I've been doing it the wrong way for a while. Do you have
a preference for more pull requests or just splitting what is now a
top level tag message into a summary changelog per branch when I merge
the ready branches for the merge window? I had been assuming that the
arrangement you have with Ingo / Thomas to pull individual topics was
a privilege for the tip tree and not necessarily something everyone
that sends you pulls should be doing.
