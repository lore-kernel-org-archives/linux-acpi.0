From: =?ISO-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
Subject: Re: speedstep-centrino: ENODEV
Date: Fri, 20 Oct 2006 14:30:14 +0200
Message-ID: <4538C156.3060502@molgaard.org>
References: <EB12A50964762B4D8111D55B764A8454C1A976@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964796AbWJTMa2@vger.kernel.org>
In-Reply-To: <EB12A50964762B4D8111D55B764A8454C1A976@scsmsx413.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Pallipadi, Venkatesh wrote:
>  
> 
> Puzzling.. 
> Just to make sure, do you have CPU_FREQ_DEBUG enabled in your config and boot parameter? There are a bunch of dprintk debug messages in speedstep_centrino that should get printed in this case..
> Do you have est flag displayed in your /proc/cpuinfo under flags?
> 

Well, how about that. No est :-$ I assume ss is regular speedstep? So 
what do I use instead? Is there some way to get acpi-speedstep working 
again?

Best regards,

/sunem

sune@tommelise:~$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Celeron(R) M processor         1.40GHz
stepping        : 8
cpu MHz         : 1396.494
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe nx up
bogomips        : 2795.99
