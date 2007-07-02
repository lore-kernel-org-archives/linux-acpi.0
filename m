From: Dave Jones <davej@redhat.com>
Subject: Re: [2.6 patch] the overdue removal of X86_SPEEDSTEP_CENTRINO_ACPI
Date: Mon, 2 Jul 2007 19:22:55 -0400
Message-ID: <20070702232255.GH6403@redhat.com>
References: <20070701202037.GC10869@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@lists.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20070701202037.GC10869@stusta.de>
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
Cc: cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Jul 01, 2007 at 10:20:37PM +0200, Adrian Bunk wrote:

Hi Adrian,

 > This patch contains the overdue removal of X86_SPEEDSTEP_CENTRINO_ACPI.
 > 
 > Signed-off-by: Adrian Bunk <bunk@stusta.de>
 > Acked-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
 > Acked-by: Dave Jones <davej@redhat.com>

Can you do this against -mm please ?
There's been some changes, which mean that your patch won't apply
without fuzz, which git-apply hates.

(19:06:04:davej@hera:cpufreq)$ git-applymbox -k ~/cf
1 patch(es) to process.

Applying '[CPUFREQ] the overdue removal of X86_SPEEDSTEP_CENTRINO_ACPI'

error: patch failed: arch/x86_64/kernel/cpufreq/Kconfig:65
error: arch/x86_64/kernel/cpufreq/Kconfig: patch does not apply


Thanks,

	Dave

-- 
http://www.codemonkey.org.uk
