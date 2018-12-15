From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] acpi / apei: fix NULL deref during init
Date: Sat, 15 Dec 2018 09:05:47 +0100
Message-ID: <20181215080547.GD10074@kroah.com>
References: <20181214181514.29891-1-tst@schoebel-theuer.de>
 <20181214202406.GI11710@zn.tnic>
 <c8d62037-4a26-e18b-51a3-73fc99e76e5b@schoebel-theuer.de>
 <5ec69dad-7943-343b-5ced-9a962652e14c@schoebel-theuer.de>
 <20181214225428.GL11710@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181214225428.GL11710@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas =?iso-8859-1?Q?Sch=F6bel-Theuer?= <thomas@schoebel-theuer.de>, Thomas Schoebel-Theuer <tst@schoebel-theuer.de>, linux-kernel@vger.kernel.org, Laura Abbott <labbott@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Dec 14, 2018 at 11:54:28PM +0100, Borislav Petkov wrote:
> On Fri, Dec 14, 2018 at 11:42:01PM +0100, Thomas Schöbel-Theuer wrote:
> > Ah, I overlooked that commit e56c92565dfe2 is already providing a different
> > solution to the same problem in newer kernels _only_, as a _side_ effect
> > (not clear to me from the description, but clear from reading the code).
> 
> Damn, I missed the fact that this is not the upstream kernel:
> 
> CPU: 0 PID: 1 UID: 0 Comm: swapper/0 Not tainted 4.4.0-ui18344.004-uiabi1-infong-amd64 #1
> 
> > So another alternative would be backporting e56c92565dfe2 to the 4.4 LTS
> > series. Also fine for me.
> 
> That looks like the right fix.
> 
> A note for the next time: do not send a fix for a stable kernel which is
> not upstream:
> 
> >From Documentation/process/stable-kernel-rules.rst:
> 
> " - It or an equivalent fix must already exist in Linus' tree (upstream)."
> 
> The stable kernels track upstream so if a stable kernel has a problem,
> the first thing one needs to do is to check whether this has been fixed
> upstream and if so, to backport it. This is the case most of the time.
> In the very seldom cases where a separate fix is needed, it needs to be
> handled by asking Greg what to do. :-)
> 
> Adding stable@ folks to CC to set me straight if I'm missing something.

Nope, you are correct, thanks!

greg k-h
