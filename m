From: Nate Lawson <nate@root.org>
Subject: acpi-ca reports \_SB as a device
Date: Sat, 08 Jan 2005 01:05:24 -0800
Message-ID: <41DFA254.8090704@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-freebsd-acpi@freebsd.org>
List-Unsubscribe: <http://lists.freebsd.org/mailman/listinfo/freebsd-acpi>,
	<mailto:freebsd-acpi-request@freebsd.org?subject=unsubscribe>
List-Archive: <http://lists.freebsd.org/pipermail/freebsd-acpi>
List-Post: <mailto:freebsd-acpi@freebsd.org>
List-Help: <mailto:freebsd-acpi-request@freebsd.org?subject=help>
List-Subscribe: <http://lists.freebsd.org/mailman/listinfo/freebsd-acpi>,
	<mailto:freebsd-acpi-request@freebsd.org?subject=subscribe>
Sender: owner-freebsd-acpi@freebsd.org
Errors-To: owner-freebsd-acpi@freebsd.org
To: ACPI Developers <acpi-devel@lists.sourceforge.net>
Cc: acpi@FreeBSD.org
List-Id: linux-acpi@vger.kernel.org

If you call AcpiGetType on \_SB, you get "device" and \_TZ gives 
"thermal".  I don't think this is valid since these are system scopes, 
not devices and thermal zones.

I found this while testing a patch that scans the whole namespace (\) 
for devices.  It turns out some systems put PCI link devices (PNP0C0F) 
in \, so we weren't probing them.

-- 
Nate
