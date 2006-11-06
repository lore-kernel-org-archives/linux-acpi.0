From: Dave Jones <davej@redhat.com>
Subject: Re: [discuss] Linux 2.6.19-rc4: known unfixed regressions (v2)
Date: Mon, 6 Nov 2006 12:49:28 -0500
Message-ID: <20061106174928.GB19283@redhat.com>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
	<454AFD01.4080306@linux.intel.com>
	<20061103155656.GA1000@redhat.com>
	<200611051832.13285.christiand59@web.de>
	<20061105200448.GE859@redhat.com> <20061106173528.GQ5778@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@lists.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20061106173528.GQ5778@stusta.de>
List-Unsubscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@lists.linux.org.uk>
List-Help: <mailto:cpufreq-request@lists.linux.org.uk?subject=help>
List-Subscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=subscribe>
Sender: cpufreq-bounces@lists.linux.org.uk
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org+glkc-cpufreq=gmane.org@lists.linux.org.uk
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-acpi@vger.kernel.org, cpufreq@lists.linux.org.uk, Christian <christiand59@web.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 06, 2006 at 06:35:28PM +0100, Adrian Bunk wrote:
 
 > config X86_POWERNOW_K8
 >         tristate "AMD Opteron/Athlon64 PowerNow!"
 >         select CPU_FREQ_TABLE
 > 	depends (ACPI_PROCESSOR || ACPI_PROCESSOR=n)
 > 
 > But in the end, the best solution depends on how many percent of the 
 > X86_POWERNOW_K8 users have Christian's problem of requiring 
 > ACPI_PROCESSOR. If there are only very few people with this problem, I'd 
 > say leave it as it is.

Well, it's been this way for a while, and only recently this has come up.
There was a similar report for powernow-k7, which has a similar construct.

	Dave

-- 
http://www.codemonkey.org.uk
