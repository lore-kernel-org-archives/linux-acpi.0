From: "Paulo J. Matos" <pocm@soton.ac.uk>
Subject: Re: Thermal Zones and Throttling
Date: Wed, 18 Apr 2007 21:43:36 +0100
Message-ID: <11b141710704181343s515b2532j4b465541cc1fb011@mail.gmail.com>
References: <11b141710704121410j16011387q4640f07f1e27a85f@mail.gmail.com>
	 <200704172303.46321.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.239]:50805 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992557AbXDRUnh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Apr 2007 16:43:37 -0400
Received: by wx-out-0506.google.com with SMTP id h31so326435wxd
        for <linux-acpi@vger.kernel.org>; Wed, 18 Apr 2007 13:43:36 -0700 (PDT)
In-Reply-To: <200704172303.46321.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On 4/18/07, Len Brown <lenb@kernel.org> wrote:
>
> Cat /proc/cpuinfo will tell if the hardware has automatic throttling
> for thermal emergencies.
>

Which flag tells me that?
$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Mobile Intel(R) Pentium(R) 4 - M CPU 2.20GHz
stepping        : 7
cpu MHz         : 2200.000
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe up cid
bogomips        : 4389.84
clflush size    : 64

> However, the real question is why you're having a thermal emergency
> in the first place.  Is there dust blocking the fan?
>

Well, it's probably a very badly ventilated, 2.2Ghz Pentium4 M in a laptop! :-(
I've already ordered some notebook coolers!

> -Len
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Paulo Jorge Matos - pocm at soton.ac.uk
http://www.personal.soton.ac.uk/pocm
PhD Student @ ECS
University of Southampton, UK
