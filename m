From: Gregory Gulik <greg-eIr5aKVv5JjYtjvyW6yDsg@public.gmane.org>
Subject: Re: Newbie looking to try latest ACPI support...
Date: Mon, 09 Dec 2002 08:56:04 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DF4A0F4.6060103@gulik.org>
References: <3DF20AB4.3020205@gulik.org> <20021209105144.GB26375@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021209105144.GB26375-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


I ended up upgrading my kernel to 2.4.20 and applied the 
acpi-20021205-2.4.20.diff.

I turned off APM and chose the following ACPI related kernel config options:

# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_ACPI=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUSMGR=m
CONFIG_ACPI_SYS=m
CONFIG_ACPI_CPU=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_AC=m
CONFIG_ACPI_EC=m
CONFIG_ACPI_CMBATT=m
CONFIG_ACPI_THERMAL=m

For some reason no modules were installed in /lib/modules/2.4.20:

[root@toshiba1115 linux-2.4.20]# find /lib/modules/2.4.20 -name '*acpi*' 
-print
[root@toshiba1115 linux-2.4.20]#

Just to make sure I started over and did it again.  Same thing.
I'm sure I'm missing just one simple step.



Ducrot Bruno wrote:
> This one have know bug.  Try a more recent one.
> 

-- 
Greg Gulik                                 http://www.gulik.org/greg/
greg @ gulik.org                           http://www.drivingevents.com/




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
