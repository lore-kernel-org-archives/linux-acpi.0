From: Yaroslav Rastrigin <yarick-343whMTK1pU@public.gmane.org>
Subject: ACPI + 3c556 - the saga continues
Date: Wed, 16 Jul 2003 14:04:33 +0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F152331.9080803@relex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI-Devel mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi everyone.

Well, encouraged by utter silence on my questions (some of them were lame, I
have to admit :-), I've continued my investigations.
Turns out, DSTD in my laptop (IBM ThinkPad T21) is somewhat screwed.
I've hand-applied custom-DSDT patch
(I'm running 2.6.0-test1-ac1 + 20030714 ACPI rev.), and started playing with DSDT.
To make long story short - my network card now kinda works with ACPI. What do
I mean:
When I'm booting with ACPI enabled, lspci -vv shows correct values (Regions,
IRQ and other info) for the NIC , but after loading NIC driver fails to read
device configuration (loads garbage, 0xFF in every byte read from card's
conf), and network doesnt work.
rmmod 3c59x, then I'm feeding
setpci -s 00:03.00 BASE_ADDRESS_0=0x1801
(PCI data was taken from good working APM boot),
modprobe 3c59x
and magically NIC is OK.
It turns out offending _INI code is:
/*
If (And (PAM1, 0x03))
{
	Store (0x00, C0LN)
}
If (And (PAM1, 0x30))
{
	Store (0x00, C4LN)
}
If (And (PAM2, 0x03))
{
	Store (0x00, C8LN)
}
*/
Where C?LN are defined as
CreateDWordField (_CRS, 0x68, C0LN)
CreateDWordField (_CRS, 0x82, C4LN)
CreateDWordField (_CRS, 0x9C, C8LN)

inside Device (PCI0)
and PAM?s are:
OperationRegion (X000, PCI_Config, 0x00, 0x0100)
Field (X000, DWordAcc, NoLock, Preserve)
{
                 Offset (0x59),
                 PAM0,   8,
                 PAM1,   8,
                 PAM2,   8,
		.....
}

(My DSDT can be found at
http://www.relex.ru/~yarick/acpi/DSDT.dsl
)

I'm not a PCI programming guru (yet ?), so new questions are:
what's going on here ? Where or how could I find  which PCI registers are
overwritten by aforementioned three Store's ? I think I could write custom
_INI for my NIC, but could someone help me to start ?

And another question:
What conditions should be met for ACPI event to appear in /proc/acpi/event ?
When I'm manually triggering LID microswitch ,f.e,  I'm seeing lot's of ACPI
activity in logs (with upped debug level), and I could see _LID method
executed, but nothing appears in /proc/acpi/event, and I can't make acpid
to suspend machine when LID is closed.
Moreover, there are no events in /proc/acpi/event at all, alhough ACPI
subsystem notices and handles them. Did I screwed something in my setup , and
if yes, then what to look for ?

With all the best, yarick at relex dot ru




-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
