From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: git pull on Linux/ACPI release tree
Date: Tue, 10 Jan 2006 13:05:56 -0500
Message-ID: <252A408D-0B42-49F3-92BC-B80F94F19F40@mac.com>
References: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com> <Pine.LNX.4.64.0601091845160.5588@g5.osdl.org> <99D82C29-4F19-4DD3-A961-698C3FC0631D@mac.com> <46a038f90601092238r3476556apf948bfe5247da484@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <git-owner@vger.kernel.org>
In-Reply-To: <46a038f90601092238r3476556apf948bfe5247da484@mail.gmail.com>
Sender: git-owner@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
Cc: Luben Tuikov <ltuikov@yahoo.com>, "Brown, Len" <len.brown@intel.com>, "Luck, Tony" <tony.luck@intel.com>, Junio C Hamano <junkio@cox.net>, Linus Torvalds <torvalds@osdl.org>, "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org, LKML Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Git Mailing List <git@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Jan 10, 2006, at 01:38, Martin Langhoff wrote:
> On 1/10/06, Kyle Moffett <mrmacman_g4@mac.com> wrote:
>> If they all work, then we know precisely that it's the  
>> interactions between them, which also makes debugging a lot easier.
>
> The more complex your tree structure is, the more the interactions  
> are likely to be part of the problem. Is git-bisect not useful in  
> this scenario?

IIRC git-bisect just does an outright linearization of the whole tree  
anyways, which makes git-bisect work everywhere, even in the presence  
of difficult cross-merges.  On the other hand, if you are git- 
bisecting ACPI changes (perhaps due to some ACPI breakage), and ACPI  
has 10 pulls from mainline, you _also_ have to wade through the  
bisection of any other changes that occurred in mainline, even if  
they're totally irrelevant.  This is why it's useful to only pull  
mainline into your tree (EX: ACPI) when you functionally depend on  
changes there (as Linus so eloquently expounded upon).

Cheers,
Kyle Moffett

--
Q: Why do programmers confuse Halloween and Christmas?
A: Because OCT 31 == DEC 25.
