From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [discuss] Linux 2.6.19-rc4: known unfixed regressions (v2)
Date: Mon, 6 Nov 2006 18:35:28 +0100
Message-ID: <20061106173528.GQ5778@stusta.de>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
	<454AFD01.4080306@linux.intel.com>
	<20061103155656.GA1000@redhat.com>
	<200611051832.13285.christiand59@web.de>
	<20061105200448.GE859@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces+glkc-cpufreq=m.gmane.org@lists.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20061105200448.GE859@redhat.com>
List-Unsubscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@lists.linux.org.uk>
List-Help: <mailto:cpufreq-request@lists.linux.org.uk?subject=help>
List-Subscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=subscribe>
Sender: cpufreq-bounces@lists.linux.org.uk
Errors-To: cpufreq-bounces+glkc-cpufreq=m.gmane.org+glkc-cpufreq=m.gmane.org@lists.linux.org.uk
To: Dave Jones <davej@redhat.com>, Christian <christiand59@web.de>, Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, cpufreq@lists.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

On Sun, Nov 05, 2006 at 03:04:48PM -0500, Dave Jones wrote:
> On Sun, Nov 05, 2006 at 06:32:12PM +0100, Christian wrote:
>  > Am Freitag, 3. November 2006 16:56 schrieb Dave Jones:
>  > > On Fri, Nov 03, 2006 at 11:25:37AM +0300, Alexey Starikovskiy wrote:
>  > >  > Could this be a problem?
>  > >  > --------------------
>  > >  > ...
>  > >  > CONFIG_ACPI_PROCESSOR=m
>  > >  > ...
>  > >  > CONFIG_X86_POWERNOW_K8=y
>  > >
>  > > Hmm, possibly.  Christian, does it work again if you set them both to =y ?
>  > 
>  > Yes, it works now! Only the change to CONFIG_ACPI_PROCESSOR=y made it work 
>  > again!
> 
> So, the reasoning behind this, is that we have this construct..
> 
> config X86_POWERNOW_K8_ACPI
>     bool
>     depends on X86_POWERNOW_K8 && ACPI_PROCESSOR
>     depends on !(X86_POWERNOW_K8 = y && ACPI_PROCESSOR = m)
>     default y
> 
> 
> Which makes us use the ACPI stuff if it's there, otherwise not,
> and in your case, it seems your system _needs_ this enabled
> to make powernow work.
> 
> Thing is, this was there in 2.6.18 too, so strictly speaking,
> we haven't regressed here, and you're getting exactly what you asked for.
> The problem is that it's completely silent as to why it then fails.
> 
> I'm open to improvements, but I'm not sure what the right thing to do
> here is.. opinions ?

The extreme solution would be

config X86_POWERNOW_K8
        tristate "AMD Opteron/Athlon64 PowerNow!"
        select CPU_FREQ_TABLE
        depends ACPI_PROCESSOR

A medium solution might be

config X86_POWERNOW_K8
        tristate "AMD Opteron/Athlon64 PowerNow!"
        select CPU_FREQ_TABLE
	depends (ACPI_PROCESSOR || ACPI_PROCESSOR=n)

But in the end, the best solution depends on how many percent of the 
X86_POWERNOW_K8 users have Christian's problem of requiring 
ACPI_PROCESSOR. If there are only very few people with this problem, I'd 
say leave it as it is.

> 	Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
