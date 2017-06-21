From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 5/7] platform/x86: fujitsu-laptop: do not update ACPI
 device power status
Date: Wed, 21 Jun 2017 13:17:27 -0700
Message-ID: <20170621201727.GC25900@fury>
References: <20170616044058.30443-1-kernel@kempniu.pl>
 <20170616044058.30443-6-kernel@kempniu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170616044058.30443-6-kernel@kempniu.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: Jonathan Woithe <jwoithe@just42.net>, Andy Shevchenko <andy@infradead.org>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 16, 2017 at 06:40:56AM +0200, Michał Kępień wrote:
> Calling acpi_bus_update_power() for ACPI devices FUJ02B1 and FUJ02E3 is
> pointless as they are not power manageable (neither _PS0 nor _PR0 is
> defined for any of them), which causes their power state to be inherited
> from their parent devices.  Given the ACPI paths of these two devices
> (\_SB.PCI0.LPCB.FJEX, \_SB.FEXT), their parent devices are also not
> power manageable.  These parent devices will thus have their power state
> initialized to ACPI_STATE_D0, which in turn causes the power state for
> both FUJ02B1 and FUJ02E3 to always be ACPI_STATE_D0 ("on").
> 

How confident are we that all implementations of these two ACPI devices lack
_PS0 and _PR0 ?

-- 
Darren Hart
VMware Open Source Technology Center
