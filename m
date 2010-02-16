From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: Re: [PATCH v2] acpi: Fix regression where _PPC is not read at boot
	even when ignore_ppc=0
Date: Tue, 16 Feb 2010 14:26:11 -0800
Message-ID: <20100216222611.GP29569@tux1.beaverton.ibm.com>
References: <20090429220037.GA8604@srcf.ucam.org> <20090430072556.GD16737@elte.hu> <20090430095414.GA19462@srcf.ucam.org> <20090430111042.GA12809@elte.hu> <20090430111338.GA21297@srcf.ucam.org> <20090515191219.GH6968@plum> <20090602232108.GG7917@plum> <20090607100541.GJ31286@elte.hu> <20090715003207.GA5111@plum> <20100216220707.GA5966@srcf.ucam.org>
Reply-To: djwong@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100216220707.GA5966@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, lenb@kernel.org, davej@redhat.com, Thomas Renninger <trenn@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 16, 2010 at 10:07:07PM +0000, Matthew Garrett wrote:
> Did this ever get picked up?

Nope.  I vaguely recall asking a few times if there were any objections left,
but there weren't any, and I think Len or someone said it looked good back at
LPC last summer.  Does not appear in 2.6.33-rc8 though.

--D
