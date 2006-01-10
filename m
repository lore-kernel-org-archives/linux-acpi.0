From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git pull on Linux/ACPI release tree
Date: Wed, 11 Jan 2006 09:33:11 +1300
Message-ID: <46a038f90601101233h5def4840k315be9520796b5e@mail.gmail.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
	 <Pine.LNX.4.64.0601081111190.3169@g5.osdl.org>
	 <20060108230611.GP3774@stusta.de>
	 <Pine.LNX.4.64.0601081909250.3169@g5.osdl.org>
	 <20060110201909.GB3911@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <git-owner@vger.kernel.org>
In-Reply-To: <20060110201909.GB3911@stusta.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, "Brown, Len" <len.brown@intel.com>, "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 1/11/06, Adrian Bunk <bunk@stusta.de> wrote:
> I am using the workaround of carrying the patches in a mail folder,
> applying them in a batch, and not pulling from your tree between
> applying a batch of patches and you pulling from my tree.

In that case, there's a mostly automated way of doing that if you read
the last couple lines of git-rebase, using something along the lines
of

      git-format-patch <yours> <linus> | git-am -3 -k

> I'd say the main problem is that git with several other projects like
> cogito and stg on top of it allow many different workflows. But finding
> the one that suits one's needs without doing something in a wrong way
> is non-trivial.

You are right about that, but much of the space (of what workflows are
interesting) is still being explored, and git and the porcelains
reacting to people's interests. So it's still a moving target. A fast
moving target.

cheers,


martin
