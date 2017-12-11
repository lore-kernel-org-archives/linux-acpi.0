From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph@boehmwalder.at>
Subject: Re: [PATCH 1/3 v5] battery: Add the battery hooking API
Date: Mon, 11 Dec 2017 18:52:58 +0100
Message-ID: <20171211175258.eewj7rmtqmk6hznf@localhost>
References: <20171210180131.GA1865@thinkpad>
 <20171211120346.ast5ijqcxslfpbee@christoph-lap>
 <20171211163945.GA23317@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171211163945.GA23317@thinkpad>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Ognjen Galic <smclt30p@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Mon, Dec 11, 2017 at 05:39:45PM +0100, Ognjen Galic wrote:
> The 80-char warning can be omitted if the line looks ugly when broken.
> This is noted in the style guide.
Indeed, you're right here.  The line is just barely over 80 characters
anyway, so it really doesn't matter here.

> About the MAINTAINERS file, I don't know how, when or why to edit that 
> file so I did not touch it.
That was just a warning about you moving drivers/acpi/battery.h to
include/acpi/battery.h, which could potentially lead to an edit to
MAINTAINERS being neccessary.  I just double-checked this and the
include/acpi/ path was already listed in the MAINTAINERS file, so you're
good.
