From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH] ACPI: allow compilation with bare metal compilers
Date: Tue, 15 Nov 2016 09:36:05 -0700
Message-ID: <ac74e311-8482-9336-83c7-0eb5e84d81a5@redhat.com>
References: <1479164926-1733-1-git-send-email-ahs3@redhat.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E51C7A4@ORSMSX110.amr.corp.intel.com>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E51C7A4@ORSMSX110.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>
List-Id: linux-acpi@vger.kernel.org

On 11/15/2016 08:43 AM, Moore, Robert wrote:
> The design for all of this is as follows:
> 
> 1) OS-dependent includes
> 2) Compiler-specific includes
> 3) acenv.h is the master file that pulls in the correct headers (one compiler, and one OS)

Sure, that's understood from the current structure.  The issue is #3 -- there
is no OS, in the sense of a run-time environment, so that assumption is
incorrect in this case.  All we know is that we're compiling the kernel and it
needs to be able to run in complete isolation.

> So, I think I see a couple of possible solutions for you:
> 
> 1) If you are using GCC, the __GNUC__ symbol should already be defined.

Right, which is what this patch is relying on.

> 2) If "aclinux.h" works for you, we can either add a conditional case that would apply to your environment, or:

I'm confused; I thought that was what this patch was doing.  What is
being suggested instead?

> 2a) You could define _LINUX in your gcc invocations.

This option might force changes in the kernel build which is otherwise not
affected; this is only an issue with drivers/acpi/acpica/*.  It may also
cause ACPICA to build incorrectly for other OSs, but I'll have to look at
that.  Off hand, it seems like this would cause more problems with acenv.h.

> 
> Because ACPICA supports many different environments, we don't want to have a "default" case which in a sense would only be an attempt to guess what the user intended. We want to have a clear error that tells the user that something important needs to be done before the code can be compiled.

Understood, which is why I left the #error case; the intent is only to have
a default when compiling Linux for bare-metal environments using GCC.  Perhaps
this is just a Linux-only modification...

> Bob
> 
> 
>> -----Original Message-----
>> From: Al Stone [mailto:ahs3@redhat.com]
>> Sent: Monday, November 14, 2016 3:09 PM
>> To: linux-acpi@vger.kernel.org; devel@acpica.org; linux-
>> kernel@vger.kernel.org
>> Cc: Al Stone <ahs3@redhat.com>; Rafael J . Wysocki <rjw@rjwysocki.net>;
>> Len Brown <lenb@kernel.org>; Moore, Robert <robert.moore@intel.com>;
>> Zheng, Lv <lv.zheng@intel.com>
>> Subject: [PATCH] ACPI: allow compilation with bare metal compilers
>>
>> The ACPICA subsystem of the ACPI driver sets up a compilation
>> environment for itself, adding in multiple typedefs unique to ACPICA
>> that depend on where ACPICA will be used.
>>
>> The vast majority of such environments (Linux, QNX, ...) have an
>> environment defined by the acenv.h header file.  When using a Linaro
>> compiler [1] specifically built to be used in an embedded environment
>> with perhaps a kernel and an init process as the only things running,
>> there is no environment defined for ACPICA so the typedefs it needs are
>> not set up, causing compilation to fail badly unless ACPI is completely
>> disabled.
>> Since ACPI is enabled in the default config for the kernel, the
>> compilation failure is fairly obvious.
>>
>> This may not be the optimal solution, but add in to the ACPI header file
>> include/acpi/platform/acenv.h a default so that if GCC is being used,
>> and all else fails, assume that we are going to be in a Linux-like
>> environment and re-use the environment definition for Linux.  This
>> allows us to build a kernel using this compiler [1] with or without
>> ACPI.
>>
>> [1]
>> https://releases.linaro.org/components/toolchain/binaries/latest/aarch64
>> -elff/gcc-linaro-6.1.1-2016-08-x86_64_aarch64-elf.tar.xz
>>
>> Signed-off-by: Al Stone <ahs3@redhat.com>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: Robert Moore <robert.moore@intel.com>
>> Cc: Lv Zheng <lv.zheng@intel.com>
>> ---
>>  include/acpi/platform/acenv.h | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/include/acpi/platform/acenv.h
>> b/include/acpi/platform/acenv.h index 34cce72..cdd1cd6 100644
>> --- a/include/acpi/platform/acenv.h
>> +++ b/include/acpi/platform/acenv.h
>> @@ -234,6 +234,21 @@
>>  #elif defined(_AED_EFI) || defined(_GNU_EFI) || defined(_EDK2_EFI)
>> #include "acefi.h"
>>
>> +/*
>> + * Up to this point, we've been looking for specific environments.  In
>> + * some cases, there is no environment, and we're just working on bare
>> + * metal.  However, since we're compiling the Linux kernel, let's just
>> + * pretend we're in a Linux environment.
>> + */
>> +#elif defined(__GNUC__) && !defined(__INTEL_COMPILER) #if
>> +!defined(_LINUX) #define _LINUX #endif #if !defined(__linux__) #define
>> +__linux__ #endif #include <acpi/platform/aclinux.h>
>> +
>>  #else
>>
>>  /* Unknown environment */
>> --
>> 2.10.2
> 


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
