From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v1 0/2] x86/init: extend quirk use
Date: Mon, 11 Apr 2016 09:31:54 +0200
Message-ID: <570B52EA.60300@linutronix.de>
References: <1460161361-13635-1-git-send-email-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57791 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbcDKHcd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Apr 2016 03:32:33 -0400
In-Reply-To: <1460161361-13635-1-git-send-email-mcgrof@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org, joro@8bytes.org, tiwai@suse.de, sathyanarayanan.kuppuswamy@linux.intel.com, alan@linux.intel.com, rui.zhang@intel.com, mbizon@freebox.fr, ffainelli@freebox.fr

On 04/09/2016 02:22 AM, Luis R. Rodriguez wrote:
> What seems a bit odd is CE4100 leaves RTC enabled, can someone
> confirm if indeed it really needs it, or can it also disable it
> as with Xen, lguest, and Intel MID ?

So what you do with "x86_platform.legacy.rtc" is to skip
add_rtc_cmos(). For ce4100 I added of_have_populated_dt() to skip the
probe.
If you plan to add this to CE4100 you could remove the
"of_have_populated_dt()". It was meant to skip the RTC probe on all OF
platforms but as of now, CE4100 is the only.

Sebastian
