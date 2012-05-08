From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [Resend PATCH V2 3/7] usb: Set device removable state based on
 ACPI USB data
Date: Tue, 08 May 2012 16:52:25 +0800
Message-ID: <4FA8DEC9.7010603@intel.com>
References: <1336100803-28353-1-git-send-email-tianyu.lan@intel.com> <1336100803-28353-4-git-send-email-tianyu.lan@intel.com> <201205040824.17010.oneukum@suse.de> <4FA72787.5000106@intel.com> <20120507165744.GA28045@kroah.com> <20120508025817.GB23448@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57510 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241Ab2EHI5e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 May 2012 04:57:34 -0400
In-Reply-To: <20120508025817.GB23448@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Oliver Neukum <oneukum@suse.de>, lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mfm@muteddisk.com, Greg KH <gregkh@linuxfoundation.org>

Hi all:

=46ollowing is the usb port descriptor in the DSDT of Thinkpad T410.
The port is attached with bluetooth on the board.

                       Device (PRTB)
                        {    =20
                            Name (_ADR, 0x04)=20
                            Name (_UPC, Package (0x04)
                            {    =20
                                0xFF,=20
                                0xFF,=20
                                0x00,=20
                                0x00 =20
                            })   =20
                            Name (_PLD, Buffer (0x10)
                            {    =20
                                /* 0000 */    0x81, 0x00, 0x00, 0x00,=20
0x00, 0x00, 0x00, 0x00,
                                /* 0008 */    0x30, 0x1C, 0x00, 0x00,=20
0x00, 0x00, 0x00, 0x00
                            })   =20
                        }
_PLD buffer show the device internal port.    =20
Bit 64 =E2=80=93 User Visible: Set if the device connection point can b=
e seen=20
by the user without disassembly.

=E4=BA=8E2012=E5=B9=B405=E6=9C=8808=E6=97=A5 =E6=98=9F=E6=9C=9F=E4=BA=8C=
 10=E6=97=B658=E5=88=8617=E7=A7=92,Matthew Garrett=E5=86=99=E5=88=B0:
> On Mon, May 07, 2012 at 09:57:44AM -0700, Greg KH wrote:
>> On Mon, May 07, 2012 at 09:38:15AM +0800, Lan Tianyu wrote:
>>> This depends on the bios. From my opinion, the bluetooth is device =
on the
>>> motherboard so it belongs to hard-wired type.
>>
>> That's nice, but it's not what is happening in lots of different lap=
tops
>> out there today.
>>
>> Oliver is right, how does this handle bluetooth USB controllers that=
 are
>> turned on/off from magic function-key presses?
>
> I /believe/ that such devices will be indicated as fixed rather than
> removable. The variable indicates the physical state rather than the
> logical one - fixed doesn't mean that a device will never go away, it
> means that a user can't physically unplug it.
>



--=20
Best Regards
Tianyu Lan
linux kernel enabling team
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
