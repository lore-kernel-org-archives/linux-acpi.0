From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git pull on Linux/ACPI release tree
Date: Mon, 9 Jan 2006 19:08:44 +1300
Message-ID: <46a038f90601082208i95cd19fmda542da0da8cc9ef@mail.gmail.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A136DD@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <git-owner@vger.kernel.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005A136DD@hdsmsx401.amr.corp.intel.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, torvalds@osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 1/9/06, Brown, Len <len.brown@intel.com> wrote:
> This is completely insane.
> Do you have any idea what "sometimes has problems merging" means
> in practice?  It means the tools are really nifty in the trivial
> case but worse than worthless when you need them the most.

Len,

all I meant was that you will sometimes see conflicts. And in that
case, you are far better off cancelling the rebase and doing a merge,
where you will have to resolve the conflicts by hand.

git-rebase is for when the potential merge is clearly trivial. In any
other case, you do want a proper merge. But in any case, it is easy to
do

    git-fetch <upstream> && git-rebase <upstream>

and if it does anything but a very trivial merge, backtrack and do a merge.

In any case, if I have any suspicion that the merge may not be trivial, I do

   git-fetch <upstream> && gitk --since=" 1 month ago" upstream master

before deciding on a course of action. Of course, you can merge all
the time. It's whether people care about a readable/useful history
afterwards.

cheers,


martin
