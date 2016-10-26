From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 5/9] x86/sysctl: Add sysctl for ITMT scheduling
 feature
Date: Wed, 26 Oct 2016 12:52:41 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610261251550.4983@nanos>
References: <cover.1477000078.git.tim.c.chen@linux.intel.com> <b3f648c2c4cd36b6a043239bee8437a2060c0ac4.1477000078.git.tim.c.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <b3f648c2c4cd36b6a043239bee8437a2060c0ac4.1477000078.git.tim.c.chen@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: rjw@rjwysocki.net, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, 20 Oct 2016, Tim Chen wrote:
>  
> +	if (itmt_sysctl_header)
> +		unregister_sysctl_table(itmt_sysctl_header);

What sets itmt_sysctl_header to NULL?

Thanks,

	tglx
