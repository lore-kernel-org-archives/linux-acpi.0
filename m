From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 10/19] Add Kconfig option ARCH_HAVE_NMI_SAFE_CMPXCHG
Date: Wed, 3 Aug 2011 10:04:25 +0100
Message-ID: <20110803090425.GA29150@linux-mips.org>
References: <ca7cc5110a313a609da40ae948978a585352564b.1312323131.git.len.brown@intel.com>
 <0f579173fd1c9f5dba6703ed8e44a767edf948b5.1312323131.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from h5.dl5rb.org.uk ([81.2.74.5]:57216 "EHLO linux-mips.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751995Ab1HCJNZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Aug 2011 05:13:25 -0400
Content-Disposition: inline
In-Reply-To: <0f579173fd1c9f5dba6703ed8e44a767edf948b5.1312323131.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Huang Ying <ying.huang@intel.com>, Richard Henderson <rth@twiddle.net>, Mikael Starvik <starvik@axis.com>, David Howells <dhowells@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Tony Luck <tony.luck@intel.com>, Hirokazu Takata <takata@linux-m32r.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Kyle McMartin <kyle@mcmartin.ca>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Chen Liqin <liqin.chen@sunplusct.com>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Chris Zankel <chris@zankel.net>, Len Brown <len.brown@intel.com>

On Tue, Aug 02, 2011 at 06:14:43PM -0400, Len Brown wrote:

There is no MIPS-segment contained in this patch but since NMI on MIPS is
sort of a non-topic (it's used for catastrophic malfunction and is similar
to reset) I'm happy with that:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
