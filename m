From: Junio C Hamano <junkio@cox.net>
Subject: Re: git pull on Linux/ACPI release tree
Date: Sun, 08 Jan 2006 22:46:06 -0800
Message-ID: <7vlkxpucep.fsf@assigned-by-dhcp.cox.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A136DD@hdsmsx401.amr.corp.intel.com>
	<46a038f90601082208i95cd19fmda542da0da8cc9ef@mail.gmail.com>
	<Pine.LNX.4.64.0601082212420.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <git-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0601082212420.3169@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 8 Jan 2006 22:13:49 -0800 (PST)")
Sender: git-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Martin Langhoff <martin.langhoff@gmail.com>, "Brown, Len" <len.brown@intel.com>, "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> To be fair, backtracking a "git-rebase" isn't obvious. One of the 
> downsides of rebasing.

I thought "git reset --hard ORIG_HEAD" as usual would do.
