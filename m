From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Subject: usblp suspend failure with 2.6.15-rc5
Date: Tue, 06 Dec 2005 19:54:31 +0100
Message-ID: <4395DE67.4050101@gmx.net>
References: <438F3A2F.5090207@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <438F3A2F.5090207@gmx.net>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: acpi-devel <acpi-devel@lists.sourceforge.net>, linux-usb-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hi,

since I switched to 2.6.15-rc2-git6, my machine is not able to suspend
anymore if my USB printer is plugged in. The problem is reproducible.

usb 1-2: new full speed USB device using uhci_hcd and address 3
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 0 proto 2 vid 0x04E8 pid 0x3242
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
PM: Preparing system for mem sleep
Stopping tasks: ==================================================|
usblp 1-2:1.0: no suspend?
Could not suspend device 1-2: error -16
Some devices failed to suspend
Restarting tasks... done


Earlier kernels (2.6.14.2 and before) worked just fine.

A first search suggests this problem was introduced between
2.6.14 and 2.6.15-rc2-git6. Should I try to narrow it down further?


Regards,
Carl-Daniel


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
