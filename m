From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Sun, 8 Jan 2006 11:57:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601081156430.3169@g5.osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
 <46a038f90601081119r39014fbi995cc8b6e95774da@mail.gmail.com>
 <7vace61plu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <git-owner@vger.kernel.org>
In-Reply-To: <7vace61plu.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
Cc: Martin Langhoff <martin.langhoff@gmail.com>, "Brown, Len" <len.brown@intel.com>, "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org



On Sun, 8 Jan 2006, Junio C Hamano wrote:
> 
> Careful.  I do not think rebase works across merges at all.

Right. You have to do one or the other (rebase your changes to another 
tree _or_ merge another tree into your changes), but not mix the two.

		Linus
