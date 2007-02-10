From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.21
Date: Sat, 10 Feb 2007 14:39:27 -0200
Message-ID: <20070210163927.GA489@khazad-dum.debian.net>
References: <200702071418.51058.lenb@kernel.org> <200702101027.25372.ismail@pardus.org.tr> <20070210120713.GA31473@homac2> <200702101752.14797.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:57375 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750910AbXBJQju (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 10 Feb 2007 11:39:50 -0500
Content-Disposition: inline
In-Reply-To: <200702101752.14797.ismail@pardus.org.tr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Sat, 10 Feb 2007, Ismail D=F6nmez wrote:
> Hmmf looks like a userspace bug, but it certainly did work before ACP=
I update.

Well, I don't know if this is the case here, but after reading the user=
land
code that people use on most applets to read /proc/acpi/ibm, I was upse=
t and
disgusted for days.

Some userland code *deserves* to be broken with extreme prejudice.

--=20
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
