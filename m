From: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Subject: Re: Centrino speedstep
Date: Thu, 30 Dec 2004 11:51:57 +0100
Message-ID: <m2oegcdpo2.fsf@phoenix.squirrel.nl>
References: <m2zmzyw4e7.fsf@phoenix.squirrel.nl>
	<20041228212653.GA8436@dominikbrodowski.de>
	<m2vfalc53k.fsf@phoenix.squirrel.nl> <41D30842.4040204@paranoici.org>
	<20041229205905.GA12181@dominikbrodowski.de>
	<m2sm5o23ix.fsf@phoenix.squirrel.nl>
	<20041229214629.GA21054@dominikbrodowski.de>
	<m24qi48z4q.fsf@phoenix.squirrel.nl>
	<20041230074241.GB8464@dominikbrodowski.de>
	<m2is6kuo63.fsf@phoenix.squirrel.nl>
	<20041230103003.GA8206@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041230103003.GA8206-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org> (Dominik
 Brodowski's message of "Thu, 30 Dec 2004 11:30:03 +0100")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org> writes:

> Run "x86info --mhz" and you'll most probably see the CPU runs at 1.5GHz 
> even though it is reported by ACPI as 1.6GHz. 

Hmm. x86info doesn't seem to produce reliable figures:

  # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
  600000
  # x86info --mhz
  x86info v1.12b.  Dave Jones 2001-2003
  Feedback to <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>.

  Found 1 CPU
  --------------------------------------------------------------------------
  unknown TLB/cache descriptor:   0xf0
  unknown TLB/cache descriptor:   0x7d
  Family: 6 Model: 13 Stepping: 6 Type: 0 Brand: 6
  CPU Model: Unknown CPU Original OEM
  Instruction TLB: 4K pages, 4-way associative, 128 entries.
  Data TLB: 4K pages, 4-way associative, 128 entries.
  Instruction TLB: 4MB pages, fully associative, 2 entries
  unknown TLB/cache descriptor:   0xf0
  unknown TLB/cache descriptor:   0x7d
  L1 Instruction cache:
          :Size 32KB      8-way associative.
          line size=64 bytes.
  Data TLB: 4MB pages, 4-way associative, 8 entries
  L1 Data cache:
          Size: 32KB      8-way associative.
          line size=64 bytes.
  100MHz processor (estimate).

  # cat /proc/cpuinfo
  processor       : 0
  vendor_id       : GenuineIntel
  cpu family      : 6
  model           : 13
  model name      : Intel(R) Pentium(R) M processor 1.50GHz
  stepping        : 6
  cpu MHz         : 599.502
  cache size      : 2048 KB
  fdiv_bug        : no
  hlt_bug         : no
  f00f_bug        : no
  coma_bug        : no
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 2
  wp              : yes
  flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe est tm2
  bogomips        : 1189.47

-- Johan


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
