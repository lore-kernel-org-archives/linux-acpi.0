From: Karol Kozimor <sziwan@hell.org.pl>
Subject: hci_uart status and oddities
Date: Wed, 2 Mar 2005 00:44:38 +0100
Message-ID: <20050301234438.GA28724@hell.org.pl>
Reply-To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
To: marcel@holtmann.org, maxk@qualcomm.com
Cc: bluez-devel@lists.sf.net, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hi,

[ACPI guys: please skip the first part]

I have a 3Com 3CRWB6096B Bluetooth PC Card (rev. 3) that sports 2 UARTs:
kernel: ttyS4 at I/O 0x100 (irq = 3) is a 16C950/954
kernel: ttyS5 at I/O 0x108 (irq = 3) is a 8250

The first thing I need to ask is: is it possible to obtain speeds higher
than 115200 bps? hciattach /dev/ttyS4 csr 460800 succeeds, but hciconfig
will just show zeros and the card would need replugging to work again.

The second thing I realized only recently, when I tried to determine why BT
is so unreliable under 2.6. As it seems, this specific card is unable to
work when the processor enters ACPI C3 state (a low power processor state
with bus master arbitration disabled). The effect is lots of messages like:
h4_recv: Unknown HCI packet type 3e
or:
hci_cmd_task: hci0 command tx timeout                                                               

Once C3 is disabled (by any bus master activity, a plain USB mouse works),
the card works fine. Since it's a PC Card, I'm at a loss at whether the
card actually uses any DMA of some sort, or anything that could be remotely
related to bus mastering. All that I know is that there is some hardware
that has troubles with C3 (see ipw2100).

I'm CCing acpi-devel in hope that someone will be able to at least state
whether it is a driver or a hardware problem. Or perhaps it is something
specific to PC Cards or yenta in general?

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
