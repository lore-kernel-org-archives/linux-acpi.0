From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: 3 EC issues
Date: Wed, 27 May 2015 05:57:12 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802722BB5@SHSMSX101.ccr.corp.intel.com>
References: <1AE640813FDE7649BE1B193DEA596E8802721032@SHSMSX101.ccr.corp.intel.com>
 <555FCA6E.1030806@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:61000 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752535AbbE0F7k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 May 2015 01:59:40 -0400
In-Reply-To: <555FCA6E.1030806@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Brown, Len" <len.brown@intel.com>
Cc: "Box, David E" <david.e.box@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, "Lu, Aaron" <aaron.lu@intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "Huang, Ying" <ying.huang@intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Du, Julie" <julie.du@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi,

Let me Cc intel power management and ACPI mailing list to discuss this widely.

On Samsung platforms, test result shows when SCI_EVT is not set, a QR_EC can result in a real event value (non-0x00) returned.
And after system is resumed, SCI_EVT may not be flagged while OSPM still need to send QR_EC.
We have an EC_FLAGS_CLEAR_ON_RESUME quirk to handle this.

On kernel Bugzilla reported platforms (Lenovo, Acer), firmware will stop responding occasionally if SCI_EVT is not set.
We have an EC_FLAGS_QUERY_HANDSHAKE quirk to handle them.

It looks to me the 2 behavior is conflict.
For Samsung, QR_EC need to be issued even when SCI_EVT is not set.
While for the latter platforms, QR_EC shouldn't be issued if SCI_EVT is not set.

Also IMO, the EC_FLAGS_QUERY_HANDSHAKE platforms are dangerous, it looks their firmware will be more likely to get stuck as the SCI_EVT behavior is not standardized.

Unlike the EC transaction state machine, it is hardly to write a single state machine to control the conflict behavior.
Thus I have to guess Windows just handle the SCI_EVT in a specific way that happens to work for both cases.

To handle SCI_EVT, OSPM should know when the SCI_EVT will be cleared by the firmware.

Unfortunately, the ACPI specification only has following 2 paragraphs talking SCI_EVT and none of them has defined this:

12.2.1 Embedded Controller Status, EC_SC (R)
The SCI event (SCI_EVT) flag is set when the embedded controller has detected an internal event that requires the operating system's attention. The embedded controller sets this bit in the status register, and generates an SCI to OSPM. OSPM needs this bit to differentiate command-complete SCIs from notification SCIs. OSPM uses the query command to request the cause of the SCI_EVT and take action. For more information, see Section 12.3, "Embedded Controller Command Set.")

12.3.5 Query Embedded Controller, QR_EC (0x84)
OSPM driver sends this command when the SCI_EVT flag in the EC_SC register is set. When the embedded controller has detected a system event that must be communicated to OSPM, it first sets the SCI_EVT flag in the EC_SC register, generates an SCI, and then waits for OSPM to send the query (QR_EC) command. OSPM detects the embedded controller SCI, sees the SCI_EVT flag set, and sends the query command to the embedded controller. Upon receipt of the QR_EC command byte, the embedded controller places a notification byte with a value between 0-255, indicating the cause of the notification. The notification byte indicates which interrupt handler operation should be executed by OSPM to process the embedded controller SCI. The query value of zero is reserved for a spurious query result and indicat
 es "no outstanding event."

None of them has definitions around the timing that the SCI_EVT should be cleared.
Following may be possible (from earliest to latest, and should be initiated from a firmware step):
  1. After firmware noticing an EC_SC access - since OSPM should have seen the SCI_EVT.
  2. After firmware noticing an none-empty input pipe filled with QR_EC - since OSPM has explicitly acknowledged the event by the QR_EC command.
  3. After firmware writing the event value to the output pipe - since OSPM is ensured to see the returned event value to query.
  4. After firmware noticing an empty output pipe - since OSPM is ensured to have obtained the returned event value to query.
  5. After OSPM evaluating _Qxx - EVT_SCI may be implemented in the "condition" way and cleared after the condition has been changed.

In order to handle both firmware variation, Windows should have prepared QR_EC in the way that
1. can ensure additional QR_EC is issued for Samsung - when the SCI_EVT is checked again, it should have still be flagged so that a "draining QR_EC" can be issued.
2. can ensure no additional QR_EC is issued for Lenovo/Acer - when the SCI_EVT is checked again, it must be cleared by the firmware.

So if we can know the expected behavior of Windows, we may be able to work out the correct solution.

Thanks and best regards
-Lv


> From: Wysocki, Rafael J
> Sent: Saturday, May 23, 2015 8:32 AM
> 
> Len,
> 
> It appears that we need to know what the Windows EC driver expects from
> the firmware.
> 
> Who's the first point of contact for that?
> 
> Rafael
> 
> 
> On 5/22/2015 9:33 AM, Zheng, Lv wrote:
> > Hi, Bob and Rafael
> >
> > I have 3 ACPI bugs related to the EC event handling mechanism.
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=98111
> > https://bugzilla.kernel.org/show_bug.cgi?id=97381
> > https://bugzilla.kernel.org/show_bug.cgi?id=94411
> >
> > So it might be urgent to handle them.
> >
> > Currently the EC driver checks EVT_SCI flag right after QR_EC write so that EVT_SCI can be ensured to be set for Samsung platforms
> and the 2nd QR_EC can be issued to drain the event (on Samsung platform, 0x00 will be returned to indicate no further events). This
> logic is tricky.
> >
> > After seeing so many conflicts, I guess windows will start a deferred context to send QR_EC, evaluate _Qxx sequentially.
> > For Samsung platform, I knew an 0x00 return value of QR_EC can terminate the process and Samsung platform really need driver to
> poll until 0x00 is returned.
> >
> > But on other platforms, we may see non 0x00 value returned from BIOS, then I don't know how can I terminate the process on such
> platforms.
> >
> > IMO, the conflict is there due to the asynchrony the firmware has implemented.
> > It looks the firmware that won't be broken due to our current behavior is handled in the fully asynchronous way.
> > And the above platforms have several commands handled in the synchronous way.
> >
> > Thus it's hard for me to determine what's the preferred behavior (thus the default OS EC driver behavior) Windows EC driver has
> expected on the firmware.
> > Do we have spec contact or Windows contact to clarify this?
> >
> > Thanks and best regards
> > -Lv

