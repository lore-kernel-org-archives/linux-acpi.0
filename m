From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: [2.6.2-rc1] sleep called from invalid context (8250/ACPI
 related?)
Date: Wed, 21 Jan 2004 13:36:52 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040121133652.04e02a13.akpm@osdl.org>
References: <Pine.LNX.4.58.0401211139001.13077@joel.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0401211139001.13077-8boff9MBBEKJoy8PIJZ9VA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rui Saraiva <rmps-8boff9MBBEKJoy8PIJZ9VA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Rui Saraiva <rmps-8boff9MBBEKJoy8PIJZ9VA@public.gmane.org> wrote:
>
> --------------------------------------------------------------------------------|
> 	Hello,
> 
> 	I've found this message in my logs while investigating some kernel Oops
> (in other message). If you need more info, please ask.
> 
> 	Regards,
> 		Rui Saraiva
> 
> 
> Debug: sleeping function called from invalid context at include/asm/semaphore.h:119
> in_atomic():1, irqs_disabled():0
> Call Trace:
>  [<c0122ddb>] __might_sleep+0xab/0xd0
>  [<d1bd2df6>] uart_unregister_port+0x76/0xa9 [serial_core]
>  [<d1bd9559>] unregister_serial+0x19/0x20 [8250]
>  [<d1bcb2de>] acpi_serial_remove+0x2e/0x50 [8250_acpi]
>  [<c02523f0>] acpi_driver_detach+0xcc/0x184
>  [<c0252621>] acpi_bus_unregister_driver+0x18/0x168
>  [<d1bcb312>] acpi_serial_exit+0x12/0x14 [8250_acpi]
>  [<c014510f>] sys_delete_module+0x13f/0x160
>  [<c0166307>] sys_munmap+0x57/0x80
>  [<c010a14f>] syscall_call+0x7/0xb

acpi_driver_detach is calling the acpi_driver.remove() method under
the acpi_device_lock spinlock.

uart_unregister_port() happens to be using a semaphore for its locking.

I do think that it would be better if ACPI were to permit this.  From a
quick peek it appears that acpi_device_lock can simply become a semaphore?



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
