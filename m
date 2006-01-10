From: Kyle Moffett <mrmacman_g4-ee4meeAH724@public.gmane.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Tue, 10 Jan 2006 01:33:27 -0500
Message-ID: <99D82C29-4F19-4DD3-A961-698C3FC0631D@mac.com>
References: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com> <Pine.LNX.4.64.0601091845160.5588@g5.osdl.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0601091845160.5588-hNm40g4Ew95AfugRpC6u6w@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luben Tuikov <ltuikov-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Junio C Hamano <junkio-j9pdmedNgrk@public.gmane.org>, Martin Langhoff <martin.langhoff-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Jan 09, 2006, at 21:50, Linus Torvalds wrote:
> if we  have three independent features/development trees, they can  
> be debugged independently too, while any linkages inevitably also  
> mean that any bugs end up being interlinked..

One example:

If I have ACPI, netdev, and swsusp trees change between an older  
version and a newer one, and my net driver starts breaking during  
suspend, I would be happiest debugging with the following set of  
patches/trees (Heavily simplified):

            ^
            |
           [5]
            |
          broken
         ^  ^   ^
       [2] [3]  [4]
       /    |     \
netdev3  acpi3   swsusp3
    ^       ^        ^
    |       |        |
netdev2  acpi2   swsusp2
    ^       ^        ^
    |       |        |
netdev1  acpi1   swsusp1
       ^    ^    ^
        \   |   /
         \  |  /
          \ | /
           \|/
            |
           [1]
            |
          works


If the old version [1] works and the new one [5] doesn't, then I can  
immediately test [2], [3], and [4].  If one of those doesn't work,  
I've identified the problematic patchset and cut the debugging by  
2/3.  If they all work, then we know precisely that it's the  
interactions between them, which also makes debugging a lot easier.

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.  The first method is far more difficult.
   -- C.A.R. Hoare


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
