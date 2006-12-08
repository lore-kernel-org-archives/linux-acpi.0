From: Frank Ursel <listadress@gmx.net>
Subject: Re: suspend to RAM on lifebook 7110
Date: Fri, 8 Dec 2006 13:33:58 +0100
Message-ID: <20061208123358.GA3724@invalid.invalid>
Reply-To: 20061207221831.GA31419@erebor.ics.muni.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:57676 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1425461AbWLHMeC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Dec 2006 07:34:02 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: ruda@ics.muni.cz

Hi,

> ram - suspend/resume using s2ram works fine, but display remains nearly 
> black. I can see very hardly what's on display, but machine including
> network works fine.

After resume the backlight remains off. All other stuff is working, but
whitout backlight its a bit hard to work :-) I have the same Lifebook
and for me the following is working very well:

Before i actually suspend the notebook, i write some data about the
graphic card on disk and on resume the data is written back to the
graphic card and everything works fine (I'm writing only the relevant
parts in here):

 # discover video card's ID
 ID=`lspci | grep VGA | awk '{ print $1 }' | sed -e 's@0000:@@' -e 's@:@/@'`

 # dump current data from the video card to the temporary file
 cat /proc/bus/pci/$ID > $TMP_FILE

 # suspend
 echo -n mem > /sys/power/state

 # restore video card data from the temporary file
 # on resume
 cat $TMP_FILE > /proc/bus/pci/$ID

Note: This works fine for me in a script, which is invoked by acpi on
      button-press. I'm using Debian/SID and i don't know where the right
      place for manipulation on Suse is. Maybe you need to tweek a bit
      ;-)

HTH,
Frank
