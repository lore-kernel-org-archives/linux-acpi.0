From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH v5 1/2] TTY: Add TTY slave enumeration support
Date: Sat, 26 Jan 2013 00:32:16 +0000
Message-ID: <20130126003216.1f16a705@bob.linux.org.uk>
References: <cover.1354505471.git.lv.zheng@intel.com>
	<cover.1359022955.git.lv.zheng@intel.com>
	<12848b50e1096dc11a193694ee248d51d45ce093.1359022955.git.lv.zheng@intel.com>
	<20130125214121.GA30924@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20130125214121.GA30924@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lv Zheng <lv.zheng@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

> Or am I missing something big and major here?  How have people been
> seeing and configuring their tty devices for the last 8+ years or so
> since the 2.6.0 kernel was released with uevent support for tty
> devices?

Minor more than major. The newer ACPI tries to begin to describe what
is on the other end of serial busses being used for internal purposes.

Now there are several good reasons we want to know what is on the end
of a port already that are not currently handled, and I have suggested
a port "type" attribute would be useful (eg  unknown, modem, bluetooth,
ax25, dcc, etc) so the kernel can help user space enumerate in user
friendly fashion.

Where it gets slightly more tricky is that we are beginning to see
systems where the firmware is describing

	serial port (and power management)
	device behind port (and power management)

so there is a power management hierarchy involved.

But yes - these patches should have been labelled 'RFC' - the concept
needs discussion in public not the current code drafts.

Alan
