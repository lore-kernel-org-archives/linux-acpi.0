From: Jason Uhlenkott <jasonuhl@sgi.com>
Subject: Re: [ACPI] Re: 2.6.12-rc1-mm3
Date: Fri, 25 Mar 2005 18:02:13 -0800
Message-ID: <20050326020212.GC207782@dragonfly.engr.sgi.com>
References: <20050325002154.335c6b0b.akpm@osdl.org> <20050326014327.GB207782@dragonfly.engr.sgi.com> <1111802218.19916.59.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111802218.19916.59.camel@d845pe>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 25, 2005 at 08:56:58PM -0500, Len Brown wrote:
> Please send me the .config you'd like to build.

arch/ia64/configs/sn2_defconfig

> I believe that what we want to do is include CONFIG_PM.

At first glance, it looks like that will enable suspend/resume
functionality (which I don't think we want on SGI sn2) for a bunch of
drivers.
