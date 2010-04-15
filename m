From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [BUG] 2.6.34-rc4: acpi boot-time oops on FSC Amilo Pa 3553
Date: Thu, 15 Apr 2010 22:11:25 +0200
Message-ID: <19399.29421.508520.647456@pilspetsen.it.uu.se>
References: <19399.23074.26023.534765@pilspetsen.it.uu.se>
	<4BC76645.50401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4BC76645.50401@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Justin P. mattock" <justinmattock@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Justin P. mattock writes:
 > On 04/15/2010 11:25 AM, Mikael Pettersson wrote:
 > > Kernels up to and including 2.6.34-rc3 boot fine on my Amilo Pa 3553,
 > > but 2.6.34-rc4 always oopses during boot in acpi.  Without a serial port
 > > I cannot capture the entire oops, but it goes something like this:
 > >
 > > __driver_attach
 > > bus_for_each_dev
 > > driver_attach
 > > __driver_attach
 > > bus_add_driver
 > > acpi_device_remove
 > > driver_register
 > > async_thread
 > > proc_mkdir_mode
 > > async_thread
 > > acpi_battery_init_async
 > > async_thread
 > > schedule
 > > default_wake_function
 > > async_thread
 > > kthread
 > > kthread
 > > kernel_thread_helper
 > > EIP: acpi_ex_read_data_from_field+0x16e
 > >
 > > Any suggestions for revisions to try to revert?
 > > --
 > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
 > > the body of a message to majordomo@vger.kernel.org
 > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > > Please read the FAQ at  http://www.tux.org/lkml/
 > >
 > 
 > 
 > sounds similar to this:
 > https://bugzilla.kernel.org/show_bug.cgi?id=%2015749
 > if so try the patch there and see if
 > you can boot.

Yes, that patch (https://bugzilla.kernel.org/attachment.cgi?id=25962)
fixed the problem.  Thanks.

/Mikael
