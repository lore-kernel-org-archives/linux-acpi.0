From: Ashok Raj <ashok.raj@intel.com>
Subject: Re: [ACPI] Re: [RFC 5/6]clean cpu state after hotremove CPU
Date: Mon, 4 Apr 2005 15:56:48 -0700
Message-ID: <20050404155647.A8944@unix-os.sc.intel.com>
References: <20050404224620.GD3611@otto>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261484AbVDDXEz@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050404224620.GD3611@otto>; from ntl@pobox.com on Mon, Apr 04, 2005 at 03:46:20PM -0700
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Lynch <ntl@pobox.com>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, "Li, Shaohua" <shaohua.li@intel.com>, lkml <linux-kernel@vger.kernel.org>, ACPI List <acpi-devel@lists.sourceforge.net>, Zwane Mwaikambo <zwane@linuxpower.ca>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>
List-Id: linux-acpi@vger.kernel.org

On Mon, Apr 04, 2005 at 03:46:20PM -0700, Nathan Lynch wrote:
> 
>    Hi Nigel!
> 
>    On Tue, Apr 05, 2005 at 08:14:25AM +1000, Nigel Cunningham wrote:
>    >
>    > On Tue, 2005-04-05 at 01:33, Nathan Lynch wrote:
>    >  >  > Yes, exactly. Someone who understand do_exit please help clean
> 
>    No, that wouldn't work.  I am saying that there's little to gain by
>    adding all this complexity for destroying the idle tasks when it's
>    fairly simple to create num_possible_cpus() - 1 idle tasks* to
>    accommodate any additional cpus which may come along.  This is what
>    ppc64 does now, and it should be feasible on any architecture which
>    supports cpu hotplug.
> 
>    Nathan
> 
>    * num_possible_cpus() - 1 because the idle task for the boot cpu is
>      created in sched_init.
> 

In ia64 we create idle threads on demand if one is not available for the same
logical cpu number, and re-used when the same logical cpu number is re-used. 

just a minor improvement, i also thought about idle exit, but wasnt worth
anything in return.

Cheers,
ashok
