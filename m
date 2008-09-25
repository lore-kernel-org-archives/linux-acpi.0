From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 7/7] x86: print out irq nr for msi/ht -v2
Date: Thu, 25 Sep 2008 11:12:11 +0200
Message-ID: <20080925091211.GA4922@elte.hu>
References: <1222323223-23529-1-git-send-email-yhlu.kernel@gmail.com> <20080925084212.GE4519@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080925084212.GE4519@elte.hu>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


> > v2: fix hpet compiling

still bad:

arch/x86/kernel/hpet.c: In function =E2=80=98hpet_late_init=E2=80=99:
arch/x86/kernel/hpet.c:828: error: =E2=80=98dev=E2=80=99 undeclared (fi=
rst use in this function)
arch/x86/kernel/hpet.c:828: error: (Each undeclared identifier is repor=
ted only once
arch/x86/kernel/hpet.c:828: error: for each function it appears in.)

we've got some changes in this area (per cpu hpet).

	Ingo
