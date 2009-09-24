From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: Re: [v6 PATCH 0/7]: cpuidle/x86/POWER: Cleanup idle power
	management code in x86, cleanup drivers/cpuidle/cpuidle.c and
	introduce cpuidle to POWER.
Date: Thu, 24 Sep 2009 10:42:41 +0530
Message-ID: <20090924051238.GA5963@linux.vnet.ibm.com>
References: <20090922112526.GA7788@linux.vnet.ibm.com>
Reply-To: arun@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20090922112526.GA7788@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
To: Len Brown <lenb@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Joel Schopp <jschopp@austin.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@s>
Cc: linux-acpi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

* Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-09-22 16:55:27]:

Hi Len, (or other acpi folks),

I had a question regarding ACPI-cpuidle interaction in the current
implementation.

Currently, every cpu (i.e. acpi_processor) registers to cpuidle as
a cpuidle_device. So every cpu has to go through the process of
setting up the idle states and then registering as a cpuidle device.

What exactly is the reason behind this?

Is this really necessary or can we have a system-wide one-time registering
to cpuidle by ACPI?

I'm currently in the process of enabling cpuidle for POWER systems and
find that having a system-wide registering mechanism to be a cleaner
design.

--arun
