From: Detlef Lechner <detlef.lechner@gmx.net>
Subject: [Debian etch, Medion MD97600] HAL failes to hibernate
Date: Mon, 05 Feb 2007 23:14:23 +0100
Message-ID: <1170713665.3849.89.camel@MD97600>
Reply-To: detlef.lechner@gmx.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:52291 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964927AbXBEWOH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Feb 2007 17:14:07 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mailingliste linux-acpi <" linux-acpi"@vger.kernel.org>

Hello Newsgroup,

if I right-cklick on my Gnome Power Manager version 2.14.3 icon and
choose 'Tiefschlafmodus'/'Hibernate' my Medion MD97600 laptop computer
will show a black screen but apparently nothing else changes. If I move
the cursor into the center of the screen, a login dialog appears. After
the login a warning appears: "Hibernate problem. HAL failed to
hibernate." 
My ACPI functions partially: The computer reacts to varying processor
loads by jumping between ACPI states C1, C2 and C3. My computer
configuration is documented in
http://www.ubuntuusers.de/paste/7306/
http://www.ubuntuusers.de/paste/7308/
http://www.ubuntuusers.de/paste/7309/
http://www.ubuntuusers.de/paste/7310/
http://www.ubuntuusers.de/paste/7311/
Th computer uses a Intel host bridge 915GM and Intel82801.
How can I persuade my computer to suspend and to hibernate?

Regards,
Detlef 

-- 
Debian 4.0 "etch" Linux 2.6.17-grml#1 SMP PREEMPT 2006-07-25 i686
GNOME 2.14.3, Epiphany 2.14.3, Evolution 2.6.3, OO.o ODE 680_m4 Build-1
MD97600, WinXP MCE 2005

