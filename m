From: Bruno Ducrot <ducrot@poupinou.org>
Subject: Re: [ACPI] [PATCH] disable SMM access to SpeedStep using ACPI-FADT
	pstate_cnt
Date: Sun, 15 Feb 2004 15:54:07 +0100
Sender: cpufreq-bounces@www.linux.org.uk
Message-ID: <20040215145407.GK13262@poupinou.org>
References: <20040215105712.GB6105@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20040215105712.GB6105@dominikbrodowski.de>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@www.linux.org.uk>
List-Help: <mailto:cpufreq-request@www.linux.org.uk?subject=help>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=subscribe>
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
To: len.brown@intel.com, acpi-devel@lists.sourceforge.net, cpufreq@www.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

On Sun, Feb 15, 2004 at 11:57:12AM +0100, Dominik Brodowski wrote:
> Disable SMM access to SpeedStep
> 
> Often, the BIOS changes the CPU frequency if a notebook is (dis)connected
> from its AC adapter. This interferes with a) an user setting the CPU frequency
> and b) kernel timing code which needs to know loops_per_jiffy, cpu_khz etc.
> 
> So, ACPI 2.0 offers a method to disable such BIOS changes -- writing
> a value contained in the FADT (pstate_cnt) to the smi_cmd port. This patch
> utilizes this method by doing this write in processor.c.
> 
> However, most current notebooks only offer 1.0 ACPI tables, where the
> pstate_cnt entry is marked as "reserved". Whenever there is a _PCT entry
> in the DSDT, though [and this is only a 2.0 object!], we assume the
> "reserved" entry to be the pstate_cnt entry [if it isn't zero].

I would prefer to name it 'take_ownership' or something like that.  I think
this is the correct naming.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
