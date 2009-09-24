From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [v6 PATCH 0/7]: cpuidle/x86/POWER: Cleanup idle power
	management code in x86, cleanup drivers/cpuidle/cpuidle.c and introduce
	cpuidle to POWER.
Date: Thu, 24 Sep 2009 14:22:28 +0200
Message-ID: <20090924142228.5a2ddf59@infradead.org>
References: <20090922112526.GA7788@linux.vnet.ibm.com>
	<20090924051238.GA5963@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20090924051238.GA5963@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
To: arun@linux.vnet.ibm.com
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Gautham R Shenoy <ego@in.ibm.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Shaohua Li <shaohua.li@intel.com>, Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 24 Sep 2009 10:42:41 +0530
Arun R Bharadwaj <arun@linux.vnet.ibm.com> wrote:

> * Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-09-22 16:55:27]:
> 
> Hi Len, (or other acpi folks),
> 
> I had a question regarding ACPI-cpuidle interaction in the current
> implementation.
> 
> Currently, every cpu (i.e. acpi_processor) registers to cpuidle as
> a cpuidle_device. So every cpu has to go through the process of
> setting up the idle states and then registering as a cpuidle device.
> 
> What exactly is the reason behind this?
> 

technically a BIOS can opt to give you C states via ACPI on some cpus,
but not on others.

in practice when this happens it tends to be a bug.. but it's
technically a valid configuration



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
