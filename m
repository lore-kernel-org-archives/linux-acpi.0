From: Greg KH <greg@kroah.com>
Subject: Re: git pull on Linux/ACPI release tree
Date: Wed, 11 Jan 2006 17:37:06 -0800
Message-ID: <20060112013706.GA3339@kroah.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com> <Pine.LNX.4.64.0601081111190.3169@g5.osdl.org> <20060108230611.GP3774@stusta.de> <Pine.LNX.4.64.0601081909250.3169@g5.osdl.org> <20060110201909.GB3911@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <git-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060110201909.GB3911@stusta.de>
Sender: git-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, "Brown, Len" <len.brown@intel.com>, "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 10, 2006 at 09:19:09PM +0100, Adrian Bunk wrote:
> 
> I am using the workaround of carrying the patches in a mail folder, 
> applying them in a batch, and not pulling from your tree between 
> applying a batch of patches and you pulling from my tree.

Ick, I'd strongly recommend using quilt for this.  It works great for
just this kind of workflow.

thanks,

greg k-h
