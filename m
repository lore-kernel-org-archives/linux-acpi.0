From: Gregory Gulik <greg-eIr5aKVv5JjYtjvyW6yDsg@public.gmane.org>
Subject: Re: Newbie looking to try latest ACPI support...
Date: Mon, 09 Dec 2002 15:20:30 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DF4FB0E.7060701@gulik.org>
References: <3DF20AB4.3020205@gulik.org> <20021209105144.GB26375@poup.poupinou.org> <3DF4A0F4.6060103@gulik.org> <20021209140714.H20336@parcelfarce.linux.theplanet.co.uk> <3DF4A54F.2030400@gulik.org> <3DF4B2F6.6070400@gulik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3DF4B2F6.6070400-eIr5aKVv5JjYtjvyW6yDsg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Still no joy...

Even tough everything "seemed" to compile and install I can't load my 
ACPI modules.  Any time I try I get stuff like this:

[root@toshiba1115 root]# insmod battery 2>&1 | more
/lib/modules/2.4.20/kernel/drivers/acpi/battery.o: unresolved symbol 
acpi_get_handle_R2bfeb410
/lib/modules/2.4.20/kernel/drivers/acpi/battery.o: unresolved symbol 
acpi_ut_exit_R4403d3ee
/lib/modules/2.4.20/kernel/drivers/acpi/battery.o: unresolved symbol 
acpi_os_free_R43b9bbb4
/lib/modules/2.4.20/kernel/drivers/acpi/battery.o: unresolved symbol 
acpi_extract_package_R06f4a82a
/lib/modules/2.4.20/kernel/drivers/acpi/battery.o: unresolved symbol 
acpi_ut_trace_R8d457864
/lib/modules/2.4.20/kernel/drivers/acpi/battery.o: unresolved symbol 
acpi_remove_notify_handler_R2bb55d6e
/lib/modules/2.4.20/kernel/drivers/acpi/battery.o: unresolved symbol 
acpi_ut_value_exit_Rdcbde352
/lib/modules/2.4.20/kernel/drivers/acpi/battery.o: unresolved symbol 
acpi_evaluate_object_R39f1a5dc
/lib/modules/2.4.20/kernel/drivers/acpi/battery.o: unresolved symbol 
acpi_bus_get_status_Redecd2bd
/lib/modules/2.4.20/kernel/drivers/acpi/battery.o: unresolved symbol 
acpi_ut_debug_print_Rac38b5ca
/lib/modules/2.4.20/kernel/drivers/acpi/battery.o: unresolved symbol 
acpi_bus_generate_event_R03047640
...and so on...

I even logged the output of "make modules" and checked the acpi stuff 
and there is no sign of any kinds of errors...


-- 
Greg Gulik                                 http://www.gulik.org/greg/
greg @ gulik.org                           http://www.drivingevents.com/




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
