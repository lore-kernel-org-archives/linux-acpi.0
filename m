From: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Date: Thu, 2 Mar 2006 14:31:29 -0500
Message-ID: <20060302193129.GA12498@redhat.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B30063F9031@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752047AbWCBTdf@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30063F9031@hdsmsx401.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Andi Kleen <ak@suse.de>
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 02, 2006 at 02:26:24PM -0500, Brown, Len wrote:
 > Dave,
 > Your DSDT looks fine.
 > I was wrong assuming there were 3 Processor entries there.
 > 
 > > > Did you really build a 256-CPU SMP kernel or is ACPI 
 > > > ignoring CONFIG_NR_CPUS or something?
 > >
 > >Yes, it's =256.
 > 
 > I expect this is the root problem.

If this is the _cause_, something needs fixing, but it's hardly
something we can brush off as 'the root problem'.

It's entirely possible for such a configuration (higher
CONFIG_NR_CPUS than actual cpus), cf. distro kernels.

		Dave
