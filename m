From: Adrian Bunk <bunk@stusta.de>
Subject: Re: git pull on Linux/ACPI release tree
Date: Fri, 13 Jan 2006 15:50:27 +0100
Message-ID: <20060113145027.GN29663@stusta.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com> <Pine.LNX.4.64.0601081111190.3169@g5.osdl.org> <20060108230611.GP3774@stusta.de> <Pine.LNX.4.64.0601081909250.3169@g5.osdl.org> <20060110201909.GB3911@stusta.de> <20060112013706.GA3339@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <git-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060112013706.GA3339@kroah.com>
Sender: git-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>, "Brown, Len" <len.brown@intel.com>, "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 11, 2006 at 05:37:06PM -0800, Greg KH wrote:
> On Tue, Jan 10, 2006 at 09:19:09PM +0100, Adrian Bunk wrote:
> > 
> > I am using the workaround of carrying the patches in a mail folder, 
> > applying them in a batch, and not pulling from your tree between 
> > applying a batch of patches and you pulling from my tree.
> 
> Ick, I'd strongly recommend using quilt for this.  It works great for
> just this kind of workflow.

It works in my case because I'm only going through the folder with the 
trivial patches in batches and ask Linus to pull from my tree 
immediately after I'm finished.

That would certainly not be a recommended practice for a subsystem 
maintainer, but I'm handling only trivial patches.

> thanks,
> 
> greg k-h

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
