From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v1 0/2] x86/init: extend quirk use
Date: Fri,  8 Apr 2016 17:22:39 -0700
Message-ID: <1460161361-13635-1-git-send-email-mcgrof@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org, joro@8bytes.org, tiwai@suse.de, sathyanarayanan.kuppuswamy@linux.intel.com, alan@linux.intel.com, rui.zhang@intel.com, mbizon@freebox.fr, bigeasy@linutronix.de, ffainelli@freebox.fr, "Luis R. Rodriguez" <mcgrof@kernel.org>
List-Id: linux-acpi@vger.kernel.org

This extends use of the quirks to other platorms as hinted as possible
and confirmed by hpa [0]. This small series depends on the work that added
this functionality [1] [2] to replace the paravirt_enabled() hacks
which is currently under review, sending this series separately. Its worth
reviewing already.

What seems a bit odd is CE4100 leaves RTC enabled, can someone
confirm if indeed it really needs it, or can it also disable it
as with Xen, lguest, and Intel MID ?

[0] http://lkml.kernel.org/r/5702B5C2.7070101@zytor.com
[1] http://lkml.kernel.org/r/1460158825-13117-1-git-send-email-mcgrof@kernel.org
[2] https://git.kernel.org/cgit/linux/kernel/git/mcgrof/linux-next.git/log/?h=20160408-pv-disabled-v5

Luis R. Rodriguez (2):
  x86/init: disable pnpbios for X86_SUBARCH_INTEL_MID
  x86/init: disable pnpbios for X86_SUBARCH_CE4100

 arch/x86/kernel/platform-quirks.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.7.2
