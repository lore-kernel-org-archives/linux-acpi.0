From: Len Brown <len.brown@intel.com>
Subject: Re: [ACPI] [PATCH] disable SMM access to SpeedStep using ACPI-FADT
	pstate_cnt
Date: 16 Feb 2004 00:46:37 -0500
Sender: cpufreq-bounces@www.linux.org.uk
Message-ID: <1076910396.2507.41.camel@dhcppc4>
References: <20040215105712.GB6105@dominikbrodowski.de>
	<20040215145407.GK13262@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
In-Reply-To: <20040215145407.GK13262@poupinou.org>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@www.linux.org.uk>
List-Help: <mailto:cpufreq-request@www.linux.org.uk?subject=help>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=subscribe>
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
To: Bruno Ducrot <ducrot@poupinou.org>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>, cpufreq@www.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

On Sun, 2004-02-15 at 09:54, Bruno Ducrot wrote:
> On Sun, Feb 15, 2004 at 11:57:12AM +0100, Dominik Brodowski wrote:
> > Disable SMM access to SpeedStep

> I would prefer to name it 'take_ownership' or something like that.  I think
> this is the correct naming.

We write PSTATE_CNT to SMI_CMD register to "assume processor p-state
control responsibility".  We're actually just telling SMM that the OS is
taking over p-states.  This might disable SMM involvement, or may just
change how SMM is involved -- we can't know which.  So I guess you're
right, and we end up with something like this:

- acpi_processor_disable_smm
+ acpi_processor_notify_smm

thanks,
-Len
