From: Andrew Morton <akpm@osdl.org>
Subject: Re: Fw: [Bugme-new] [Bug 5435] New: Powernow code has random CPU
 speed
Date: Thu, 13 Oct 2005 22:17:58 -0700
Message-ID: <20051013221758.0c3fe750.akpm@osdl.org>
References: <20051013214205.200583c1.akpm@osdl.org>
	<20051014050544.GA5074@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-bounces+glkc-cpufreq=m.gmane.org@lists.linux.org.uk>
In-Reply-To: <20051014050544.GA5074@redhat.com>
List-Unsubscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@lists.linux.org.uk>
List-Help: <mailto:cpufreq-request@lists.linux.org.uk?subject=help>
List-Subscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=subscribe>
Sender: cpufreq-bounces@lists.linux.org.uk
Errors-To: cpufreq-bounces+glkc-cpufreq=m.gmane.org+glkc-cpufreq=m.gmane.org@lists.linux.org.uk
To: Dave Jones <davej@redhat.com>
Cc: acpi-devel@lists.sourceforge.net, cpufreq@www.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> On Thu, Oct 13, 2005 at 09:42:05PM -0700, Andrew Morton wrote:
> 
>  > powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
>  > Detected 7352.734 MHz processor.
>  > powernow: No PST tables match this cpuid (0x771)
>  > powernow: This is indicative of a broken BIOS.
>  > powernow: Trying ACPI perflib
>  > powernow: Minimum speed 3342 MHz. Maximum speed 7352 MHz.
> 
> My gut feeling is that this is an ACPI regression, as the powernow-k7
> driver hasn't changed dramatically recently, and in this dmesg,
> we've fallen back to using the ACPI.
> 
> Something else that's really odd is that the 'Detected' line seems
> to have found a 7GHz CPU, which is novel.
> 

OK, thanks.

Could one of the ACPI guys please take a look at 5435 and grab it if
appropriate?
