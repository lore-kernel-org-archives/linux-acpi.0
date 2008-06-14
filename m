From: Ingo Molnar <mingo@elte.hu>
Subject: Re: linux-next Regression: Unable to locate IOAPIC
Date: Sat, 14 Jun 2008 10:31:59 +0200
Message-ID: <20080614083159.GA29894@elte.hu>
References: <200806051100.12885.dex@dragonslave.de> <200806102229.10512.dex@dragonslave.de> <4851AA24.7060906@gmail.com> <200806131307.39807.dex@dragonslave.de> <48536E3B.4000703@gmail.com> <86802c440806140126l7a949783of0fb08d11ae07bef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <86802c440806140126l7a949783of0fb08d11ae07bef@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, webmaster@dragonslave.de, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


* Yinghai Lu <yhlu.kernel@gmail.com> wrote:

> can you check if the attached patch fix the problem?
> it will not check entries before MP_intsrc_info...

applied to tip/x86/mpparse for more testing.

	Ingo
