From: Tony Luck <tony.luck@intel.com>
Subject: Re: git pull on Linux/ACPI release tree
Date: Sun, 8 Jan 2006 12:50:27 -0800
Message-ID: <12c511ca0601081250h726b0e14u7703f9d6910891ee@mail.gmail.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
	 <46a038f90601081119r39014fbi995cc8b6e95774da@mail.gmail.com>
	 <7vace61plu.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0601081156430.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932766AbWAHUu3@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0601081156430.3169@g5.osdl.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Junio C Hamano <junkio@cox.net>, Martin Langhoff <martin.langhoff@gmail.com>, "Brown, Len" <len.brown@intel.com>, "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

I'll try to update the using-topic-branches document to capture this.
Some of the problem is that it doesn't quite capture what I'm doing
with my test/release branches.

My release branch really is just used as a transfer point to Linus.
I usually[1] don't leave patches sitting in "release" for long enough
that I'll be tempted to merge in from Linus ... once I decide that
some patches are ready to go to Linus I'll update "release" from Linus
(which will be a fast-forward, so no history) merge in the topic
branches, do one final sanity build, push to kernel.org and send
the "please pull" e-mail.

The huge majority of my "automatic update from upstream" merges
go into my test branch ... which never becomes part of the real
history as I never ask Linus to pull from it.

-Tony

[1] Sometimes I goof on this because I forget that I've applied
a trivial patch directly to the release branch without going through
a topic branch.  I think I'll fix my update script to check for this case.
