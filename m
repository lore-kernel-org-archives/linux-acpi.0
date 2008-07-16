From: Paolo Ornati <ornati@fastwebnet.it>
Subject: Re: BIOS-controlled FN keys works only with "acpi={off | ht}" on
 Samsung P500
Date: Wed, 16 Jul 2008 21:28:03 +0200
Message-ID: <20080716212803.20c061a9@paolo-laptop>
References: <20080714213755.7e892550@paolo-laptop>
	<1216082997.1617.87.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759133AbYGPT2U@vger.kernel.org>
In-Reply-To: <1216082997.1617.87.camel@rzhang-dt>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 15 Jul 2008 08:49:57 +0800
Zhang Rui <rui.zhang@intel.com> wrote:

> > on this laptop, Samsung NP-P500Y, some function keys are
> > BIOS-controlled (they work before Linux boots).
> > 
> > As soon as Linux boots they stop working. Trying some boot options
> > I've found that "acpi=off" makes them work and the less drastic
> > "acpi=ht" works too.
> > 
> > I'm mostly interested in brightness adjusting... and since both
> > xbacklight and radeontool fail I've to use "acpi=ht".
> 
> Please file a bug report at
> http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
> and attach the dmesg, acpidump output.
> 
> Please run "grep . /sys/firmware/acpi/interrupts/*" both before and
> after pressing the brightness hotkey and attach the test result as
> well.

done:
http://bugzilla.kernel.org/show_bug.cgi?id=11102


Thanks,
Paolo
