From: Len Brown <lenb@kernel.org>
Subject: Re: [RESEND PATCH v4 0/2] ACPI: DBGP/DBG2 early console support for
 LPIA.
Date: Sat, 06 Oct 2012 14:42:56 -0400
Message-ID: <50707BB0.8050301@kernel.org>
References: <cover.1347453194.git.zetalog@gmail.com> <cover.1348652044.git.lv.zheng@intel.com> <5065457E.4040500@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <5065457E.4040500@zytor.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Jason Wessel <jason.wessel@windriver.com>, Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


> You want to take this, or should I?

go ahead and take the series in tip 3.8, Peter, thanks.

I looked over this series a while back and my feedback was that
it should be disabled by default and enabled by bootparam --
like other earlyprink -- else an issue here would render
a system un-bootable.  I see that LV has addressed that
in the latest version.

LV,
have you addressed the feedback from Konrad?

thanks,
-Len
