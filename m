From: Johannes Engel <j-engel@gmx.de>
Subject: Re: Suspend2RAM Asus V6V
Date: Tue, 15 May 2007 00:40:25 +0200
Message-ID: <20070515004025.a4533bbd.j-engel@gmx.de>
References: <463BC369.7010309@gmx.de>
	<20070506225824.GA14463@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:51216 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754775AbXENWj4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 May 2007 18:39:56 -0400
In-Reply-To: <20070506225824.GA14463@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: linux-acpi@vger.kernel.org

On Mon, 7 May 2007 00:58:24 +0200
Norbert Preining <preining@logic.at> wrote:

> Hi Johannes,
> 
> On Sam, 05 Mai 2007, Johannes Engel wrote:
> > Switching the laptop on again hitting the power button (other buttons do
> > not show any effect) the cdrom drive gets initialised, the harddisk led
> > gets switched on but the screen remains black and the laptop hangs
> > completely (no keystroke accepted, even not Magic SysRq keys).
> 
> I have the same problem, and tried to debug it with net console, with
> minimal kernel configs, with init=/bin/bash, with all the combinations,
> to no avail. I did submit a bug report to the resepctive bug tracker but
> it looks like nobody is caring for this kind of stuff.
OK, I investigated further with the following result:
Bios 0401 works quite well.
BIOS >=1001 seems to introduce a bug: s2ram does not work any more.
Since I do not have a BIOS between 04 and 10 (especially 0602 or 0801a) I cannot test the versions inbetween. If someone can provide me one of these versions I will try to hunt down the error which possibly resides in the DSDT.

Greetings, Johannes
-- 
Johannes Engel <j-engel@gmx.de>
