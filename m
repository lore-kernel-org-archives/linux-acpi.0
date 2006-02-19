From: Vince <legoll@online.fr>
Subject: Re: Missing PSB or _PSS in BIOS
Date: Sun, 19 Feb 2006 12:37:49 +0100
Message-ID: <43F8588D.8030408@online.fr>
References: <F7DC2337C7631D4386A2DF6E8FB22B30061F41E8@hdsmsx401.amr.corp.intel.com>
Reply-To: legoll@online.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@lists.linux.org.uk>
In-reply-to: <F7DC2337C7631D4386A2DF6E8FB22B30061F41E8@hdsmsx401.amr.corp.intel.com>
List-Unsubscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@lists.linux.org.uk>
List-Help: <mailto:cpufreq-request@lists.linux.org.uk?subject=help>
List-Subscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=subscribe>
Sender: cpufreq-bounces@lists.linux.org.uk
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org+glkc-cpufreq=gmane.org@lists.linux.org.uk
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, cpufreq@lists.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

Brown, Len wrote:
 >> I'm using an opteron 165 (dual-core) which frequency/voltage should
 >> be able to be scaled, but unfortunately the latest BIOS for my
 >> motherboard
 >> lacks the frequency transition tables needed by powernow-k8.c
 >>
 >> as shown by the boot message:
 >> powernow-k8: MP systems not supported by PSB BIOS structure
 >> powernow-k8:  BIOS error - no PSB or ACPI _PSS objects
 >>
 >> Would it be possible to write suitable ACPI _PSS from AMD processor
 >> documentation ?
 >> Or take the infos from some other ACPI BIOS which has support, and put
 >> it in mine ?
 >>
 >> And use the "ACPI load custom DSDT" kernel option to get the
 >> patched one
 >> used by the
 >> powernow-k8 driver ?
 >>
 >> I found a lot of infos about fixing glitches in DSDT but could
 >> not find
 >> anything
 >> about adding missing  _PSS entries...
 >>
 >> Would that be dangerous ?
 >>
 >> Is there something else I could do ?
 >> I don't think I'll get an answer from the vendor, even if I tried...
 >
 > Sure it is possible.

 > It is only dangerous if you care about the data on the machine.
 > Presumably the vendor had a reason not to enable this feature...

I suspected the reason would be 'do not care', but you are making it sound
this is not right for this processor, or something... Care to elaborate 
a bit,
or could you point me at a CPU errata or any other source of information
that will enlighten me as to why enabling this feature would eat my data...

The powernow driver has got patches to enable dual core CPUs, the CPU report
the feature as present (/proc/cpuinfo), so I had the impression this was not
working only because the BIOS is crappy, not because of it being a dangerous
feature...

Sorry if you think I'm silly, but I'm new to ACPI / powernow internals, 
so please,
excuse my ignorance...

-- 
Vincent Legoll
