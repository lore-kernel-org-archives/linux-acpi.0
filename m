From: Thorsten Zachmann <t.zachmann-c61pB8mzqkY@public.gmane.org>
Subject: Re: No network after S3
Date: Tue, 24 Feb 2004 07:41:30 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200402240741.30530.t.zachmann@zagge.de>
References: <BF1FE1855350A0479097B3A0D2A80EE0025A6344@hdsmsx402.hd.intel.com> <1077000806.2515.46.camel@dhcppc4> <200402170856.42059.t.zachmann@zagge.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200402170856.42059.t.zachmann-c61pB8mzqkY@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello Len,

> On Tuesday 17 February 2004 07:53, Len Brown wrote:
> > > Please let me know if there is any information that I can provide to
> > > track the problem down?
> >
> > need /proc/interrupts -- PIC or APIC mode?  network interrupt shared
> > with ACPI, other devices, or dedicated interrupt?
>
> I think I use APIC mode. The interrupts for the network are not shared with
> another device as far as I can tell. /proc/interrupts only show eth0 on
> interrupt 6.
>
> I have attached a file containing the output of /proc/interrupts, dmesg
> and /var/log/boot.msg.
>
> > We'll probably have
> > to dump out the state of the interrupt controller after resume.  for
> > IOAPIC we can do that with print_IO_APIC.  for PIC mode we'll need
> > something else.
>
> just tell me what I have to do. Where do I have to call print_IO_APIC?

I had a look in my kernel config and IO-APIC is enabled. Can you tell me where 
I have to call print_IO_APIC.  

is there any infomation I can send you, or any tests I can make to locate the 
source of the problem. I really like this bug fixed, as this is one of the 
features I need most on my notebook.

Thanks for you  help, have a nice day

Thorsten 


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
