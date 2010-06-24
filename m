From: Tony Luck <tony.luck@intel.com>
Subject: Re: [bug report ] hp's rx2860 (kernel is 2.6.27.19-5 in sles11 ia64)
	power off failrue when "shutdown -h 0" .
Date: Thu, 24 Jun 2010 15:08:27 -0700
Message-ID: <AANLkTinT8YMKGw3obdbIMINkUGNUgfUQEOEzgHMOPOtt@mail.gmail.com>
References: <201006242333018701088@tom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <201006242333018701088@tom.com>
Sender: linux-ia64-owner@vger.kernel.org
To: bob_zhang2004 <bob_zhang2004@tom.com>
Cc: "len.brown" <len.brown@intel.com>, linux-ia64 <linux-ia64@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

2010/6/24 bob_zhang2004 <bob_zhang2004@tom.com>:
> thanks much for comments, any idea is welcome!

Does this problem also appear in SLES11-SP1 ... which moved to
kernel version 2.6.32, and thus includes some changes to

drivers/acpi/acpica/hwsleep.c

Nothing obviously looks like it would cause this problem,
but it would be nice to know if the problem has already
been fixed.

-Tony
