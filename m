From: Takayoshi Kochi <kochi-PTg2hmCz6mgYz5ZhgtY7qeqrae++aQT8@public.gmane.org>
Subject: Re: [Pcihpd-discuss] HotSwap PCI OK, HotPlug NOK kernel 2.6.0
Date: Thu, 25 Sep 2003 11:25:54 +0900 (JST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030925.112554.74755648.kochi@hpc.bs1.fc.nec.co.jp>
References: <OF61C2F779.8EF0972B-ONC1256DAA.003357AC@frec.bull.fr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <OF61C2F779.8EF0972B-ONC1256DAA.003357AC-4ZAmCnR/+QsUrb4e85K3Fw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: michel.bouley-6ktuUTfB/bM@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, pcihpd-discuss-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Michael,

From: michel.bouley-6ktuUTfB/bM@public.gmane.org
Subject: [Pcihpd-discuss] HotSwap PCI OK, HotPlug NOK kernel 2.6.0
Date: Tue, 23 Sep 2003 11:45:46 +0200

> I am working on Tiger (Intel chipset 870) :
> - with kernel 2.5.75 and with "ACPI PCI Hotplug driver", closing latch on
> slot PCI light led of slot in green and  allow "Device Hot Plug PCI" (and
> Device Hot Swap)
> - with kernel 2.6.0-test[4-5] and with "ACPI PCI Hotplug driver", closing
> latch on slot PCI light led of slot in orange and allow "Device Hot Swap
> PCI" only.

I don't think the difference is due to any changes in the kernel
between 2.5.75 and 2.6.0-testX.  I guess it's due to the difference
of your two tests (such as which slots are already populated, which
slot you are trying to test, or the type of the card).
Could you check if the two conditions are same (except the kernels)?

This is background:

As the ACPI interface doesn't have any standardized method to
set the bus frequency, if you put a PCI (for example, 33MHz) card
on a PCI-X (for example, running at 100MHz) bus, it will cause
frequency/bus protocol mismatch.
On Tiger, you will see the amber light on, which indicates
that mismatch.

If you don't use the driver that intel has (not yet included in the
kernel source tree), you can't make full Hot-Plug features work on Tiger.
The ACPI BIOS on Tiger provides limited capability of controlling
the slots (bus protocol/frequency).

It seems to me that Tiger sets all busses to the highest
possible speed/protocol combination on power-on.  So if you don't
put a PCI 33MHz card on a slot at power-on, the slot will run at
133MHz or 100MHz PCI-X, which will reject hot-addition of any
PCI-only cards.  If a card is PCI/PCI-X capable and can be run at any
frequency (33MHz-133MHz), probably its hot-addition will always
succeed because the card adjusts itself to the bus speed.

If the implementation of platform/ACPI BIOS is smarter, the platform
may set a bus to the highest possible speed/protocol combination
when a new-card is inserted, but such a behavior is platform-dependent
and is not guaranteed.

---
Takayoshi Kochi


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
