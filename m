From: Stelian Pop <stelian@popies.net>
Subject: Re: [ACPI] [PATCH, new ACPI driver] new sony_acpi driver
Date: Tue, 15 Feb 2005 16:39:12 +0100
Message-ID: <20050215153912.GA3523@crusoe.alcove-fr>
References: <20050210161809.GK3493@crusoe.alcove-fr> <1108481448.2097.71.camel@d845pe>
Reply-To: Stelian Pop <stelian@popies.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108481448.2097.71.camel@d845pe>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 15, 2005 at 10:30:49AM -0500, Len Brown wrote:

> On Thu, 2005-02-10 at 11:18, Stelian Pop wrote:,
> 
> > 
> > PS: I am also going to submit a bugzilla RFE for the acpi people,
> > I have been told they are more receptive to that.
> 
> I guess that refers to me:-)

Hey, you *are* more receptive to bugzilla then !

> E-mail is fine, but the unfortunate reality is that due to simple
> volume, it is lossy.  The reason we like bugzilla is that it never
> forgets:-)
> 
> So thanks for taking the extra time to file a bug report
> http://bugzilla.kernel.org/show_bug.cgi?id=4193
> 
> If it turns out that there is no way a generic solution
> can handle the SNC Sony laptops, then I agree that a

Note: this is not a subset of the Sony laptops, we are talking
about all the Sony laptops here.

> platform specific wart is the only way to go.  But
> it would be best if we can make the exotic Sony/SNC
> look more generic to the user so that the user
> (and the distro supporting them) don't need to learn
> special things to handle this system.

I agree, but unfortunately I don't think it's possible to handle
them in a generic way. However, my understanding of the ACPI layer
is limited, so I very well be wrong.

I attached two DSDT in bugzilla, I have a few more if you want them.

Stelian.
-- 
Stelian Pop <stelian@popies.net>
